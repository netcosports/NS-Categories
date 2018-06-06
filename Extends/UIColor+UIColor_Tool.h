//
//  UIColor+UIColor_Tool.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_Tool)

#pragma mark Class methods
+ (UIColor *)colorWithRGBString:(NSString*)rgbValue alpha:(float)alpha;
+ (UIColor *)colorWithARGBString:(NSString *)strARGB;
+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(float)alpha;
+ (UIColor *)colorWithRGB:(int)rgbValue;

#pragma mark Instance methods
- (BOOL)isLightColor;
- (NSString *)toRGBString;
- (UIColor *)colorByDarkeningColor;
- (UIColor *)colorByDarkeningColorWithCoefficient:(CGFloat)coefficient;
- (UIColor *)colorByChangingAlphaTo:(CGFloat)newAlpha;

@end
