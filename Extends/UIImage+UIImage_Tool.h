//
//  UIImage+UIImage_Tool.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_Tool)

#pragma mark - Class methods
+ (UIImage *)loadImageFromFile:(NSString *)fileName withTTL:(NSUInteger)ttl;

#pragma mark - Instance methods
- (UIImage *)imageRounded;
- (UIImage *)imageScaledToSize:(CGSize)scaledSize;
- (UIImage *)imageColorizeWithColor:(UIColor *)theColor inArea:(CGRect)areaColorized;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageCroppedToFrame:(CGRect)rect;
- (UIImage *)imageNormalized;

- (void)saveToFile:(NSString *)fileName;

#pragma mark DEPRECATED
+ (UIImage *)resizableImage:(NSString *)imageName withCapInsets:(UIEdgeInsets)capInsets DEPRECATED_ATTRIBUTE;
+ (UIImage *)resizableUIImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets DEPRECATED_ATTRIBUTE;
+ (void) applyStackBlurToBuffer:(UInt8*)targetBuffer width:(const int)w height:(const int)h withRadius:(NSUInteger)inradius DEPRECATED_ATTRIBUTE;
+ (UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor DEPRECATED_ATTRIBUTE;
+ (UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor verticalOffSet:(CGFloat)verticalOffSet DEPRECATED_ATTRIBUTE;
+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float)width DEPRECATED_ATTRIBUTE;
+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledRelativeToSize:(CGSize)size DEPRECATED_ATTRIBUTE;
+ (UIImage *)imageWithImage:(UIImage *)image withSize:(CGSize)newSize DEPRECATED_ATTRIBUTE;
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur DEPRECATED_ATTRIBUTE;

@end
