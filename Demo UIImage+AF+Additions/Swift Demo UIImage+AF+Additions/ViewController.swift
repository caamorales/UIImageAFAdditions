//
//  ViewController.swift
//  Swift Demo UIImage+AF+Additions
//
//  Created by Melvin Rivera on 7/5/14.
//  Copyright (c) 2014 All Forces. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Solid
        let solidImage = UIImage(color: UIColor.redColor(), size: CGSize(width: 120, height: 120))
        var imageFromColor = UIImageView(image: solidImage)
        imageFromColor.frame = CGRect(x: 30, y: 30, width: 120, height: 120)
        self.view.addSubview(imageFromColor)
        
        // Gradient Gradient
        let gradientImage = UIImage(gradientColors: [UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)], size: CGSize(width: 120, height: 120))
        var imageWithGradient = UIImageView(image: gradientImage)
        imageWithGradient.frame = CGRect(x: 30, y: 170, width: 120, height: 120)
        self.view.addSubview(imageWithGradient)
        
        // Gradient Overlay
        let avatarImage = UIImage(named: "avatar").applyGradientColors([UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)])
        var imageWithGradientOverlay = UIImageView(image: avatarImage)
        imageWithGradientOverlay.frame = CGRect(x: 170, y: 170, width: 120, height: 120)
        self.view.addSubview(imageWithGradientOverlay)
        
        // Radial Gradient
        let radialImage = UIImage(startColor: UIColor(red: 1, green: 0, blue: 0, alpha: 1), endColor: UIColor(red: 1, green: 0.8, blue: 0.2, alpha: 1), radialGradientCenter: CGPoint(x: 0.5, y: 0.5), radius: 0.5, size: CGSize(width: 120, height: 120))
        var imageWithRadialGradient = UIImageView(image: radialImage)
        imageWithRadialGradient.frame = CGRect(x: 170, y: 30, width: 120, height: 120)
        self.view.addSubview(imageWithRadialGradient)
        
        // Text
        let textImage = UIImage(text: "M", font: UIFont.systemFontOfSize(64), color: UIColor.whiteColor(), backgroundColor: UIColor.redColor(), size: CGSize(width: 120, height: 120), offset: CGPoint(x: 0, y: 20))
        var imageWithText = UIImageView(image: textImage)
        imageWithText.frame = CGRect(x: 30, y: 310, width: 120, height: 120)
        self.view.addSubview(imageWithText)
        
        // Rounded Image
        let roundTextImage = textImage.roundCornersToCircle(stroke: 12, color: UIColor.blackColor(), padding: 0)
        var roundImageWithText = UIImageView(image: roundTextImage)
        roundImageWithText.frame = CGRect(x: 170, y: 310, width: 120, height: 120)
        self.view.addSubview(roundImageWithText)
        
        // From UIVIew + Resize
        let uiviewImage = UIImage(fromView: self.view).resize(CGSize(width: 120, height: 120), contentMode: .ScaleAspectFill)
        var imageWithView = UIImageView(image: uiviewImage)
        imageWithView.frame = CGRect(x: 30, y: 450, width: 120, height: 120)
        self.view.addSubview(imageWithView)
        
        // Crop + Resize
        let cropImage = UIImage(named: "avatar").crop(CGRect(x: 40, y: 40, width: 50, height: 50)).applyPadding(6)
        var imageWithCrop = UIImageView(image: cropImage)
        imageWithCrop.frame = CGRect(x: 170, y: 450, width: 120, height: 120)
        self.view.addSubview(imageWithCrop)
        

    }



}

