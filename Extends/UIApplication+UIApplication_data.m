//
//  UIApplication+UIApplication_UIApplication_data.m
//  CAN 2013
//
//  Created by Benjamin Bouachour on 07/12/12.
//  Copyright (c) 2012 Netco Sports. All rights reserved.
//

#import "UIApplication+UIApplication_data.h"
#import "UIDevice+UIDevice_Tool.h"

@implementation UIApplication (UIApplication_data)

+(NSString *)getItunesUrlWithAppleID:(NSString *)appleID andStoreLanguage:(NSString *)storeLanguage
{
    return [NSString stringWithFormat:@"http://itunes.apple.com/%@/app/id%@?mt=8", storeLanguage, appleID];
}

@end
