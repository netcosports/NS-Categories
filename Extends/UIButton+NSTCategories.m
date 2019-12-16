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
    return UIUserInterfaceLayoutDirectionLeftToRight == self.nst_userInterfaceLayoutDirection
    ? self.titleEdgeInsets.left
    : self.titleEdgeInsets.right;
}

- (UIEdgeInsets)contentMargins
{
    var result = self.contentEdgeInsets;

    if (UIUserInterfaceLayoutDirectionLeftToRight == self.nst_userInterfaceLayoutDirection) {
        result.right -= self.imageTitlePadding;
    } else {
        result.left -= self.imageTitlePadding;
    }
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
    if (UIUserInterfaceLayoutDirectionLeftToRight == self.nst_userInterfaceLayoutDirection) {
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
    } else {
        self.contentEdgeInsets = (UIEdgeInsets){
            .top = contentMargins.top,
            .left = contentMargins.left + imageTitlePadding,
            .bottom = contentMargins.bottom,
            .right = contentMargins.right
        };
        self.titleEdgeInsets = (UIEdgeInsets){
            .top = 0,
            .left = -imageTitlePadding,
            .bottom = 0,
            .right = imageTitlePadding
        };
    }
}

@end
