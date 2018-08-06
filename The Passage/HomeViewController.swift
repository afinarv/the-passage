//
//  HomeViewController.swift
//  Fear Mini Challenge
//
//  Created by Afina R. Vinci on 18/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import Photos

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeImgView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var corridorImgView: UIImageView!
    @IBOutlet weak var corridorContainerView: UIView!
    
    //MARK: - zooming passcode properties
    @IBOutlet weak var zoominlockImgView: UIImageView!
    @IBOutlet weak var zoominlockContainerView: UIView!
    @IBOutlet weak var numberPressedLabel: UILabel!
    @IBOutlet weak var numberPadContainer: UIView!
    var numberPadTapped : UITapGestureRecognizer!
    var numberPad = [[UIView]]()
    var numberPressed : String = ""
    var numberPressedCount : Int = 0
    var width : CGFloat = 0
    var height : CGFloat = 0
    
    var audioPlayer0 = AVAudioPlayer()
    var audioPlayer1 = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()
    
    var hasOpened = false
    var hasOpened2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization({status in
            if status == .authorized{
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        print("allowed")
                        
                    } else {
                        print("Access Denied")
                    }
                }
                
            } else {
                print("Not allowed")
            }
        })
        
        
        playAudio()
        let startGesture = UITapGestureRecognizer(target: self, action: #selector(zooming))
        corridorContainerView.addGestureRecognizer(startGesture)
        
        let zoomoutTap = UITapGestureRecognizer(target: self, action: #selector(zoomout))
        zoominlockImgView.addGestureRecognizer(zoomoutTap)
        zoominlockImgView.isUserInteractionEnabled = true

        generateNumberPad()
        numberPadTapped = UITapGestureRecognizer(target: self, action: #selector(printNumber))
        numberPadContainer.isUserInteractionEnabled = true
        numberPadContainer.addGestureRecognizer(numberPadTapped)
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coverView.alpha = 1
        coverView.isHidden = false
        UIView.animate(withDuration: 2, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 0
        })
        if hasOpened2 {
            showScreenshotEffect()
        }
    }
    
    //MARK: - zooming corridor
    @objc func zooming() {
        coverView.alpha = 1
        UIView.animate(withDuration: 5, delay: 0, options: .curveLinear, animations: {
            self.corridorContainerView.transform = CGAffineTransform(scaleX: 3, y: 3)
        }) { (true) in
            UIView.animate(withDuration: 2, animations: {
                self.coverView.alpha = 0
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 2, delay: 3, options: .curveLinear, animations: {
            self.corridorContainerView.alpha = 0
        }, completion: nil)
        
        
    }
    
    //MARK: - blink effect
    
    func showScreenshotEffect() {
        
        let snapshotView = UIView()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(snapshotView)
        //view.bringSubview(toFront: snapshotView)
        //let n = view.subviews.count
        view.insertSubview(snapshotView, at: 1)
        
        let constraints:[NSLayoutConstraint] = [
            snapshotView.topAnchor.constraint(equalTo: view.topAnchor),
            snapshotView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snapshotView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            snapshotView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        snapshotView.backgroundColor = UIColor.black
        snapshotView.alpha = 0.0
        
        UIView.animate(withDuration: 2.2, animations: {
            snapshotView.alpha = 0.8
        }) { _ in
            UIView.animate(withDuration: 2.2, animations: {
                snapshotView.alpha = 0.0
            }, completion: { (true) in
                self.showScreenshotEffect()
            })
            //snapshotView.removeFromSuperview()
        }
    }
    
    //MARK: - audio playing
    func playAudio() {
        let path = Bundle.main.path(forResource:"darkshadow", ofType:"mp3")
        let url = URL(fileURLWithPath: path!)
        do {
            audioPlayer0 = try AVAudioPlayer(contentsOf: url)
            audioPlayer0.play()
            audioPlayer0.numberOfLoops = -1
        } catch {
            print("cant play audio")
        }
    }
    
    func playAudio1() {
        let path = Bundle.main.path(forResource:"inmynightmare", ofType:"m4a")
        let url = URL(fileURLWithPath: path!)
        do {
            audioPlayer1 = try AVAudioPlayer(contentsOf: url)
            audioPlayer1.play()
            audioPlayer1.numberOfLoops = -1
        } catch {
            print("cant play audio")
        }
    }
    
    func playAudio2() {
        let path = Bundle.main.path(forResource:"horror", ofType:"m4a")
        let url = URL(fileURLWithPath: path!)
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: url)
            audioPlayer2.play()
            audioPlayer2.numberOfLoops = -1
        } catch {
            print("cant play audio")
        }
    }
    
    func playAudio3() {
        let path = Bundle.main.path(forResource:"scream", ofType:"mp3")
        let url = URL(fileURLWithPath: path!)
        do {
            audioPlayer3 = try AVAudioPlayer(contentsOf: url)
            audioPlayer3.play()
            //audioPlayer3.numberOfLoops = 1
        } catch {
            print("cant play audio")
        }
    }
    
    
    @IBAction func enterFirstSecondRoom(_ sender: UIButton) {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
        
        if hasOpened {
            if sender.tag == 0 {
                performSegue(withIdentifier: "toFirstRoom", sender: self)
            } else {
                performSegue(withIdentifier: "toSecondRoom", sender: self)
                hasOpened2 = true
            }
        } else {
            sender.tag = 0
            hasOpened = true
            performSegue(withIdentifier: "toFirstRoom", sender: self)
        }
    }
    
    @IBAction func enterFinalRoom(_ sender: UIButton) {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveLinear, animations: {
            self.homeImgView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (true) in
            self.zoominlockContainerView.isHidden = false
            UIView.animate(withDuration: 2, animations: {
                self.coverView.alpha = 0
            })
        }
        UIView.animate(withDuration: 1, delay: 0.5, animations: {
            self.coverView.alpha = 1
        }, completion: { (true) in
            
        })
    }
    
    @objc func zoomout() {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveLinear, animations: {
            self.coverView.alpha = 1
        }) { (true) in
            self.zoominlockContainerView.isHidden = true
            UIView.animate(withDuration: 1.5, animations: {
                self.coverView.alpha = 0
                self.homeImgView.transform = CGAffineTransform.identity
            })
        }
        
    }
    
    
    func generateNumberPad(){
        width = (numberPadContainer.frame.width)/3
        height = (numberPadContainer.frame.height)/4
        
        for y in 0...3 {
            numberPad.append([UIView]())
            for x in 0...2 {
                let num = UIView(frame: CGRect(x: CGFloat(x)*width , y: CGFloat(y)*height, width: width, height: height))
                numberPad[y].append(num)
                
                numberPadContainer.addSubview(numberPad[y][x])
                
            }
        }
    }

    
    func checkPassword(){
        if numberPressed == passcode {
            numberPressedLabel.textColor = #colorLiteral(red: 0, green: 1, blue: 0.3290055096, alpha: 1)
            print("You unlocked the door.")
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.notificationOccurred(.success)
            let path = Bundle.main.path(forResource:"lock", ofType:"mp3")
            let url = URL(fileURLWithPath: path!)
            do {
                audioPlayer0 = try AVAudioPlayer(contentsOf: url)
                audioPlayer0.play()
                //audioPlayer0.numberOfLoops = -1
            } catch {
                print("cant play audio")
            }
            playAudio3()
            performSegue(withIdentifier: "toLastRoom", sender: self)
        } else {
            numberPressedLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            print("Password wrong.")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    @objc func printNumber(sender: UITapGestureRecognizer){
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        
        let location = sender.location(in: numberPadContainer)
        
        let newX = Int(location.x / width)
        let newY = Int(location.y / height)
        
        //print("newx: \(newX) newy: \(newY)")
        let stringForSwitch: String = "\(newY)\(newX)"
        
        switch stringForSwitch {
        case "00":
            print("1")
            numberPressed += "1"
        case "01":
            print("2")
            numberPressed += "2"
        case "02":
            print("3")
            numberPressed += "3"
        case "10":
            print("4")
            numberPressed += "4"
        case "11":
            print("5")
            numberPressed += "5"
        case "12":
            print("6")
            numberPressed += "6"
        case "20":
            print("7")
            numberPressed += "7"
        case "21":
            print("8")
            numberPressed += "8"
        case "22":
            print("9")
            numberPressed += "9"
        case "30":
            print("*")
            numberPressed += "*"
        case "31":
            print("0")
            numberPressed += "0"
        case "32":
            print("#")
            numberPressed += "#"
        default:
            print("not number")
            numberPressedCount -= 1
        }
        print(numberPressed)
        numberPressedLabel.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        numberPressedLabel.text = numberPressed
        numberPressedCount += 1
        
        if numberPressedCount == 4 {
            checkPassword()
            numberPressedCount = 0
            numberPressed = ""
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFirstRoom" {
            audioPlayer0.setVolume(0.8, fadeDuration: 1.5)
            playAudio1()
        } else if segue.identifier == "toSecondRoom" {
            audioPlayer1.setVolume(0.8, fadeDuration: 1.5)
            playAudio2()
        } else { //final room
            
        }
    }
    
    //MARK: - prepare for unwind
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    }
    
    //this is heavy long vibration
    //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
}
