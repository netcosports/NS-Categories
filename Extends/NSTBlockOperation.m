//
//  NSTBlockOperation.m
//  Pods
//
//  Created by Anatoly Shcherbinin on 2/26/20.
//

#import "NSTBlockOperation.h"

@interface NSTBlockOperation ()

@property (nonatomic) void (^operationBlock)(void);

@end

@implementation NSTBlockOperation

- (instancetype)initWithOperationBlock:(void (^)(void))operationBlock
{
    self = [super init];
    if (nil == self) {
        return nil;
    }
    _operationBlock = operationBlock;
    return self;
}

+ (instancetype)blockOperationWithBlock:(void (^)(void))operationBlock
{
    return [[self alloc] initWithOperationBlock:operationBlock];
}

- (void)main
{
    [super main];
    self.operationBlock();
    self.operationBlock = nil;
}

@end
