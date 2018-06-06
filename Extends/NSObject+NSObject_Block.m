//
//  NSObject+NSObject_Block.m
//  FoxSports
//
//  Created by Guillaume on 25/11/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import "NSObject+NSObject_Block.h"
#import <objc/runtime.h>

#define D_MAX_BG_QUEUE 30

@interface NSObject (_NSObject_Block)
@property (copy, nonatomic) void(^commonCompletionBLock)(NSUInteger numberOfChildBlock);
@property (strong, nonatomic) NSNumber *numberBlockCallsBeforeCommonCompletionIsCalled;
@property (strong, nonatomic) NSNumber *currentNumberOfBlockCalls;
@end

@implementation NSObject (_NSObject_Block)

#pragma mark Setters
-(void)setCommonCompletionBLock:(void (^)(NSUInteger))completionBLock
{
    objc_setAssociatedObject(self, @selector(commonCompletionBLock), completionBLock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setNumberBlockCallsBeforeCommonCompletionIsCalled:(NSNumber *)numberBlockCalls
{
    objc_setAssociatedObject(self, @selector(numberBlockCallsBeforeCommonCompletionIsCalled), numberBlockCalls, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setCurrentNumberOfBlockCalls:(NSNumber *)currentNumber
{
    objc_setAssociatedObject(self, @selector(currentNumberOfBlockCalls), currentNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark Getters
-(void(^)(NSUInteger))commonCompletionBLock
{
    return (void(^)(NSUInteger))objc_getAssociatedObject(self, @selector(commonCompletionBLock));
}

-(NSNumber *)numberBlockCallsBeforeCommonCompletionIsCalled
{
    return (NSNumber *)objc_getAssociatedObject(self, @selector(numberBlockCallsBeforeCommonCompletionIsCalled));
}

-(NSNumber *)currentNumberOfBlockCalls
{
    return (NSNumber *)objc_getAssociatedObject(self, @selector(currentNumberOfBlockCalls));
}
@end

@implementation NSObject (NSObject_Block)

#pragma mark - Queue/Block management
+(dispatch_queue_t)backgroundQueueBlock:(void (^)(void))block
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
        queue = ar_queue[i];
    }
    else
    {
        dispatch_once(&onceToken, ^{
            for (int index = 0; index < D_MAX_BG_QUEUE; index++)
            {
                ar_queue[index] = dispatch_queue_create([[NSString stringWithFormat:@"NS-Queue_%d",i] cStringUsingEncoding:(NSUTF8StringEncoding)], DISPATCH_QUEUE_SERIAL);
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

+(dispatch_queue_t)mainQueueBlock:(void (^)(void))block
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

+(void)backgroundQueue:(dispatch_queue_t)queue withBlock:(void(^)(void))block
{
    dispatch_async(queue, ^{
        if (block)
            block();
    });
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

#pragma mark - Block with delay
-(void)NSObject_Tool:(void(^)())block
{
    block();
}

-(void)performWithDelay:(NSTimeInterval)time block:(void(^)())block
{
    [self performSelector:@selector(NSObject_Tool:) withObject:[block copy] afterDelay:time];
}

#pragma mark - Multiple block management
-(void)performCommonCompletionBlock:(void(^)(NSUInteger numberOfChildBlocksCalled))completionBlock afterNumberOfBlockCalls:(NSUInteger)numberOfCalls
{
    self.commonCompletionBLock = [completionBlock copy];
    self.numberBlockCallsBeforeCommonCompletionIsCalled = [NSNumber numberWithUnsignedInteger:numberOfCalls];
    self.currentNumberOfBlockCalls = [NSNumber numberWithUnsignedInteger:0];
}

-(void)updateNumberOfBlockCalls
{
    self.currentNumberOfBlockCalls = [NSNumber numberWithUnsignedInteger:[self.currentNumberOfBlockCalls unsignedIntegerValue] + 1];
    if ([self.currentNumberOfBlockCalls isEqualToNumber:self.numberBlockCallsBeforeCommonCompletionIsCalled] && self.commonCompletionBLock)
    {
        self.commonCompletionBLock([self.numberBlockCallsBeforeCommonCompletionIsCalled unsignedIntegerValue]);
        [self clearCommonCompletionBlock];
    }
}

-(void)clearCommonCompletionBlock
{
    self.commonCompletionBLock = nil;
    self.currentNumberOfBlockCalls = nil;
    self.numberBlockCallsBeforeCommonCompletionIsCalled = nil;
}

@end
