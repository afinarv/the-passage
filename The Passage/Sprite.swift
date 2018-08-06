//
//  Sprite.swift
//  Fear Mini Challenge
//
//  Created by Afina R. Vinci on 20/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//


import Foundation
import UIKit
//class utama hrs sama dengan nama file
class Sprite : GameAssetable {
    internal var x: Double
    internal var y: Double
    internal var width : Double
    internal var height : Double
    internal var imageName : String
    internal var clue : Clue
    
    var imageView: UIImageView
    
    init(x : Double, y: Double,width: Double, height: Double, imageName: String, clueXPosition: Double, clueYPosition: Double, clueImageName: String, clueWidth: Double, clueHeight: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.imageName = imageName
        self.clue = Clue(xCluePos: clueXPosition, yCluePos: clueYPosition, height: clueHeight, width: clueWidth, imageName: clueImageName)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: self.imageName)
        imageView.frame =  CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
        self.imageView = imageView
        self.imageView.isUserInteractionEnabled = true
    }
}
