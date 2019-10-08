//
//  UIButton+NSTCategories.h
//  NSTCategories
//
//  Created by Anatoly Shcherbinin on 10/8/19.
//

#import <UIKit/UIKit.h>

@interface UIButton (NSTCategories)

@property (nonatomic) CGFloat imageTitlePadding;
@property (nonatomic) UIEdgeInsets contentMargins;

- (void)setContentMargins:(UIEdgeInsets)contentMargins imageTitlePaddings:(CGFloat)imageTitlePadding;

@end
