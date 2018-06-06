//
//  UIDevice+UIDevice_Tool.m
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

#import "UIDevice+UIDevice_Tool.h"
#import "NSString+NSString_Tool.h"

@implementation UIDevice (UIDevice_Tool)

#pragma mark - Private Methods

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *) macaddress{

    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }

    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }

    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);

    return outstring;
}

// Returns device model on raw format
- (NSString *)platformRawString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);

    return platform;
}

- (NSString *) uniqueDeviceIdentifier
{
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
	if (!macaddress)
		return @"";
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
    NSString *uniqueIdentifier = [stringToHash md5];
    return uniqueIdentifier;
}

- (NSString *) uniqueGlobalDeviceIdentifier
{
    // New for > iOS 6
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
	if (!uniqueIdentifier)
		return @"";
    return [uniqueIdentifier strReplace:@"-" by:@""];
}

+(NSString *) getCarrierName
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    if (!carrier)
        return @"No Sim";
    NSString *carrierName = [carrier carrierName];
    if (!carrierName)
        carrierName = @"";
    return carrierName;
}

+(BOOL)isUniversalApplication
{
    NSArray *deviceFamily =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"UIDeviceFamily"];
    return [deviceFamily count]==2;
}

+(BOOL)isIPAD
{
	NSString * model = [[UIDevice currentDevice] model];
	return [model hasSubstring:@"iPad"];
}

+(BOOL)isOrientationPortrait
{
    if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortraitUpsideDown)
        return YES;
    return NO;
}

+(CGRect)getScreenFrame
{
	return CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

+(BOOL)isIphoneX
{
    return [UIDevice getScreenFrame].size.height == 812 ? YES : NO;
}

+(BOOL) isIphone6Plus
{
    return [UIDevice getScreenFrame].size.height == 736 ? YES : NO;
}

+(BOOL) isIphone6
{
    return [UIDevice getScreenFrame].size.height == 667 ? YES : NO;
}

+(BOOL) isIphone5
{
    return [UIDevice getScreenFrame].size.height == 568 ? YES : NO;
}

+(BOOL) isIphone4
{
    return [UIDevice getScreenFrame].size.height == 480 ? YES : NO;
}

+(BOOL)isRetina
{
    if ([UIScreen instancesRespondToSelector:@selector(scale)])
    {
        CGFloat scale = [[UIScreen mainScreen] scale];
        if (scale > 1.0)
        {
            return YES;
        }
    }
    return NO;
}

- (NSString *)getDeviceType
{
    NSString *platform = [self platformRawString];

    if ([platform isEqualToString:@"iPhone1,1"])
        return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])
        return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])
        return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])
        return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])
        return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])
        return @"iPhone 5";
    if ([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])
        return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])
        return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])
        return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])
        return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])
        return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])
        return @"iPad 3 (4G,2)";
    if ([platform isEqualToString:@"iPad3,3"])
        return @"iPad 3 (4G,3)";
    if ([platform isEqualToString:@"i386"])
        return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])
        return @"Simulator";
    return platform;
}

__strong static NSString *getVerionsiOS_systemVersion = nil;

+(int)getVerionsiOS
{
    if (getVerionsiOS_systemVersion == nil)
        getVerionsiOS_systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *sysv = getVerionsiOS_systemVersion;
    int valssys = 0;
    if ([sysv length] > 1)
        sysv = [sysv substringToIndex:1];
    valssys = [sysv intValue];
    return valssys;
}

+(NSString*)getDeviceShortLanguage
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *langs = [defs objectForKey:@"AppleLanguages"];
    NSString *l = [langs[0] substringToIndex:2];
    return l;
}

+(NSString*)getDeviceFullLanguage
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *langs = [defs objectForKey:@"AppleLanguages"];
    NSString *l = langs[0];
    return l;
}

+(NSString*)getDeviceCountry
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSString *langs = [defs objectForKey:@"AppleLocale"];
    NSString *l = [langs substringFromIndex:3];
    if ([l length] == 0)
        l = langs ;
    return l;
}

+(NSString*)getDeviceInfoInHtml
{
    NSString *language = [[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[UIDevice getDeviceShortLanguage]] capitalizedString];

    NSString *deviceInfo = [NSString stringWithFormat:@"[Device]<br>Model: %@<br>System version: %@<br>Language: %@<br>UUID: %@<br>",
                            [[UIDevice currentDevice] model],
                            [[UIDevice currentDevice] systemVersion],
                            language,
                            [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]];

    NSString *appInfo = [NSString stringWithFormat:@"[Application]<br>Display name: %@<br>Version (build): %@ (%@)<br>",
                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"],
                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];

    return [NSString stringWithFormat:@"%@<br>%@", deviceInfo, appInfo];
}
@end


