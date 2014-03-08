//
//  UIImage+AF+Additions.h
//
//  Created by Melvin Rivera on 2/26/14
//

#import <UIKit/UIKit.h>

@interface UIImage (AFAdditions)

// Image from solid color
+ (UIImage *) imageFromColor:(UIColor *)color;
+ (UIImage *) imageFromColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *) imageFromColor:(UIColor *)color size:(CGSize)size padding:(NSInteger)padding;


// Image from UIView
+ (UIImage *) imageFromView:(UIView *)view;

// Image with Radial Gradient
+ (UIImage *) imageWithRadialGradientSize:(CGSize)size start:(UIColor *)start end:( UIColor *)end centre:(CGPoint)centre radius:(float)radius;

// Alpha - From Trevor Harmon
- (BOOL) hasAlpha;
- (UIImage *) imageWithAlpha;
- (UIImage *) transparentBorderImage:(NSUInteger)borderSize;

// Resize - From Trevor Harmon
- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

// Corner Radius
- (UIImage *) setCornerRadius:(CGFloat)cornerRadius;
- (UIImage *) setCornerRadiusAsCircle;

// Image Effects - From Apple
- (UIImage *) applyLightEffect;
- (UIImage *) applyExtraLightEffect;
- (UIImage *) applyDarkEffect;
- (UIImage *) applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *) applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;




@end
