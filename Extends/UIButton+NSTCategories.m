//
//  UIButton+NSTCategories.m
//  NSTCategories
//
//  Created by Anatoly Shcherbinin on 10/8/19.
//

#import "NSTCategories.h"

@implementation UIButton (NSTCategories)

- (CGFloat)imageTitlePadding
{
    return self.titleEdgeInsets.left;
}

- (UIEdgeInsets)contentMargins
{
    var result = self.contentEdgeInsets;
    result.right -= self.imageTitlePadding;
    return result;
}

- (void)setImageTitlePadding:(CGFloat)imageTitlePadding
{
    [self setContentMargins:self.contentMargins imageTitlePaddings:imageTitlePadding];
}

- (void)setContentMargins:(UIEdgeInsets)contentMargins
{
    [self setContentMargins:contentMargins imageTitlePaddings:self.imageTitlePadding];
}

- (void)setContentMargins:(UIEdgeInsets)contentMargins imageTitlePaddings:(CGFloat)imageTitlePadding
{
    self.contentEdgeInsets = (UIEdgeInsets){
        .top = contentMargins.top,
        .left = contentMargins.left,
        .bottom = contentMargins.bottom,
        .right = contentMargins.right + imageTitlePadding
    };
    self.titleEdgeInsets = (UIEdgeInsets){
        .top = 0,
        .left = imageTitlePadding,
        .bottom = 0,
        .right = -imageTitlePadding
    };
}

@end
