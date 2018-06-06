//
//  UIImage+UIImage_Filter.m
//  FotofanFramework
//
//  Created by Guillaume Derivery on 18/12/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "UIImage+UIImage_Filter.h"
#import "NSDictionary+NSDictionary_Tool.h"
#import "NSUsefulDefines.h"

@implementation UIImage (UIImage_Filter)

-(UIImage *)imageFilteredWithString:(NSString *)stringFilter andAttributes:(NSDictionary *)attributes
{
    if (!stringFilter || [stringFilter length] == 0)
    {
        DLog(@"Bad filter");
        return self;
    }
    
    CIImage *outputImage = nil;
    @autoreleasepool
    {
        CIImage *beginImage = [CIImage imageWithCGImage:[self CGImage]];
        
        NSDictionary *finalAttributes = nil;
        if (attributes && [attributes objectForKey:kCIInputImageKey])
        {
            finalAttributes = attributes;
        }
        else if (attributes && ![attributes objectForKey:kCIInputImageKey])
        {
            finalAttributes = [NSDictionary dictionaryWithDictionaries:@{kCIInputImageKey : beginImage}, attributes, nil];
        }
        else if (!attributes)
        {
            finalAttributes = @{kCIInputImageKey : beginImage};
        }
        CIFilter *filter = [CIFilter filterWithName:stringFilter withInputParameters:finalAttributes];
        outputImage = [filter outputImage];
    }
    
    CGImageRef cgimg = NULL;
    @autoreleasepool
    {
        if (outputImage)
        {
            CIContext *context = [CIContext contextWithOptions:nil];
            cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        }
    }
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return newImg;
}

@end
