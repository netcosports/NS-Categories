//
//  NSObject+NSObject_Tool.m
//  Extends
//
//  Created by bigmac on 28/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import "NSObject+NSObject_Tool.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (NSObject_Tool)

-(NSDictionary *)serializeToDictionary
{
    Class clazz = [self class];
    u_int count;
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableDictionary* propertyDic = [NSMutableDictionary dictionaryWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char  *methodName = property_getName(properties[i]);
        NSString *method_name = [NSString  stringWithCString:methodName encoding:NSUTF8StringEncoding];
        @try {
            id val = [self valueForKey:method_name];
            [propertyDic setObject:val forKey:method_name];
        }
        @catch (NSException *exception) {

        }
        @finally {
        }
    }
    free(properties);
    return  propertyDic;
}
@end
