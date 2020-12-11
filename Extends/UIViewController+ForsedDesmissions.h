//
//  UIViewController+ForsedDesmissions.h
//  beIN-CONNECT
//
//  Created by Anatoly Shcherbinin on 16.03.17.
//  Copyright © 2017 NETCOSPORTS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ForsedDesmissions)

- (void)performBlockOnTransitionCompletion:(void (^)(void))performBlock;

/*!
 Usefull when need dismiss view controller
 Handles cases when dismissed view controller can be in transition state: dismission or presentation
 */
- (void)forseViewControllerDismissionAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

/*!
 Usefull when needs present something
 */
- (void)forsePresentedViewControllerDismissionAnimaged:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
