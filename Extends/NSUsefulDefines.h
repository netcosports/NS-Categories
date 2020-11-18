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


///MARK: - let_weak_self and if_let_weak_self

#ifndef _self_refCount_Check

#ifdef DEBUG

#define _self_refCount_Check() \
    let _unowned_self_ref = (__bridge CFTypeRef)self; \
    let _self_refCount = CFGetRetainCount(_unowned_self_ref); \
    defer { \
        let _refCountDelta = CFGetRetainCount(_unowned_self_ref) - _self_refCount; \
        NSCAssert(_refCountDelta <= 0, @"self refCount is changed at %d", (int)_refCountDelta); \
    }

#else

#define _self_refCount_Check() ((void)0)

#endif
#endif

/**
 Create block with weakified self

 source: https://habr.com/ru/company/viber/blog/232185/

 Example:
 ````
 ^let_weak_self(<#ARGS#>) {
     <#body#>
 } unlet_weak_self
 ````
 */
#define let_weak_self(ARGS...) \
(void){  __weak let _private_weakSelf = self; \
    _self_refCount_Check(); \
    return ^(ARGS) { \
        __strong let self = _private_weakSelf; \
        return ^ (void) {

#define unlet_weak_self \
        }(); \
    }; \
}()

/**
 Create void-block that executes if weakified self not nil

 source: https://habr.com/ru/company/viber/blog/232185/

 ````
 ^if_let_weak_self(<#ARGS#>) {
     <#body#>
 } unlet_weak_self
 ````
 */
#define if_let_weak_self(ARGS...) \
(void){  __weak let _private_weakSelf = self; \
    _self_refCount_Check(); \
    return ^(ARGS) { \
        __strong let _self_not_nil_check = _private_weakSelf; \
        let self = _self_not_nil_check; \
        return ^ (void) { if (nil != _self_not_nil_check)


#endif
