//
//  Clue.swift
//  Fear Mini Challenge
//
//  Created by Afina R. Vinci on 20/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//

import Foundation
import UIKit
class Clue : GameAssetable {
    var x: Double
    var y: Double
    var height: Double
    var width: Double
    var imageName: String
    var imageView: UIImageView
    
    init(xCluePos: Double,yCluePos: Double,height: Double, width: Double, imageName: String) {
        self.x = xCluePos
        self.y = yCluePos
        self.height = height
        self.width = width
        self.imageName = imageName
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: self.imageName)
        imageView.frame =  CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
        self.imageView = imageView
        self.imageView.alpha = 0
        self.imageView.isUserInteractionEnabled = true
        print("clue created")
    }
    
    
}
