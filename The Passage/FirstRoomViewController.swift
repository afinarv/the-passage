//
//  FirstRoomViewController.swift
//  Fear Mini Challenge
//
//  Created by Afina R. Vinci on 18/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class FirstRoomViewController: UIViewController {
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var backArrowImgView: UIImageView!
    @IBOutlet weak var dollSpriteImgView: UIImageView!
    @IBOutlet weak var frameImgView: UIImageView!
    @IBOutlet weak var droppedframeImgView: UIImageView!
    @IBOutlet weak var shadowImgView: UIImageView!
    
    var hasTappedDoll = false
    var hasTappedFrame = false
    var frameAttachment: UIAttachmentBehavior!
    var attachment: UIAttachmentBehavior!
    var animator: UIDynamicAnimator!
    
    var clueImgView: UIImageView!
    var dollTapped: UITapGestureRecognizer!
    var frameTapped: UITapGestureRecognizer!
    var droppedFrameTapped: UITapGestureRecognizer!
    var frameTapCounter = 0
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backArrowImgView.isHidden = true
        UIView.animate(withDuration: 2.0, delay: 2, options: .curveLinear, animations: {
            self.coverView.alpha = 0.0
        }, completion: nil)
        
        setupClueItems()
    }
    
    //MARK: - setup clues
    func setupClueItems() {
        self.frameImgView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        dollSpriteImgView.isUserInteractionEnabled = true
        dollTapped = UITapGestureRecognizer(target: self, action: #selector(fadeBridging(_:)))
        dollSpriteImgView.addGestureRecognizer(dollTapped)
        
        frameImgView.isUserInteractionEnabled = true
        frameTapped = UITapGestureRecognizer(target: self, action: #selector(fadeBridging(_:)))
        frameImgView.addGestureRecognizer(frameTapped)
        
        droppedframeImgView.isUserInteractionEnabled = true
        droppedFrameTapped = UITapGestureRecognizer(target: self, action: #selector(fadeBridging(_:)))
        droppedframeImgView.addGestureRecognizer(droppedFrameTapped)
        
    }
    
    
    @objc func fadeBridging(_ sender: UITapGestureRecognizer) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        
        clueImgView = UIImageView(frame: CGRect(x: self.view.frame.width/2 - (self.view.frame.width/3), y: self.view.frame.height + 20, width: self.view.frame.width/3, height: self.view.frame.height - 30))
        clueImgView.contentMode = .scaleAspectFit
        clueImgView.clipsToBounds = true
        self.view.addSubview(clueImgView)
        
        if sender == dollTapped {
            fadeInClueToCenter(imgName: "dollsprite")
            hasTappedDoll = true
        } else if sender == frameTapped {
            switch frameTapCounter {
            case 0: //zoom in pigura kondisi1
                fadeInClueToCenter(imgName: "pigurakondisi1")
            case 1: //gak di zoom in gambarny, tapi gambar di hinge trus jatoh
                frameHinge()
            default:
                print("")
                //kasi if si baby ud diclick, panah bru nongol(?)
            }
            frameTapCounter += 1
        } else {
            fadeInThenCrack(imgName: "pigurakondisi2")
            hasTappedFrame = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    //MARK: - hinge frame
    func frameHinge() {
        UIView.animate(withDuration: 1.5, animations: {
            self.frameImgView.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi/4))
            
        }, completion: { (true) in
            UIView.animate(withDuration: 0.3, animations: {
                self.frameImgView.alpha = 0.0
            }, completion: { (true) in
                self.playAudio(filename: "thud", filetype: "mp3")
                self.droppedframeImgView.isHidden = false
                self.frameImgView.isHidden = true
            })
        })
    }
    
    //MARK: - fade in clue
    @objc func fadeInClueToCenter(imgName: String) {
        dollSpriteImgView.isUserInteractionEnabled = false
        frameImgView.isUserInteractionEnabled = false
        //droppedframeImgView.isUserInteractionEnabled = false
        
        let centerX = self.view.frame.width/2
        let centerY = self.view.frame.height/2
        clueImgView.isHidden = false
        clueImgView.image = UIImage(named: imgName)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.clueImgView.center = CGPoint(x: centerX, y: centerY)
            self.clueImgView.alpha = 1
            
            if imgName == "dollsprite" {
                self.playAudio(filename: "babylaugh", filetype: "m4a")
            }
            
        }, completion: { (true) in
            self.fadeOutClue()
            
            
            //self.droppedframeImgView.isUserInteractionEnabled = true
        })
    }
    
    
    func fadeInThenCrack(imgName: String) {
        dollSpriteImgView.isUserInteractionEnabled = false
        droppedframeImgView.isUserInteractionEnabled = false
        
        let centerX = self.view.frame.width/2
        let centerY = self.view.frame.height/2
        
        clueImgView.image = UIImage(named: imgName)
        UIView.animate(withDuration: 0.5, animations: {
            self.clueImgView.center = CGPoint(x: centerX, y: centerY)
            self.clueImgView.alpha = 0.99
        }, completion: { (true) in
            UIView.animate(withDuration: 0.5, delay: 1, animations: {
                self.clueImgView.alpha = 1
            }, completion: { (true) in
                self.playAudio(filename: "glasscrash", filetype: "mp3")
                UIView.animate(withDuration: 0.5, animations: {
                    self.clueImgView.image = UIImage(named: "pigurakondisi3")
                    
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5, delay: 1, animations: {
                        self.clueImgView.alpha = 0.99
                    }, completion: {(true) in
                        self.clueImgView.isHidden = true
                        self.playAudio(filename: "jreng", filetype: "wav")
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        UIView.animate(withDuration: 0.4, animations: {
                            self.shadowImgView.alpha = 1
                            self.shadowImgView.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
                        }, completion: {(true) in
                            UIView.animate(withDuration: 0.5, delay: 1, animations: {
                                self.shadowImgView.alpha = 0
                                self.dollSpriteImgView.isUserInteractionEnabled = true
                                self.droppedframeImgView.isUserInteractionEnabled = false
                                
                                if self.hasTappedFrame && self.hasTappedDoll {
                                    self.shakeArrow()
                                }
                            })
                        })
                    
                    })
                })
            })
           
        })
    }
    
    func fadeOutClue(){
        UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
            self.clueImgView.alpha = 0
        }, completion: { (true) in
            self.clueImgView.removeFromSuperview()
            self.dollSpriteImgView.isUserInteractionEnabled = true
            self.frameImgView.isUserInteractionEnabled = true
            
            if self.hasTappedFrame && self.hasTappedDoll {
                self.shakeArrow()
            }
        }
    )}
    
    //MARK: - audioplayer
    func playAudio(filename: String, filetype: String) {
        let path = Bundle.main.path(forResource: filename, ofType: filetype)
        let url = URL(fileURLWithPath: path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
            //audioPlayer.numberOfLoops = 1
        } catch {
            print("cant play audio")
        }
    }
    
    //MARK: - shake arrow
    func shakeArrow() {
        backArrowImgView.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat,.autoreverse], animations:{
            self.backArrowImgView.frame.origin.x += 20
            self.backArrowImgView.frame.origin.x -= 20
        }, completion: nil)
    }

}
