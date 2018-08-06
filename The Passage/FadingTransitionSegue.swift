//
//  FadingTransitionSegue.swift
//  Fear Mini Challenge
//
//  Created by Afina R. Vinci on 16/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//

import UIKit

//MARK: - Fading ke halaman selanjutnya
class FadingTransitionSegue: UIStoryboardSegue {
    
    override func perform() {
        fadeIn()
    }
    
    func fadeIn() {
        let destinationVC = self.destination
        let sourceVC = self.source
        let destinationView = self.destination.view
        let sourceView = self.source.view
        sourceView?.addSubview(destinationView!)
        destinationView?.alpha = 0.0

        UIView.animate(withDuration: 2, delay: 0, options: .curveLinear, animations: {
            destinationView?.alpha = 1.0
        }, completion: { success in
            sourceVC.present(destinationVC, animated: false, completion: nil)
        })
    }
}


//MARK: - Fading balik ke halaman sebelumnya
class FadeOutSegue: UIStoryboardSegue {
    override func perform() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
        fadeOut()
        
    }
    
    func fadeOut() {
        let sourceViewController = self.source
        UIView.animate(withDuration: 2, delay: 0, options: .curveLinear, animations: {
            sourceViewController.view.alpha = 0.0
        }) { (true) in
            sourceViewController.dismiss(animated: false, completion: nil)
        }
    }
}


