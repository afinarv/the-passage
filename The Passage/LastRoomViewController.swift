//
//  LastRoomViewController.swift
//  Fear Mini Challenge
//
//  Created by Agatha Rachmat on 22/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import AudioToolbox
import Photos

class LastRoomViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var imgOverlay = UIImageView()
    var overlayView = UIImageView()
    var cameraImage = UIImage()
    var device : AVCaptureDevice?
    var input : AVCaptureDeviceInput?
    var captureSession: AVCaptureSession?
    var previewlayer: AVCaptureVideoPreviewLayer?
    var image = UIImage(named: "SetanRuang3.png")
    var walls = UIImage(named:"wall.png")

    var photoResult: UIImage?
    var resultImageView = UIImageView()
    var screenSize = CGSize()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = self.view.frame.size
        resultImageView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)

        setupCamera()
        setupTimer()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.size.width - 150, y: 50, width: 100, height: 40)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Credits", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            self.view.addSubview(button)
        }
    }

    func setupCamera()
    {   let width = view.layer.frame.width
        let height = view.layer.frame.height

        imgOverlay = UIImageView(image: image!)
        imgOverlay.contentMode = .scaleAspectFill
        imgOverlay.frame = CGRect(x: 30, y: 40, width: 400, height: 310)
        imgOverlay.alpha = 1
        imgOverlay.backgroundColor = nil
        
        let dark = UIView()
        dark.backgroundColor = UIColor.black
        dark.alpha = 0.5
        dark.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        overlayView = UIImageView(image: walls!)
        overlayView.alpha = 1
        overlayView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        _ = AVCaptureDevice.DiscoverySession(deviceTypes:[.builtInWideAngleCamera], mediaType: .video, position: .front)
        
        
        captureSession = AVCaptureSession()
        let device = AVCaptureDevice.default(.builtInWideAngleCamera,for: AVMediaType.video, position: .front)
        
        
        guard let input = try? AVCaptureDeviceInput(device: device!)
            else        { print("error")
                return
        }
        
        
        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        
        let queue = DispatchQueue(label: "cameraQueue")
        output.setSampleBufferDelegate(self, queue: queue)
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as!String: kCVPixelFormatType_32BGRA]
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input)
        captureSession?.addOutput(output)
        captureSession?.sessionPreset = AVCaptureSession.Preset.photo
        previewlayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        
        previewlayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewlayer?.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        previewlayer?.cornerRadius = 5
        previewlayer?.borderWidth = 3
        previewlayer?.borderColor = UIColor.darkGray.cgColor
        previewlayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        self.view.layer.addSublayer(previewlayer!)
        self.view.addSubview(imgOverlay)
        
        self.view.addSubview(dark)
        self.view.addSubview(overlayView)
        
  
        
        
        captureSession?.startRunning()
        
    }
    
    @objc func buttonClicked() {
        print("button click")
        guard let creditsVC = self.storyboard?.instantiateViewController(withIdentifier: "creditsScene") else {return}
        self.present(creditsVC, animated: true, completion: nil)
//        if let url = URL(string: "itms-apps://itunes.apple.com/"){
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
    }
    
    
    //MARK Capture Output
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        CVPixelBufferLockBaseAddress(imageBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let baseAddress = UnsafeMutableRawPointer(CVPixelBufferGetBaseAddress(imageBuffer!))
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer!)
        let widthImage = CVPixelBufferGetWidth(imageBuffer!)
        let heightImage = CVPixelBufferGetHeight(imageBuffer!)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let newContext = CGContext(data: baseAddress, width: widthImage, height: heightImage, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let newImage = newContext!.makeImage()
        cameraImage = UIImage(cgImage:newImage!)
        
        CVPixelBufferUnlockBaseAddress(imageBuffer!, CVPixelBufferLockFlags(rawValue: 0))
    }
    
    
    //MARK Timer
    func setupTimer()
    {
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(snapshot), userInfo: nil, repeats: false)
    }
    
    //MARK Photo
    @objc func snapshot(){
        print("snapshot")
        UIImageWriteToSavedPhotosAlbum(cameraImage, nil, nil, nil)
        
        vibrate()
        
        photoResult = cameraImage
        
        UIGraphicsBeginImageContextWithOptions(screenSize, false, UIScreen.main.scale)
        
        let area = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        photoResult?.draw(in: area)
        image?.draw(in: CGRect(x: 30, y: 20, width: 400, height: 310))
        walls?.draw(in: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        // self.view.bringSubview(toFront:)
        guard let resultImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        print("asd")
        resultImageView.image = resultImage
        
        try? PHPhotoLibrary.shared().performChangesAndWait {
            PHAssetChangeRequest.creationRequestForAsset(from: resultImage)
        }
        //
    }
    
    
    
    //MARK VIbrate
    func vibrate(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
