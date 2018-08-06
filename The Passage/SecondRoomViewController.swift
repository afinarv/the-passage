//
//  SecondRoomViewController.swift
//  Fear Mini Challenge
//
//  Created by Afina R. Vinci on 19/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//

import UIKit
import AVFoundation

var passcode = "1568"

class SecondRoomViewController: UIViewController {
    
    @IBOutlet weak var roomView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var backArrowImgView: UIImageView!
    @IBOutlet weak var backArrowButton: UIButton!
    //from gids
    @IBOutlet weak var ghostJump: UIImageView!
    @IBOutlet weak var bookPage: UIImageView!
    @IBOutlet weak var book: UIImageView!
    @IBOutlet weak var ghost: UIImageView!
    @IBOutlet weak var ghost2: UIImageView!
    
    //MARK: Blood Outlets
    @IBOutlet weak var bookAndBloodContainerView: UIView!
    @IBOutlet weak var blood1L: UIImageView!
    @IBOutlet weak var blood1: UIImageView!
    @IBOutlet weak var blood2L: UIImageView!
    @IBOutlet weak var blood2: UIImageView!
    
    //MARK: Bloody Hands
    @IBOutlet weak var leftHand1: UIImageView!
    @IBOutlet weak var rightHand1: UIImageView!
    @IBOutlet weak var leftHand2: UIImageView!
    @IBOutlet weak var rightHand2: UIImageView!
    @IBOutlet weak var leftHand3: UIImageView!
    @IBOutlet weak var rightHand3: UIImageView!
    @IBOutlet weak var leftHand4: UIImageView!
    @IBOutlet weak var rightHand4: UIImageView!
    @IBOutlet weak var leftHand5: UIImageView!
    @IBOutlet weak var rightHand5: UIImageView!
    
    // let & var animation
    let bookAnimation = true
    var bookState = false
    var bloodAnimation = true
    var bloodArt = false
    
    //tictactoe
    @IBOutlet weak var tictactoeContainerView: UIView!
    @IBOutlet var tics: [UIImageView]!
    
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 2.0, delay: 2, options: .curveLinear, animations: {
            self.coverView.alpha = 0.0
        }, completion: { (true) in
            //self.view.addSubview(self.book)
            //self.view.addSubview(self.bookPage)
            //self.view.addSubview(self.ghostJump)
        })
        
        bookAndBloodContainerView.isUserInteractionEnabled = true
        book.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bridge))
        book.addGestureRecognizer(tap)
        print("Animation Initializer loaded and ready")
        
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(bridge))
        bookAndBloodContainerView.addGestureRecognizer(tapDismiss)
        
        //setupTictactoe()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setupTictactoe() {
        self.tictactoeContainerView.isHidden = false
        for num in passcode {
            let numInt = Int(num.description)
                self.tics[numInt!-1].isHidden = false
            }
        }
    
    //MARK: - gideonz
    
    @objc func bridge() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        
        print("your current bookState is \(bookState)")
        switch bookAnimation{
        case bookState == false : openedBookGate()
        case bookState == true : closedBook()
        default : break
        }
    }
    
    // gate pas membuka buku
    @objc func openedBookGate() {
        print("book Gate opened")
        print("your current Blood animation is \(bloodArt)")
        switch bloodAnimation {
        case bloodArt == false : openedBook()
        case bloodArt == true : bloodStain()
        default: break
        }
    }
    
    // membuka buku
    @objc func openedBook() {
        playAudio(filename: "turnpage", filetype: "wav")
        print("book opened")
        self.setupTictactoe()
        bookPage.isUserInteractionEnabled = true
        UIView.animate(withDuration: 1, animations: {
            self.bookAndBloodContainerView.transform = CGAffineTransform(translationX:500, y: 0)
            print("animation 1 Done")
            self.bookState = true
            print("\(self.bookState)")
        })
    }
    
    // menutup buku
    @objc func closedBook() {
        print("book closed")
        roomView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1, animations: {
            self.bookAndBloodContainerView.transform = CGAffineTransform(translationX: -500, y: 0)
            print("Animation 2 Done")
            self.bookState = false
            print("\(self.bookState)")
            self.bloodArt = true
            print("Your BloodAnimation is now \(self.bloodArt) ,be ready")
        }, completion: { (true) in
                self.tictactoeContainerView.isHidden = true
        })
    }
    
    // jumpscare animation
    @objc func bloodStain() {
         playAudio(filename: "turnpage", filetype: "wav")
        print("blood Stained trial animation")
        UIView.animate(withDuration: 1, animations: {
            //self.bookPage.transform = CGAffineTransform(translationX:500  , y: 0)
            self.bookAndBloodContainerView.transform = CGAffineTransform(translationX: 500, y: 0)
        }, completion: { (true) in
            self.playAudio(filename: "intensity", filetype: "wav")
            self.showScreenshotEffect()
            print("animation 1 Done")
            self.bookState = true
            print("\(self.bookState)")
            UIView.animate(withDuration: 0.6, delay: 1, animations: {
                self.blood1.alpha = 1
            })
            UIView.animate(withDuration: 0.6, delay: 0.6, animations: {
                self.blood2.alpha = 1
            })
            UIView.animate(withDuration: 0.6, delay: 1.2, animations: {
                self.blood1L.alpha = 1
            })
            UIView.animate(withDuration: 0.6, delay: 1.8, animations: {
                self.blood2L.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 1, animations: {
                    
                    self.bookAndBloodContainerView.transform = CGAffineTransform(translationX: -500, y: 0)
                    //End of Book Animation
                    
                    //Hands Animation
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5, delay:0, animations: {
                        self.leftHand1.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.rightHand1.alpha = 1
                        }, completion: { (true) in
                            UIView.animate(withDuration: 0.4, animations: {
                                self.leftHand2.alpha = 1
                            }, completion: { (true) in
                                UIView.animate(withDuration: 0.4, animations: {
                                    self.rightHand2.alpha = 1
                                    
                                }, completion: { (true) in
                                    UIView.animate(withDuration: 0.4, animations: {
                                        self.leftHand3.alpha = 1
                                        
                                    }, completion: { (true) in
                                        UIView.animate(withDuration: 0.4, animations: {
                                            self.rightHand3.alpha = 1
                                            
                                        }, completion: { (true) in
                                            UIView.animate(withDuration: 0.4, animations: {
                                                self.leftHand4.alpha = 1
                                            }, completion: { (true) in
                                                UIView.animate(withDuration: 0.3, animations: {
                                                    self.rightHand4.alpha = 1
                                                }, completion: { (true) in
                                                    UIView.animate(withDuration: 0.3, animations: {
                                                        self.leftHand5.alpha = 1
                                                    }, completion: { (true) in
                                                        UIView.animate(withDuration: 0.3, animations: {
                                                            self.rightHand5.alpha = 1
                                    //End of Hands Animation
                                
                                //Ghost Animation start here
                            }, completion: { (true) in
                                UIView.animate(withDuration: 0.6, animations: {
                                    self.ghost.alpha = 1
                                    
                                }, completion: { (true) in
                                    UIView.animate(withDuration: 0.4, animations: {
                                        self.ghost.alpha = 0
                                        self.ghost2.alpha = 1
                                        
                                    }, completion: { (true) in
                                        UIView.animate(withDuration: 0.1, animations: {
                                            self.ghost2.alpha = 0
                                        }, completion: { (true) in
                                            UIView.animate(withDuration: 0.001, animations: {
                                                self.ghostJump.alpha = 1
                                            }, completion: { (true) in
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4) ) {
                                                    self.shakeArrow()
                                                }
                                                
                                                
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
                                    }) }) }) }) }) }) }) })
    }


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
    
    func showScreenshotEffect() {
        
        let snapshotView = UIView()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(snapshotView)
        //view.bringSubview(toFront: snapshotView)
        let n = view.subviews.count
        view.insertSubview(snapshotView, at: n-2)
        
        let constraints:[NSLayoutConstraint] = [
            snapshotView.topAnchor.constraint(equalTo: view.topAnchor),
            snapshotView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snapshotView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            snapshotView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        snapshotView.backgroundColor = UIColor.black
        snapshotView.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 1, animations: {
            snapshotView.alpha = 0.6
        }) { _ in
            UIView.animate(withDuration: 1.2, animations: {
                snapshotView.alpha = 0.0
            }, completion: { (true) in
                self.showScreenshotEffect()
            })
            //snapshotView.removeFromSuperview()
        }
    }
    
    //MARK: - shake arrow
    func shakeArrow() {
        backArrowImgView.isHidden = false
        backArrowButton.isHidden = false
        self.view.bringSubview(toFront: backArrowButton)
        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat,.autoreverse], animations:{
            self.backArrowImgView.frame.origin.x += 20
            self.backArrowImgView.frame.origin.x -= 20
        }, completion: nil)
    }
    
}
