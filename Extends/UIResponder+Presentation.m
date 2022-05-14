//
//  UIResponder+Presentation.m
//  NSTCategories
//
//  Created by Anatoly Shcherbinin on 14.05.22.
//

#import "UIResponder+Presentation.h"

@implementation UIResponder (Presentation)

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [self.nextResponder presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
