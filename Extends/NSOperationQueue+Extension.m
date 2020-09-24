//
//  NSOperationQueue+Extension.m
//  beINCommon
//
//  Created by Anatoly Shcherbinin on 9/23/20.
//

#import "NSOperationQueue+Extension.h"
#import "NSUsefulDefines.h"

@implementation NSOperationQueue (Extension)

+ (NSOperationQueue *)currentQueueOrBackground {
    if_let (currentQueue, self.currentQueue) {
        return currentQueue;
    }
    static dispatch_once_t onceToken;
    static NSOperationQueue *background;
    dispatch_once(&onceToken, ^{
        background = [[NSOperationQueue alloc] init];
    });
    return background;
}

@end
