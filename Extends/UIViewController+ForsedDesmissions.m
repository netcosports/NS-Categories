//
//  UIViewController+ForsedDesmissions.m
//  beIN-CONNECT
//
//  Created by Anatoly Shcherbinin on 16.03.17.
//  Copyright © 2017 NETCOSPORTS. All rights reserved.
//

#import "NSUsefulDefines.h"
#import "UIViewController+ForsedDesmissions.h"

@implementation UIViewController (ForsedDesmissions)

- (void)performBlockOnTransitionCompletion:(void (^)(void))performBlock
{
    if_let (transitionCoordinator, self.transitionCoordinator) {
        [transitionCoordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            [self performBlockOnTransitionCompletion:performBlock];
        }];
    } else {
        performBlock();
    }
}

- (void)forseViewControllerDismissionAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion
{
    if (self.isBeingDismissed) {
        if (nil != completion) {
            if_let (transitionCoordinator, self.transitionCoordinator) {
                [self.transitionCoordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    completion();
                }];
            } else {
                completion();
            }
        }
        return;
    }
    [self performBlockOnTransitionCompletion:^{
        [self dismissViewControllerAnimated:animated completion:completion];
    }];
}

- (void)forsePresentedViewControllerDismissionAnimaged:(BOOL)animated completion:(void (^)(void))completion
{
    if_let(presentedViewController, self.presentedViewController) {
        [presentedViewController forseViewControllerDismissionAnimated:animated completion:completion];
        return;
    }
    if (nil != completion) {
        completion();
    }
}

@end
