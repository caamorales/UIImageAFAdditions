UIImage-AF-Additions
=============================

A simple UIImage convenience category for handling blur effects, corner radius and creation from color or UIVIews

### CocoaPods
```
pod 'UIImage+AF+Additions', :git => 'https://github.com/melvitax/UIImageAFAdditions.git'
```

### Header
```
#import "UIImage+AF+Additions.h"
```

### Image from solid color
```Objective-C
+ (UIImage *) imageFromColor:(UIColor *)color;
+ (UIImage *) imageFromColor:(UIColor *)color size:(CGSize)size;
```

### Image from UIView
```Objective-C
+ (UIImage *) imageFromView:(UIView *)view;
```

### Image with Radial Gradient
```Objective-C
+ (UIImage *) imageWithRadialGradientSize:(CGSize)size start:(UIColor *)start end:( UIColor *)end centre:(CGPoint)centre radius:(float)radius;
```

### Alpha - From Trevor Harmon
```Objective-C
- (BOOL) hasAlpha;
- (UIImage *) imageWithAlpha;
- (UIImage *) transparentBorderImage:(NSUInteger)borderSize;
```

### Resize - From Trevor Harmon
```Objective-C
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
```

### Corner Radius
```Objective-C
- (UIImage *) imageWithCornerRadius:(CGFloat)cornerRadius;
- (UIImage *) imageWithCornerRadiusAsCircle;
```

### Image Effects - From Apple
```Objective-C
- (UIImage *) applyLightEffect;
- (UIImage *) applyExtraLightEffect;
- (UIImage *) applyDarkEffect;
- (UIImage *) applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *) applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
```
