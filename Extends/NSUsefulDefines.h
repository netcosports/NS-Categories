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
#define MEMBEROF(object, class) (object && [object isMemberOfClass:class])

#if !defined(_countof)
#if !defined(__cplusplus)
#define _countof(_Array) (sizeof(_Array) / sizeof(0[_Array]))
#else
template <typename _CountofType, size_t _SizeOfArray>
char (*__countof_helper(_CountofType (&_Array)[_SizeOfArray]))[_SizeOfArray];
#define _countof(_Array) sizeof(*__countof_helper(_Array))
#endif
#endif

/**
 Swift like guard else

 ````
 guard_let (<#obj#>, <#arg#>) else {
 <#code#>
 }
 ````

 Strongify example:
 ````
 __strong guard_let (<#obj#>, <#arg#>) else {
 return;
 }
 ````
 */
#define guard_let(obj, arg) typeof((arg)) (obj) = (arg); if (nil != (obj)) {}

/**
 Swift like if_let

 ````
 if_let (<#obj#>, <#arg#>) {
 <#code#>
 }
 ````

 Example with else:
 ````
 if_let (<#obj#>, <#arg#>) {
 <#code#>
 } else {
 <#code#>
 }
 ````
 */
#define if_let(obj, arg) for(BOOL stop_if_let = NO; !stop_if_let;) for(typeof((arg)) (obj) = (arg); !stop_if_let; stop_if_let = YES) if (nil != (obj))

#define STATIC_ASSERT(test, msg) typedef char _static_assert_ ## msg [ ((test) ? 1 : -1) ]

#define KINDOF_CAST(arg) ((__kindof typeof(arg))(arg))

#ifndef let
#if defined(__cplusplus)
#define let auto const
#else
#define let const __auto_type
#endif
#endif

#ifndef var
#if defined(__cplusplus)
#define var auto
#else
#define var __auto_type
#endif
#endif
#endif

#ifndef defer
CF_INLINE void nst_cleanUpBlock(void (^*block)(void)) {
    (*block)();
}

#define defer __attribute__((cleanup(nst_cleanUpBlock), unused)) void (^deferBlock ## __LINE__)(void) = ^(void)
#endif
