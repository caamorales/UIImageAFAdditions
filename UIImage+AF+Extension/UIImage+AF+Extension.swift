//
//  UIImage+AF+Additions.swift
//  Demo UIImage+AF+Additions
//
//  Created by Melvin Rivera on 7/5/14.
//  Copyright (c) 2014 All Forces. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import CoreGraphics


enum UIImageContentMode {
    case ScaleToFill, ScaleAspectFit, ScaleAspectFill
}

extension UIImage {

    //#pragma mark - Image from solid color
    convenience init(color:UIColor, size:CGSize = CGSizeMake(10, 10) )
    {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        self.init(CGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage)
        UIGraphicsEndImageContext()
    }
    
    //#pragma mark - Image from gradient colors
    convenience init(gradientColors:[UIColor], size:CGSize = CGSizeMake(10, 10) )
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        var context = UIGraphicsGetCurrentContext()
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject! in return color.CGColor as AnyObject! } as NSArray
        var gradient = CGGradientCreateWithColors(colorSpace, colors, nil)
        CGContextDrawLinearGradient(context, gradient, CGPoint(x: 0, y: 0), CGPoint(x: 0, y: size.height), 0)
        self.init(CGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage)
        UIGraphicsEndImageContext()
        CGGradientRelease(gradient)
        CGColorSpaceRelease(colorSpace)
    }
    
    
    func applyGradientColors(gradientColors: [UIColor], blendMode: CGBlendMode = kCGBlendModeNormal) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        CGContextDrawImage(context, rect, self.CGImage)
        // Create gradient
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject! in return color.CGColor as AnyObject! } as NSArray
        let gradient = CGGradientCreateWithColors(colorSpace, colors, nil)
        // Apply gradient
        CGContextClipToMask(context, rect, self.CGImage)
        CGContextDrawLinearGradient(context, gradient, CGPoint(x: 0, y: 0), CGPoint(x: 0, y: size.height), 0)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        // Clean
        CGGradientRelease(gradient)
        CGColorSpaceRelease(colorSpace)
        // Return
        return image;
    }
    
    //#pragma mark - Image with Text
    convenience init(text: String, font: UIFont = UIFont.systemFontOfSize(18), color: UIColor = UIColor.whiteColor(), backgroundColor: UIColor = UIColor.grayColor(), size:CGSize = CGSizeMake(100, 100), offset: CGPoint = CGPoint(x: 0, y: 0))
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor)
        CGContextFillRect(context, CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        var style = NSMutableParagraphStyle()
        style.alignment = .Center
        let attr = [NSFontAttributeName:font, NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:style]
        let rect = CGRect(x: offset.x, y: offset.y, width: size.width, height: size.height)
        text.bridgeToObjectiveC().drawInRect(rect, withAttributes: attr)
        self.init(CGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage)
        UIGraphicsEndImageContext()
    }
    
    //# pragma mark - Image from uiview
    convenience init(fromView view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        //view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        self.init(CGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage)
        UIGraphicsEndImageContext()
    }
    
    //#pragma mark - Image with Radial Gradient
    // Render a radial background
    // Originally from: http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadings/dq_shadings.html
    convenience init(startColor: UIColor, endColor: UIColor, radialGradientCenter: CGPoint = CGPoint(x: 0.5, y: 0.5), radius:Float = 0.5, size:CGSize = CGSizeMake(100, 100))
    {
        
        // Init
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        
        let num_locations: UInt = 2
        let locations: [CGFloat] = [0.0, 1.0]
        
        let startComponents = CGColorGetComponents(startColor.CGColor)
        let endComponents = CGColorGetComponents(endColor.CGColor)
        
        let components: [CGFloat] = [startComponents[0], startComponents[1], startComponents[2], startComponents[3], endComponents[0], endComponents[1], endComponents[2], endComponents[3]]
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations)
        
        // Normalize the 0-1 ranged inputs to the width of the image
        let aCenter = CGPoint(x: radialGradientCenter.x * size.width, y: radialGradientCenter.y * size.height)
        let aRadius = CGFloat(min(size.width, size.height)) * CGFloat(radius)
        
        // Draw it
        CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(), gradient, aCenter, 0, aCenter, aRadius, UInt32(kCGGradientDrawsAfterEndLocation))
        self.init(CGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage)
        // Clean up
        UIGraphicsEndImageContext();
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
    }
    
    //#pragma mark - Alpha
    
    // Returns true if the image has an alpha layer
    func hasAlpha() -> Bool
    {
        let alpha = CGImageGetAlphaInfo(self.CGImage)
        switch alpha {
        case .First, .Last, .PremultipliedFirst, .PremultipliedLast:
            return true
        default:
            return false
            
        }
    }
    
    // Returns a copy of the given image, adding an alpha channel if it doesn't already have one
    
    func applyAlpha() -> UIImage
    {
        if hasAlpha() {
            return self
        }
        
        let imageRef = self.CGImage;
        let width = CGImageGetWidth(imageRef);
        let height = CGImageGetHeight(imageRef);
        let colorSpace = CGImageGetColorSpace(imageRef)
        
        // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
        let bitmapInfo = CGBitmapInfo.fromRaw(CGBitmapInfo.ByteOrderDefault.toRaw() | CGImageAlphaInfo.PremultipliedFirst.toRaw())
        let offscreenContext = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, bitmapInfo!)
        
        // Draw the image into the context and retrieve the new image, which will now have an alpha layer
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), imageRef)
        var imageWithAlpha = UIImage(CGImage: CGBitmapContextCreateImage(offscreenContext))
        
        CGContextRelease(offscreenContext)
        CGColorSpaceRelease(colorSpace);
        
        return imageWithAlpha
        
    }
    
    // Returns a copy of the image with a transparent border of the given size added around its edges.
    func applyPadding(padding: CGFloat) -> UIImage
    {
        // If the image does not have an alpha layer, add one
        var image = self.applyAlpha()
        let rect = CGRect(x: 0, y: 0, width: size.width + padding * 2, height: size.height + padding * 2)
        
        // Build a context that's the same dimensions as the new size
        let colorSpace = CGImageGetColorSpace(self.CGImage)
        let bitmapInfo = CGImageGetBitmapInfo(self.CGImage)
        let bitsPerComponent = CGImageGetBitsPerComponent(self.CGImage)
        let context = CGBitmapContextCreate(nil, UInt(rect.size.width), UInt(rect.size.height), bitsPerComponent, 0, colorSpace, bitmapInfo)
        
        // Draw the image in the center of the context, leaving a gap around the edges

        let imageLocation = CGRect(x: padding, y: padding, width: image.size.width, height: image.size.height)
        CGContextDrawImage(context, imageLocation, self.CGImage)
        
        // Create a mask to make the border transparent, and combine it with the image
        
        var transparentImage = UIImage(CGImage: CGImageCreateWithMask(CGBitmapContextCreateImage(context), imageRefWithPadding(padding, size: rect.size)))
        
        CGContextRelease(context)
        CGColorSpaceRelease(colorSpace)
        
        return transparentImage
    }
    
    //#pragma mark - Private helper methods
    
    
    // Creates a mask that makes the outer edges transparent and everything else opaque
    // The size must include the entire mask (opaque part + transparent border)
    // The caller is responsible for releasing the returned reference by calling CGImageRelease
    func imageRefWithPadding(padding: CGFloat, size:CGSize) -> CGImageRef
    {
        // Build a context that's the same dimensions as the new size
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo.fromRaw(CGBitmapInfo.ByteOrderDefault.toRaw() | CGImageAlphaInfo.None.toRaw())
        let context = CGBitmapContextCreate(nil, UInt(size.width), UInt(size.height), 8, 0, colorSpace, bitmapInfo!)
        // Start with a mask that's entirely transparent
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextFillRect(context, CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // Make the inner part (within the border) opaque
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillRect(context, CGRect(x: padding, y: padding, width: size.width - padding * 2, height: size.height - padding * 2))
        // Get an image of the context
        let maskImageRef = CGBitmapContextCreateImage(context)
        // Clean up
        CGContextRelease(context)
        CGColorSpaceRelease(colorSpace)
        return maskImageRef
    }
    
    //#pragma mark - Resize
    
    
    func crop(bounds: CGRect) -> UIImage
    {
        return UIImage(CGImage: CGImageCreateWithImageInRect(self.CGImage, bounds))
    }
    
    
    func resize(size:CGSize, contentMode: UIImageContentMode = .ScaleToFill) -> UIImage
    {
        let horizontalRatio = size.width / self.size.width;
        let verticalRatio = size.height / self.size.height;
        var ratio: CGFloat!
        
        switch contentMode {
            case .ScaleToFill:
                ratio = 1
            case .ScaleAspectFill:
                ratio = max(horizontalRatio, verticalRatio)
            case .ScaleAspectFit:
                ratio = min(horizontalRatio, verticalRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width * ratio, height: self.size.height * ratio)
        
        // Fix for a colorspace / transparency issue that affects some types of
        // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo.fromRaw(CGImageAlphaInfo.PremultipliedLast.toRaw())
        let context = CGBitmapContextCreate(nil, UInt(rect.size.width), UInt(rect.size.height), 8, 0, colorSpace, bitmapInfo!)
        
        let transform = CGAffineTransformIdentity
        
        // Rotate and/or flip the image if required by its orientation
        CGContextConcatCTM(context, transform);
        
        // Set the quality level to use when rescaling
        //let quality = CGInterpolationQuality.fromRaw(CGInterpolationQuality.kCGInterpolationHigh.toRaw())
        CGContextSetInterpolationQuality(context, CGInterpolationQuality(kCGInterpolationHigh.value))
                
        // Draw into the context; this scales the image
        CGContextDrawImage(context, rect, self.CGImage)
        
        // Get the resized image from the context and a UIImage
        var newImage = UIImage(CGImage: CGBitmapContextCreateImage(context))
        
        // Clean up
        CGColorSpaceRelease(colorSpace)
        CGContextRelease(context)
        
        return newImage;
    }

    
    // #pragma mark - Corner Radius
    
    func roundCorners(cornerRadius:CGFloat, stroke:CGFloat, color:UIColor, padding: CGFloat = 0) -> UIImage
    {
        // If the image does not have an alpha layer, add one
        var image = applyAlpha()
        
        let scaledCornerRadius = cornerRadius * scale
        let scaledPadding = padding * scale
        let scaledWidth = image.size.width * scale
        let scaledHeight = image.size.height * scale
        let scaledStroke = stroke * scale
        
        // Build a context that's the same dimensions as the new size
        let colorSpace = CGImageGetColorSpace(image.CGImage)
        let bitmapInfo = CGImageGetBitmapInfo(image.CGImage)
        let context = CGBitmapContextCreate(nil, UInt(scaledWidth), UInt(scaledHeight), CGImageGetBitsPerComponent(image.CGImage), 0, colorSpace, bitmapInfo)
        
        // Create a clipping path with rounded corners
        // Adds a rectangular path to the given context and rounds its corners by the given extents
        // Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
        CGContextBeginPath(context)
        let rect = CGRect(x: scaledPadding, y: scaledPadding, width: scaledWidth - (scaledPadding * 2), height: scaledHeight - (scaledPadding * 2))
        if (scaledCornerRadius == 0) {
            CGContextAddRect(context, rect)
        } else {
            CGContextSaveGState(context)
            CGContextTranslateCTM(context, rect.minX, rect.minY)
            CGContextScaleCTM(context, scaledCornerRadius, scaledCornerRadius)
            let fw = scaledWidth / scaledCornerRadius
            let fh = scaledHeight / scaledCornerRadius
            CGContextMoveToPoint(context, fw, fh/2)
            CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1)
            CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1)
            CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1)
            CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1)
            CGContextRestoreGState(context)
        }
        CGContextClosePath(context)
        CGContextClip(context)
        
        // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
        CGContextDrawImage(context, CGRectMake(0, 0, scaledWidth, scaledHeight), image.CGImage)
        
        // Stroke
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        CGContextSetRGBStrokeColor(context, red, green, blue, alpha)
        
        let strokeRect = CGRectInset(rect, scaledPadding*2, scaledPadding*2);
        CGContextSetLineWidth(context, scaledStroke)
        CGContextStrokeEllipseInRect(context, strokeRect)
        
        // Create a UIImage from the CGImage
        var roundedImage = UIImage(CGImage:CGBitmapContextCreateImage(context))
        
        // Clean up
        CGContextRelease(context)
        CGColorSpaceRelease(colorSpace)
        
        return roundedImage
        
    }
    
    func roundCornersToCircle(#stroke:CGFloat, color:UIColor, padding: CGFloat = 0) -> UIImage
    {
        return roundCorners(size.width/2-padding, stroke: stroke, color: color, padding: padding)
    }
    

}