//
//  NSOperationQueue+Extension.h
//  beINCommon
//
//  Created by Anatoly Shcherbinin on 9/23/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSOperationQueue (Extension)

@property (nonatomic, readonly, class) NSOperationQueue *currentQueueOrBackground;

@end

NS_ASSUME_NONNULL_END
