//
//  UIView+UIView_Tool.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kUIViewGradientColorkey = @"kUIViewGradientColorkey";
static NSString *kUIViewGradientColorIterations = @"kUIViewGradientColorIterations";

@interface UIView (UIView_Tool)

@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic, weak) id tagObjective;

+(instancetype)viewWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

-(void)bouingAppear:(BOOL)appear oncomplete:(void (^)(void))oncomplete;

-(void)zoomInAppear:(void (^)(void))oncomplete;
-(void)zoomInAppearWithAlphaEffect:(BOOL)isAlphaEffect completion:(void (^)(void))oncomplete;

- (void)shakeView:(void (^)(void))completion;
- (void)shakeViewWithIteration:(NSInteger)iterations direction:(NSInteger)direction completion:(void (^)(void))completion;

- (void)borderViewAnimation;
- (void)borderViewAnimation:(CGFloat)duration fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

-(void)highlight:(void (^)(void))oncomplete;
-(UIView*)addSubviewToBonce:(UIView*)view autoSizing:(BOOL)autosize;
-(UIView*)addSubviewToBonce:(UIView*)view;
-(UIView*)addSubviewToCenter:(UIView*)view;

-(UIView*)addSubviewToBonceWithConstraint:(UIView*)view;
-(UIView*)addSubviewToBonceWithConstraintWithoutLanguageDirection:(UIView*)view;
-(UIView*)addSubviewToBonceWithConstraint:(UIView*)view options:(NSLayoutFormatOptions)options;

-(UIView*)insertSubviewToBonce:(UIView*)view below:(UIView*)belowView autoSizing:(BOOL)autosize;
-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view below:(UIView*)belowView;
-(UIView*)insertSubviewToBonceWithConstraintWithoutLanguageDirection:(UIView*)view below:(UIView*)belowView;
-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view options:(NSLayoutFormatOptions)options below:(UIView*)belowView;

-(UIView*)insertSubviewToBonce:(UIView*)view above:(UIView*)aboveView autoSizing:(BOOL)autosize;
-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view above:(UIView*)aboveView;
-(UIView*)insertSubviewToBonceWithConstraintWithoutLanguageDirection:(UIView*)view above:(UIView*)aboveView;
-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view options:(NSLayoutFormatOptions)options above:(UIView*)aboveView;

-(void)addBasicConstraintsFromFrame:(CGRect)frame onView:(UIView *)subView;
-(NSLayoutConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute onView:(UIView *)firstView toView:(UIView *)secondView andConstant:(CGFloat)constant;
-(NSLayoutConstraint *)addConstraintOnView:(UIView *)firstView withLayoutAttribute:(NSLayoutAttribute)firstLayoutAttribute toView:(UIView *)secondView withLayoutAttribute:(NSLayoutAttribute)secondLayoutAttribute andConstant:(CGFloat)constant;

-(NSLayoutConstraint *)addConstraintEqualWidthOnView:(UIView *)firstView toView:(UIView *)secondView;
-(NSLayoutConstraint *)addConstraintEqualHeightOnView:(UIView *)firstView toView:(UIView *)secondView;
-(NSLayoutConstraint *)addConstraintHorizontalSpacingBetween:(UIView *)firstView andView:(UIView *)secondView withConstant:(CGFloat)constant;

-(void)setCenterJAPaddings:(id)paddings;
-(void)setCenterJA;
-(CGSize)renderRelatifInlineScroll:(BOOL)scroll align:(NSString*)align;
-(CGRect)renderRelativeSubviewsSetMyContentScrollHorizontal;
-(CGRect)renderRelativeSubviewsSetMyContentScrollHorizontalWithPadding:(id)paddings;
-(CGRect)renderRelativeSubviewsSetMyContentScroll:(BOOL)setContent;
-(CGRect)renderRelativeSubviewsSetMyContentScroll:(BOOL)setContent paddings:(id)paddings;
-(CGRect)renderRelativeSubviewsSetMyContentScrollWithoutParent:(BOOL)setContent paddings:(id)paddings;
-(UIView*)roundShadow;
-(UIView*)setBorder:(CGFloat)width color:(UIColor*)color;

-(void)visiteurView:(void(^)(UIView *elt))cbBefore cbAfter:(void(^)(UIView *elt))cbAfter;
-(NSInteger)setId:(NSString*)idview;
-(void)replavesubview:(NSArray*)newView keepOldView:(BOOL)keepOldView;
-(UIView*)getMasterView;
- (UIImage*)screenshot;

-(void)removeSubviews;
-(void)resignAllResponder;

#pragma mark - Gradients
+(UIView *) viewWithFrame:(CGRect)frame andGradients:(NSArray *)gradients onFrame:(CGRect)gradientFrame;
+(UIView *) viewWithFrame:(CGRect)frame startColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;
-(void) applyGradients:(NSArray *)gradients onFrame:(CGRect)gradientFrame;
-(void) applyGradients:(NSArray *)gradients;
-(void) applyGradientsWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;

@end
