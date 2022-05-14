//
//  UIResponder+Presentation.h
//  NSTCategories
//
//  Created by Anatoly Shcherbinin on 14.05.22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Presentation)

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion NS_SWIFT_DISABLE_ASYNC API_AVAILABLE(ios(5.0));

@end

NS_ASSUME_NONNULL_END
