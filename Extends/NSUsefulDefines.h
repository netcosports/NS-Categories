//
//  NSUsefulDefines.h
//  FoxSports
//
//  Created by Guillaume on 29/01/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#ifndef FoxSports_NSUsefulDefines_h
#define FoxSports_NSUsefulDefines_h

#pragma mark - DEBUG
#ifdef DEBUG
    #define DLog(...) NSLog(@"%s [line %d] : %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
    #define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]
#else
    #define DLog(...) do { } while (0)
    #ifndef NS_BLOCK_ASSERTIONS
        #define NS_BLOCK_ASSERTIONS
    #endif
    #define ALog(...) NSLog(@"%s [line %d] : %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#endif

#pragma mark - Shorteners
#define SWF(FORMAT,...) [NSString stringWithFormat:FORMAT,__VA_ARGS__]

#pragma mark - Conditions
#define EXISTS(object, class) (object && [object isKindOfClass:class])
#define DELEGATE_IMPLEMENTATION(delegate, selector) (delegate && [delegate respondsToSelector:selector])

#endif
