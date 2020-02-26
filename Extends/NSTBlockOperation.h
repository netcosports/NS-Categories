//
//  NSTBlockOperation.h
//  Pods
//
//  Created by Anatoly Shcherbinin on 2/26/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * NSBlockOperation doesn't release block after execution and can create retain cycles when some operations used block of other operations
 */
@interface NSTBlockOperation : NSOperation

+ (instancetype)blockOperationWithBlock:(void (^)(void))operationBlock;

@end

NS_ASSUME_NONNULL_END
