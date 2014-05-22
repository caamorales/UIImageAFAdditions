//
//  ViewController.m
//  Demo UIImage+AF+Additions
//
//  Created by Melvin Rivera on 5/22/14.
//  Copyright (c) 2014 All Forces. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+AF+Additions.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Solid
    UIImageView *imageFromColor = [[UIImageView alloc] initWithImage:[UIImage imageFromColor:[UIColor redColor] size:CGSizeMake(120, 120)]];
    imageFromColor.frame = CGRectMake(30, 30, 120, 120);
    [self.view addSubview:imageFromColor];
    
    // Radial Gradient
    UIImageView *imageWithRadialGradient = [[UIImageView alloc] initWithImage:[UIImage imageWithRadialGradientSize:CGSizeMake(120, 120) start:[UIColor colorWithRed:1 green:0 blue:0 alpha:1] end:[UIColor colorWithRed:1 green:0.8 blue:0.2 alpha:1] centre:CGPointMake(0.5, 0.5) radius:0.5]];
    imageWithRadialGradient.frame = CGRectMake(170, 30, 120, 120);
    [self.view addSubview:imageWithRadialGradient];
    
    // Gradient
    UIImageView *imageWithGradient = [[UIImageView alloc] initWithImage:[UIImage imageWithGradientColors:@[[UIColor colorWithRed:1 green:0 blue:0 alpha:1], [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1]] size:CGSizeMake(120, 120)]];
    imageWithGradient.frame = CGRectMake(30, 170, 120, 120);
    [self.view addSubview:imageWithGradient];
    
    // Gradient Overlay
    UIImage *avatar = [[UIImage imageNamed:@"avatar"] applyGradientColors:@[[UIColor colorWithRed:1 green:0 blue:0 alpha:1], [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1]]];
    UIImageView *imageWithGradientOverlay = [[UIImageView alloc] initWithImage:avatar];
    imageWithGradientOverlay.frame = CGRectMake(170, 170, 120, 120);
    [self.view addSubview:imageWithGradientOverlay];
    
    
    // Text
    UIImage *imageWithText = [[UIImage imageFromColor:[UIColor redColor] size:CGSizeMake(120, 120) ] drawText:@"M" withFont:[UIFont systemFontOfSize:64] color:[UIColor whiteColor]];
    UIImageView *imageWithTextView = [[UIImageView alloc] initWithImage:imageWithText];
    imageWithTextView.frame = CGRectMake(30, 310, 120, 120);
    [self.view addSubview:imageWithTextView];
    
    // Rounded Image
    UIImage *roundImageWithText = [imageWithText circleImageWithBorderSize:2];
    UIImageView *roundImageWithTextView = [[UIImageView alloc] initWithImage:roundImageWithText];
    roundImageWithTextView.frame = CGRectMake(170, 310, 120, 120);
    [self.view addSubview:roundImageWithTextView];
    
    
    // Tint
    UIImage *imageWithTint = [[UIImage imageNamed:@"beach"] applyTintEffectWithColor:[UIColor redColor]];
    UIImageView *imageWithTintView = [[UIImageView alloc] initWithImage:imageWithTint];
    imageWithTintView.frame = CGRectMake(30, 450, 120, 120);
    [self.view addSubview:imageWithTintView];
    
    // Blur
    UIImage *imageWithBlur = [[UIImage imageNamed:@"beach"] applyLightEffect];
    UIImageView *imageWithBlurView = [[UIImageView alloc] initWithImage:imageWithBlur];
    imageWithBlurView.frame = CGRectMake(170, 450, 120, 120);
    [self.view addSubview:imageWithBlurView];

}



@end
