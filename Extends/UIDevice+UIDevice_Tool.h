//
//  UIDevice+UIDevice_Tool.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface UIDevice (UIDevice_Tool)

-(NSString *) uniqueGlobalDeviceIdentifier;
-(NSString *) getDeviceType;

+(NSString *) getCarrierName;

+(BOOL) isUniversalApplication;
+(BOOL) isIPAD;
+(BOOL) isOrientationPortrait NS_EXTENSION_UNAVAILABLE_IOS("");

+(BOOL) isIphoneX;
+(BOOL) isIphone6Plus;
+(BOOL) isIphone6;
+(BOOL) isIphone5;
+(BOOL) isIphone4;
+(BOOL) isRetina;

+(int) getVerionsiOS;
+(CGRect) getScreenFrame;

+(NSString *) getDeviceCountry;
+(NSString *) getDeviceFullLanguage;
+(NSString *) getDeviceShortLanguage;

+(NSString *) getDeviceInfoInHtml;;

@end
