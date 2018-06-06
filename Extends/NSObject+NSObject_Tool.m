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

#define D_MAX_BG_QUEUE 20

@implementation NSObject (NSObject_Tool)

#pragma mark - QUEUES MANAGEMENT
+(dispatch_queue_t)backgroundQueueBlock:(void (^)())block
{
    static dispatch_queue_t ar_queue[D_MAX_BG_QUEUE];
    static dispatch_once_t onceToken;

    srand((unsigned int)time(NULL));
    int i = rand() % D_MAX_BG_QUEUE;
    dispatch_queue_t queue = NULL;

    if ([NSObject isMainQueue] == NO)
    {
        if (block)
            block();

        if (ar_queue)
            queue = ar_queue[i];
    }
    else
    {
        dispatch_once(&onceToken, ^{
            for (int index = 0; index < D_MAX_BG_QUEUE; index++)
            {
                ar_queue[index] = dispatch_queue_create([[NSString stringWithFormat:@"NS-Queue%d",i] cStringUsingEncoding:(NSUTF8StringEncoding)], NULL);
            }
        });
        queue = ar_queue[i];
        dispatch_async(queue, ^{
            if (block)
                block();
        });
    }
    return queue;
}

+(dispatch_queue_t)mainQueueBlock:(void (^)())block
{
    dispatch_queue_t queue = dispatch_get_main_queue();

    if ([NSObject isMainQueue])
    {
        if (block)
            block();
    }
    else
    {
        dispatch_sync(queue, ^{
            if (block)
                block();
        });
    }
    return queue;
}

+(BOOL)isMainQueue
{
    // Main queue is executed exclusively on the mainThread.
    if ([NSThread isMainThread])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)NSObject_Tool:(void(^)())block
{
    block();
}

-(void)performWithDelay:(NSTimeInterval)time block:(void(^)())block
{
    [self performSelector:@selector(NSObject_Tool:) withObject:[block copy] afterDelay:time];
}

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
