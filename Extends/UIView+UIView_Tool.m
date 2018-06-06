//
//  UIView+UIView_Tool.m
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#import "UIView+UIView_Tool.h"
#import "NSObject+NSObject_Xpath.h"
#import "NSString+NSString_Tool.h"
#import "NSObject+NSObject_Tool.h"
#import "UIDevice+UIDevice_Tool.h"
#import "NSArray+NSArray_Bundle.h"
#import "NSUsefulDefines.h"

static const char * const kParentViewControllerKey = "kParentViewControllerKey";
static const char * const kTagObjectiveKey = "kTagObjectiveKey";

@implementation UIView (UIView_Tool)

#pragma mark Properties set/get
- (id)parentViewController
{
    return objc_getAssociatedObject(self, kParentViewControllerKey);
}

- (void)setParentViewController:(UIViewController *)controller
{
    objc_setAssociatedObject(self, kParentViewControllerKey, controller, OBJC_ASSOCIATION_ASSIGN);
}

- (id)tagObjective
{
    return objc_getAssociatedObject(self, kTagObjectiveKey);
}

- (void)setTagObjective:(id)obj
{
    objc_setAssociatedObject(self, kTagObjectiveKey, obj, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark Instance methods
+(instancetype)viewWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibBundleOrNil = nibBundleOrNil ? nibBundleOrNil : [NSBundle mainBundle];
    nibNameOrNil = nibNameOrNil ? nibNameOrNil : NSStringFromClass([self class]);
    
    id view = [[nibBundleOrNil loadNibNamed:nibNameOrNil owner:nil options:nil] getObjectsType:[self class]];
    return view;
}

-(void)bouingAppear:(BOOL)appear oncomplete:(void (^)(void))oncomplete{
    if (!appear){
        self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0);
        CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        bounceAnimation.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:1.0],
                                  [NSNumber numberWithFloat:0.8],
                                  [NSNumber numberWithFloat:1.1],
                                  [NSNumber numberWithFloat:0.3], nil];
        bounceAnimation.duration = 0.5;
        bounceAnimation.removedOnCompletion = NO;
        [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
        self.layer.transform = CATransform3DIdentity;
        
        [UIView animateWithDuration:0.6 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (oncomplete){
                oncomplete();
            }
        }];
        return;
    }
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
        if (oncomplete){
            oncomplete();
        }
    }];
    self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.3],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.8],
                              [NSNumber numberWithFloat:1.0], nil];
    bounceAnimation.duration = 0.5;
    bounceAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
    self.layer.transform = CATransform3DIdentity;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0ul);
    dispatch_async(queue, ^{
        usleep(bounceAnimation.duration *1000);
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (oncomplete){
                oncomplete();
            }
        });
    });
    
}

-(void)zoomInAppear:(void (^)(void))oncomplete{
    [self zoomInAppearWithAlphaEffect:NO completion:^{
        if (oncomplete) {
            oncomplete();
        }
    }];
}

-(void)zoomInAppearWithAlphaEffect:(BOOL)isAlphaEffect completion:(void (^)(void))oncomplete{
    if (isAlphaEffect){
        self.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            if (oncomplete){
                
                oncomplete();
            }
        }];
    }
    self.layer.transform = CATransform3DMakeScale(1.15, 1.15, 1.0);
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[
                               [NSNumber numberWithFloat:1.15],
                               [NSNumber numberWithFloat:1.0],
                               ];
    bounceAnimation.duration = 0.5;
    bounceAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:bounceAnimation forKey:@"zoomIn"];
    self.layer.transform = CATransform3DIdentity;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0ul);
    dispatch_async(queue, ^{
        usleep(bounceAnimation.duration *1000);
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (oncomplete){
                oncomplete();
            }
        });
    });
    
}

-(void)highlight:(void (^)(void))oncomplete{
 	self.alpha = 0;
    
	[UIView animateWithDuration:0.7 animations:^{
		self.alpha = 1;
	} completion:^(BOOL finished) {
		if (!finished) return ;
		[UIView animateWithDuration:0.7 animations:^{
			self.alpha = 0.2;
		} completion:^(BOOL finished) {
			if (!finished) return ;
			[UIView animateWithDuration:0.7 animations:^{
				self.alpha = 1;
			} completion:^(BOOL finished) {
				if (!finished) return ;
				[UIView animateWithDuration:0.7 animations:^{
					self.alpha = 0.5;
				} completion:^(BOOL finished) {
					if (!finished) return ;
					[UIView animateWithDuration:0.7 animations:^{
						self.alpha = 1;
					} completion:^(BOOL finished) {
						if (!finished) return ;
						oncomplete();
					}];
				}];
			}];
		}];
	}];
}

-(UIView*)addSubviewToBonce:(UIView*)view{
	return [self addSubviewToBonce:view autoSizing:NO];
}

-(UIView*)addSubviewToBonceWithConstraint:(UIView*)view{
    return [self addSubviewToBonceWithConstraint:view options:0];
}

-(UIView*)addSubviewToBonceWithConstraintWithoutLanguageDirection:(UIView*)view{
    return [self addSubviewToBonceWithConstraint:view options:NSLayoutFormatDirectionLeftToRight];
}

-(UIView*)addSubviewToBonceWithConstraint:(UIView*)view options:(NSLayoutFormatOptions)options{
    if (!view)
        return self;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    id posx = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:options metrics:nil views:NSDictionaryOfVariableBindings(view)];
    id posy = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    [self addConstraints:posx];
    [self addConstraints:posy];
    return self;
}

-(UIView*)insertSubviewToBonce:(UIView*)view below:(UIView*)belowView autoSizing:(BOOL)autosize {
    if (autosize)
        [view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    view.frame = self.bounds;
    [self insertSubview:view belowSubview:belowView];
    return view;
}

-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view below:(UIView*)belowView {
    return [self insertSubviewToBonceWithConstraint:view options:0 below:belowView];
}

-(UIView*)insertSubviewToBonceWithConstraintWithoutLanguageDirection:(UIView*)view below:(UIView*)belowView {
    return [self insertSubviewToBonceWithConstraint:view options:NSLayoutFormatDirectionLeftToRight below:belowView];
}

-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view options:(NSLayoutFormatOptions)options below:(UIView*)belowView {
    if (!view || !belowView)
        return self;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self insertSubview:view belowSubview:belowView];
    id posx = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:options metrics:nil views:NSDictionaryOfVariableBindings(view)];
    id posy = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    [self addConstraints:posx];
    [self addConstraints:posy];
    return self;
}

-(UIView*)insertSubviewToBonce:(UIView*)view above:(UIView*)aboveView autoSizing:(BOOL)autosize {
    if (autosize)
        [view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    view.frame = self.bounds;
    [self insertSubview:view aboveSubview:aboveView];
    return view;
}

-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view above:(UIView*)aboveView {
    return [self insertSubviewToBonceWithConstraint:view options:0 above:aboveView];
}

-(UIView*)insertSubviewToBonceWithConstraintWithoutLanguageDirection:(UIView*)view above:(UIView*)aboveView {
    return [self insertSubviewToBonceWithConstraint:view options:NSLayoutFormatDirectionLeftToRight above:aboveView];
}

-(UIView*)insertSubviewToBonceWithConstraint:(UIView*)view options:(NSLayoutFormatOptions)options above:(UIView*)aboveView {
    if (!view || !aboveView)
        return self;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self insertSubview:view aboveSubview:aboveView];
    id posx = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:options metrics:nil views:NSDictionaryOfVariableBindings(view)];
    id posy = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
    [self addConstraints:posx];
    [self addConstraints:posy];
    return self;
}

-(UIView*)addSubviewToBonce:(UIView*)view autoSizing:(BOOL)autosize{
	if (autosize)
		[view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
	view.frame = self.bounds;
	[self addSubview:view];
	return view;
}

-(UIView*)addSubviewToCenter:(UIView*)view{
	
	CGRect r = self.bounds;
	r.origin.x = (self.bounds.size.width - view.frame.size.width)/2;
	r.origin.y = (self.bounds.size.height - view.frame.size.height)/2;
	r.size = view.frame.size;
	view.frame  = r;
	[self addSubview:view];
	return view;
}

-(void)addBasicConstraintsFromFrame:(CGRect)frame onView:(UIView *)subView
{
    NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:subView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:frame.origin.y];
    
    NSLayoutConstraint *constraintLeading = [NSLayoutConstraint constraintWithItem:subView
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1.0
                                                                          constant:frame.origin.x];
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:subView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:frame.size.width];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:subView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:frame.size.height];

    [self addConstraint:constraintTop];
    [self addConstraint:constraintLeading];
    [self addConstraint:constraintWidth];
    [self addConstraint:constraintHeight];
}

-(NSLayoutConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute onView:(UIView *)firstView toView:(UIView *)secondView andConstant:(CGFloat)constant
{
    NSLayoutConstraint *customConstraint = [NSLayoutConstraint constraintWithItem:firstView
                                                                        attribute:layoutAttribute
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:secondView
                                                                        attribute:layoutAttribute
                                                                       multiplier:1.0
                                                                         constant:constant];
    [self addConstraint:customConstraint];
    return customConstraint;
}

-(NSLayoutConstraint *)addConstraintOnView:(UIView *)firstView withLayoutAttribute:(NSLayoutAttribute)firstLayoutAttribute toView:(UIView *)secondView withLayoutAttribute:(NSLayoutAttribute)secondLayoutAttribute andConstant:(CGFloat)constant
{
    NSLayoutConstraint *customConstraint = [NSLayoutConstraint constraintWithItem:firstView
                                                                        attribute:firstLayoutAttribute
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:secondView
                                                                        attribute:secondLayoutAttribute
                                                                       multiplier:1.0
                                                                         constant:constant];
    [self addConstraint:customConstraint];
    return customConstraint;
}

-(NSLayoutConstraint *)addConstraintEqualWidthOnView:(UIView *)firstView toView:(UIView *)secondView
{
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth onView:firstView toView:secondView andConstant:0];
}

-(NSLayoutConstraint *)addConstraintEqualHeightOnView:(UIView *)firstView toView:(UIView *)secondView
{
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight onView:firstView toView:secondView andConstant:0];
}

-(NSLayoutConstraint *)addConstraintHorizontalSpacingBetween:(UIView *)firstView andView:(UIView *)secondView withConstant:(CGFloat)constant
{
    return [self addConstraintOnView:firstView withLayoutAttribute:NSLayoutAttributeLeading toView:secondView withLayoutAttribute:NSLayoutAttributeTrailing andConstant:constant];
}

-(void)setCenterJAPaddings:(id)paddings{
	[self renderRelativeSubviewsSetMyContentScroll:NO paddings:paddings];
	CGFloat w = 0;
	for (UIView *v in [self subviews]) {
		if (!v.hidden && (v.frame.origin.x+v.frame.size.width) >= w)
			w = v.frame.origin.x+v.frame.size.width;
	}
	float ww = self.frame.size.width;
	float decalage = (ww-w)/2;
	for (UIView *v in [self subviews]) {
		if (!v.hidden){
			CGRect r = v.frame;
			r.origin.x += decalage;
			v.frame = r;
		}
	}
}

-(CGSize)renderRelatifInlineScroll:(BOOL)scroll align:(NSString*)align{
	CGSize ret = CGSizeZero;
	__block CGFloat w = 0;
	__block CGFloat h = 0;
	
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIView *e = obj;
        CGRect r = e.frame;
        r.origin.x = w;
        w += r.size.width;
        r.origin.y = 0;
        e.frame = r;
        h = MAX(h, r.size.height);
    }];

    ret.height = h;
	ret.width = w;
	
	if([align hasSubstring:@"right"])
    {
		CGFloat diff = self.frame.size.width - w;
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
			UIView *e = obj;
			CGRect r = e.frame;
			r.origin.x += diff ;
			e.frame = r;
		}];
	}
	if([align hasSubstring:@"bottom"])
    {
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
			UIView *e = obj;
			CGRect r = e.frame;
			r.origin.y = self.frame.size.height - e.frame.size.height;
			e.frame = r;
		}];
	}
	if([align hasSubstring:@"middle"])
    {
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
			UIView *e = obj;
			CGRect r = e.frame;
			r.origin.y = self.frame.size.height/2 - e.frame.size.height/2;
			e.frame = r;
		}];
	}
	if (align && [self isKindOfClass:[UIScrollView class]]){
		UIScrollView *s = (UIScrollView*)self;
		s.contentSize = ret;
	}
	
	return ret;
}
-(void)setCenterJA{
	[self setCenterJAPaddings:nil];
}

-(CGRect)renderRelativeSubviewsSetMyContentScroll:(BOOL)setContent{
	return [self renderRelativeSubviewsSetMyContentScroll:setContent paddings:nil];
}

-(CGRect)renderRelativeSubviewsSetMyContentScrollHorizontal{
    return [self renderRelativeSubviewsSetMyContentScrollHorizontalWithPadding:nil];
}

-(CGRect)renderRelativeSubviewsSetMyContentScrollHorizontalWithPadding:(id)paddings{
    BOOL isShowScollH = NO;
    if ([self isKindOfClass:[UIScrollView class]]){
        UIScrollView *elt  = (UIScrollView *)self;
        isShowScollH = elt.showsHorizontalScrollIndicator;
        [elt setShowsHorizontalScrollIndicator:NO];
    }
    CGRect rectO = self.frame;
    CGRect rectchange = self.frame;
    rectchange.size.width = 50000;
    self.frame = rectchange;
    [self renderRelativeSubviewsSetMyContentScroll:YES paddings:paddings];
    __block CGFloat wm = 0;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         UIView  *v = obj;
         CGFloat wc = v.frame.origin.x + v.frame.size.width;
         if(wc > wm && !v.hidden)
             wm = wc;
     }];
    if([self isKindOfClass:[UIScrollView class]]){
        UIScrollView *elt  = (UIScrollView *)self;
        [elt setContentSize:CGSizeMake(wm, rectO.size.height)];
        [elt setShowsHorizontalScrollIndicator:isShowScollH];
    }
    self.frame = rectO;
    return CGRectMake(rectO.origin.x, rectO.origin.y, wm, rectO.size.height);
}

-(CGRect)renderRelativeSubviewsSetMyContentScroll:(BOOL)setContent paddings:(id)paddings{
    NSMutableArray *all = [[self subviews] ToMutable];
    
    NSMutableArray *l_frame = [NSMutableArray array];
    CGFloat hall = 0;
    CGRect prev = CGRectZero;
    while ([all count] ) {
		UIView *v = [all objectAtIndex:0];
		if(v.hidden){
			[all removeObjectAtIndex:0];
			continue;
		}
		
		CGFloat top = 0;
		CGFloat bottom = 0;
		CGFloat left = 0;
		CGFloat right = 0;
		NSValue *val = nil ;
		if ([paddings isKindOfClass:[NSDictionary class]]){
			val = [paddings objectForKey:@((NSInteger)v)];
		}
		
		if ([paddings isKindOfClass:[NSValue class]])
			val = (NSValue*)paddings;
		
		if (val){
			CGRect pad = [val CGRectValue];
			left = pad.origin.x;
			top = pad.origin.y;
			right = pad.size.width;
			bottom = pad.size.height;
		}
		
		CGFloat wi = v.frame.size.width + right+left;
		
		CGFloat wframe = self.frame.size.width;
		/*for (int i = [l_frame count] -1; i>0 && i >[l_frame count] -2; i--) {
         NSValue *v = [l_frame objectAtIndex:i];
         CGRect p = [v CGRectValue];
         //prev = p;
         wframe = self.frame.size.width-p.origin.x-p.size.width;
		 
         }*/
		// si place à dorite
		if ([l_frame count]  && prev.origin.x + prev.size.width + wi <= wframe){
			v.frame = CGRectMake(prev.origin.x+prev.size.width +left, prev.origin.y+top, v.frame.size.width,v.frame.size.height);
			// update frame
			if (prev.size.height > v.frame.size.height+top+bottom){
				// add frame
				CGRect r = CGRectMake(v.frame.origin.x-left, v.frame.origin.y+v.frame.size.height+bottom, self.frame.size.width-(v.frame.origin.x-left), v.frame.size.height+top+bottom);
                //				[l_frame addObject:[NSValue valueWithCGRect:r]];
				[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
			}else{
				// change old frame
				NSValue *l = (NSValue *)[l_frame objectAtIndex:0];
				CGRect r = [l CGRectValue];
				r.origin.y = v.frame.origin.y-top + v.frame.size.height+top+bottom;
				[l_frame removeObjectAtIndex:0];
                //				[l_frame addObject:[NSValue valueWithCGRect:r]];
				[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
			}
		}else{// sinon place en dessous
			// caclule de H
			CGFloat yo = prev.origin.y + prev.size.height;
			CGFloat xo = prev.origin.x;
			for (;  [l_frame count]; ) {
				NSValue *l = (NSValue *)[l_frame objectAtIndex:0];
				CGRect r = [l CGRectValue];
				if (yo  >= r.origin.y){
					[l_frame removeObjectAtIndex:0];
					xo = xo > r.origin.x ? r.origin.x : xo;
					
				}else{
					if (self.frame.size.width -xo >= v.frame.size.width+left+right){ // dans cette frame
						//xo = r.origin .x;
						//xo = xo > r.origin.x ? r.origin.x : xo;
						
						r = CGRectMake(xo, yo, self.frame.size.width -xo, 20);
						//[l_frame addObject:[NSValue valueWithCGRect:r]];
						[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
                        
						break;
					}else{
						[l_frame removeObjectAtIndex:0];
						xo = xo > r.origin.x ? r.origin.x : xo;
						yo = r.origin.y >= yo ? r.origin.y : yo;
						r = CGRectMake(xo, yo, self.frame.size.width -xo, 20);
						//[l_frame addObject:[NSValue valueWithCGRect:r]];
						[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
                        
						// pas dans la merde
					}
					
				}
			}
			if (![l_frame count]){
				CGRect r = CGRectMake(xo, yo, self.frame.size.width -xo, 20);
				[l_frame addObject:[NSValue valueWithCGRect:r]];
			}
			// add frame
			NSValue *l = (NSValue *)[l_frame objectAtIndex:0];
			CGRect r = [l CGRectValue];
			v.frame = CGRectMake(r.origin.x	+ left, r.origin.y+top, v.frame.size.width,v.frame.size.height);
			// create frame ???
			r = CGRectMake(v.frame.origin.x-left, v.frame.origin.y+v.frame.size.height+bottom-top, self.frame.size.width -xo, 20);
            //			[l_frame addObject:[NSValue valueWithCGRect:r]];
			//[l_frame removeObjectAtIndex:0];
			[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
			
			
		}// fin si
		prev = v.frame;
		prev.size.width += left+right;
		prev.origin.x -= left;
		prev.origin.y -= top;
		prev.size.height += top + bottom;
		
		hall = prev.size.height + prev.origin.y > hall ? prev.size.height + prev.origin.y  : hall;
		[all removeObjectAtIndex:0];
	}
	
	if (setContent && [self.superview isKindOfClass:[UIScrollView class]]){
		UIScrollView *p = (UIScrollView *) self.superview;
		[p setContentSize:CGSizeMake(self.frame.size.width, hall)];
	}else if (setContent && [self isKindOfClass:[UIScrollView class]]){
		UIScrollView *p = (UIScrollView *) self;
		[p setContentSize:CGSizeMake(self.frame.size.width, hall)];
	}
	return CGRectMake(0,0,self.frame.size.width, hall);
}

-(CGRect)renderRelativeSubviewsSetMyContentScrollWithoutParent:(BOOL)setContent paddings:(id)paddings{
	NSMutableArray *all = [[self subviews] ToMutable];
	
	NSMutableArray *l_frame = [NSMutableArray array];
	CGFloat hall = 0;
	CGRect prev = CGRectZero;
	while ([all count] ) {
		UIView *v = [all objectAtIndex:0];
		if(v.hidden){
			[all removeObjectAtIndex:0];
			continue;
		}
		
		CGFloat top = 0;
		CGFloat bottom = 0;
		CGFloat left = 0;
		CGFloat right = 0;
		NSValue *val = nil ;
		if ([paddings isKindOfClass:[NSDictionary class]]){
			val = [paddings objectForKey:@((NSInteger)v)];
		}
		
		if ([paddings isKindOfClass:[NSValue class]])
			val = (NSValue*)paddings;
		
		if (val){
			CGRect pad = [val CGRectValue];
			left = pad.origin.x;
			top = pad.origin.y;
			right = pad.size.width;
			bottom = pad.size.height;
		}
		
		CGFloat wi = v.frame.size.width + right+left;
		
		CGFloat wframe = self.frame.size.width;
		/*for (int i = [l_frame count] -1; i>0 && i >[l_frame count] -2; i--) {
         NSValue *v = [l_frame objectAtIndex:i];
         CGRect p = [v CGRectValue];
         //prev = p;
         wframe = self.frame.size.width-p.origin.x-p.size.width;
		 
         }*/
		// si place à dorite
		if ([l_frame count]  && prev.origin.x + prev.size.width + wi <= wframe){
			v.frame = CGRectMake(prev.origin.x+prev.size.width +left, prev.origin.y+top, v.frame.size.width,v.frame.size.height);
			// update frame
			if (prev.size.height > v.frame.size.height+top+bottom){
				// add frame
				CGRect r = CGRectMake(v.frame.origin.x-left, v.frame.origin.y+v.frame.size.height+bottom, self.frame.size.width-(v.frame.origin.x-left), v.frame.size.height+top+bottom);
                //				[l_frame addObject:[NSValue valueWithCGRect:r]];
				[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
			}else{
				// change old frame
				NSValue *l = (NSValue *)[l_frame objectAtIndex:0];
				CGRect r = [l CGRectValue];
				r.origin.y = v.frame.origin.y-top + v.frame.size.height+top+bottom;
				[l_frame removeObjectAtIndex:0];
                //				[l_frame addObject:[NSValue valueWithCGRect:r]];
				[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
			}
		}else{// sinon place en dessous
			// caclule de H
			CGFloat yo = prev.origin.y + prev.size.height;
			CGFloat xo = prev.origin.x;
			for (;  [l_frame count]; ) {
				NSValue *l = (NSValue *)[l_frame objectAtIndex:0];
				CGRect r = [l CGRectValue];
				if (yo  >= r.origin.y){
					[l_frame removeObjectAtIndex:0];
					xo = xo > r.origin.x ? r.origin.x : xo;
					
				}else{
					if (self.frame.size.width -xo >= v.frame.size.width+left+right){ // dans cette frame
						//xo = r.origin .x;
						//xo = xo > r.origin.x ? r.origin.x : xo;
						
						r = CGRectMake(xo, yo, self.frame.size.width -xo, 20);
						//[l_frame addObject:[NSValue valueWithCGRect:r]];
						[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
                        
						break;
					}else{
						[l_frame removeObjectAtIndex:0];
						xo = xo > r.origin.x ? r.origin.x : xo;
						yo = r.origin.y >= yo ? r.origin.y : yo;
						r = CGRectMake(xo, yo, self.frame.size.width -xo, 20);
						//[l_frame addObject:[NSValue valueWithCGRect:r]];
						[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
                    }
					
				}
			}
			if (![l_frame count]){
				CGRect r = CGRectMake(xo, yo, self.frame.size.width -xo, 20);
				[l_frame addObject:[NSValue valueWithCGRect:r]];
			}
			// add frame
			NSValue *l = (NSValue *)[l_frame objectAtIndex:0];
			CGRect r = [l CGRectValue];
			v.frame = CGRectMake(r.origin.x	+ left, r.origin.y+top, v.frame.size.width,v.frame.size.height);
			// create frame ???
			r = CGRectMake(v.frame.origin.x-left, v.frame.origin.y+v.frame.size.height+bottom-top, self.frame.size.width -xo, 20);
            //			[l_frame addObject:[NSValue valueWithCGRect:r]];
			//[l_frame removeObjectAtIndex:0];
			[l_frame insertObject:[NSValue valueWithCGRect:r] atIndex:0];
			
			
		}// fin si
		prev = v.frame;
		prev.size.width += left+right;
		prev.origin.x -= left;
		prev.origin.y -= top;
		prev.size.height += top + bottom;
		
		hall = prev.size.height + prev.origin.y > hall ? prev.size.height + prev.origin.y  : hall;
		[all removeObjectAtIndex:0];
	}
	
	if (setContent && [self isKindOfClass:[UIScrollView class]]){
		UIScrollView *p = (UIScrollView *) self;
		[p setContentSize:CGSizeMake(self.frame.size.width, hall)];
	}
	return CGRectMake(0,0,self.frame.size.width, hall);
}

-(void)visiteurView:(void(^)(UIView *elt))cbBefore cbAfter:(void(^)(UIView *elt))cbAfter
{
    if(!cbAfter && !cbBefore)
    {
        return;
    }
    if (cbBefore)
    {
        cbBefore(self);
    }
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        [obj visiteurView:cbBefore cbAfter:cbAfter];
    }];
    if (cbAfter)
        cbAfter(self);
}

-(UIView*)roundShadow{
	[self.layer setCornerRadius:5];
	[self.layer setShadowColor:[UIColor blackColor].CGColor];
	[self.layer setShadowOpacity:0.34];
	[self.layer setShadowRadius:2.0];
	[self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
	CGRect shadowFrame = self.layer.bounds;
	CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
	self.layer.shadowPath = shadowPath;
	if(self.clipsToBounds)
		[self setClipsToBounds:NO];
	return self;
}
-(UIView*)setBorder:(CGFloat)width color:(UIColor*)color{
	[self.layer setBorderColor:color.CGColor];
	[self.layer setBorderWidth:width];
	return self;
}
-(NSInteger)setId:(NSString*)idview{
    if([idview isEqualToString:@""])
    self.tag = [idview crc32];
    return self.tag;
}

-(void)replavesubview:(NSArray*)newView keepOldView:(BOOL)keepOldView
{
    __block NSMutableArray *sup = [@[] ToMutable];
    __block NSMutableArray *add = [newView ToMutable];
    //    __block NSMutableArray *replace = [@[] ToMutable];
    __block NSMutableDictionary *keyvalnew = [ @{} ToMutable];
    
    [newView enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIView *v = obj;
        keyvalnew[@(v.tag)] = obj;
    }];
    
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIView *v = obj;
        if (keyvalnew[@(v.tag)]){
            UIView *obj = keyvalnew[@(v.tag)];
            if (!keepOldView){
                [add removeObject:obj];
                obj.frame = v.frame;
                [v removeFromSuperview];
                [self insertSubview:obj atIndex:idx];
            }
        }else{
            [sup addObject:obj];
        }
    }];

    void (^__weak  r_recustion)() = nil;
    void (^__block  recustion)() = ^(){
        if ([sup count]) {
            UIView *elt = sup[0];
            [sup removeObject:elt];
            [UIView animateWithDuration:0.1 animations:^{
                elt.alpha = 0;
            } completion:^(BOOL finished) {
                [elt removeFromSuperview];
                [UIView animateWithDuration:0.1 animations:^{
                    [self renderRelativeSubviewsSetMyContentScroll:NO];
                } completion:^(BOOL finished) {
                    
                    r_recustion();
                }];
            }];
        }else if ([add count]){
            UIView *elt = sup[0];
            [add removeObject:elt];
            elt.alpha = 0;
            [self insertSubview:elt atIndex:[newView indexOfObject:elt]];
            [UIView animateWithDuration:0.1 animations:^{
                [self renderRelativeSubviewsSetMyContentScroll:NO];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    elt.alpha = 1;
                } completion:^(BOOL finished) {
                    r_recustion();
                }];
            }];
        }
//        else r_recustion = nil;
    };
//    r_recustion = recustion;
    recustion();
}

-(UIView*)getMasterView
{
	if (self.superview)
		return [self.superview getMasterView];
	return self;
}

- (UIImage*)screenshot
{
    if ([UIDevice isRetina])
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    else
        UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

-(void)removeSubviews
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        [obj removeFromSuperview];
    }];
}

-(void) resignAllResponder
{
    [self visiteurView:^(UIView *elt)
    {
        if ([elt isFirstResponder])
            [elt resignFirstResponder];
        
    } cbAfter:^(UIView *elt)
    {
        
    }];
}

#pragma mark - Gradients
-(void) applyGradients:(NSArray *)gradients onFrame:(CGRect)gradientFrame
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientFrame;
    
    NSMutableArray *colorsMut = [[NSMutableArray alloc] init];
    
    for (id object in gradients)
    {
        if ([object isKindOfClass:[UIColor class]])
        {
            [colorsMut addObject:(id)[object CGColor]];
        }
        else if ([gradient isKindOfClass:[NSDictionary class]])
        {
            UIColor *color = [gradient getXpath:kUIViewGradientColorkey type:[UIColor class] def:[UIColor clearColor]];
            NSUInteger iterations = [[gradient getXpath:kUIViewGradientColorIterations type:[NSNumber class] def:@1] unsignedIntegerValue];
            
            for (NSUInteger index = 0; index < iterations; index++)
            {
                [colorsMut addObject:(id)[color CGColor]];
            }
        }
    }
    gradient.colors = [colorsMut ToUnMutable];
    [self.layer insertSublayer:gradient atIndex:0];
}

-(void) applyGradients:(NSArray *)gradients
{
    [self applyGradients:gradients onFrame:self.bounds];
}

-(void) applyGradientsWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor
{
    if (startColor && endColor)
    {
        [self applyGradients:@[startColor, endColor]];
    }
    else
    {
        DLog(@"Bad color (start: %@, end: %@)", startColor, endColor);
    }
}

+(UIView *) viewWithFrame:(CGRect)frame andGradients:(NSArray *)gradients onFrame:(CGRect)gradientFrame
{
    UIView* view = [[UIView alloc] initWithFrame:frame];
    [view applyGradients:gradients onFrame:gradientFrame];
    return view;
}

+(UIView *) viewWithFrame:(CGRect)frame startColor:(UIColor *)startColor andEndColor:(UIColor *)endColor
{
    return [UIView viewWithFrame:frame andGradients:@[startColor, endColor] onFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

- (void)shakeView:(void (^)())completion{
    [self shakeViewWithIteration:0 direction:1 completion:completion];
}

- (void)shakeViewWithIteration:(NSInteger)iterations direction:(NSInteger)direction completion:(void (^)())completion{
    const NSInteger MAX_SHAKES = 6;
    const CGFloat SHAKE_DURATION = 0.05;
    const CGFloat SHAKE_TRANSFORM = 10.0;
    
    [UIView animateWithDuration:SHAKE_DURATION
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.transform = iterations >= MAX_SHAKES ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(SHAKE_TRANSFORM * direction, 0);
                     } completion:^(BOOL finished) {
                         if (finished){
                             if (iterations >= MAX_SHAKES){
                                 if (completion){
                                     completion();
                                 }
                             }
                             else{
                                 [self shakeViewWithIteration:(iterations + 1) direction:(direction * -1) completion:completion];
                             }
                         }
                     }];
}

- (void)borderViewAnimation{
    [self borderViewAnimation:0.5 fromColor:[UIColor clearColor] toColor:[UIColor redColor]];
}

- (void)borderViewAnimation:(CGFloat)duration fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor{
    [self.layer setBorderWidth:1.0];
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    color.fromValue = (id)fromColor.CGColor;
    color.toValue   = (id)toColor.CGColor;
    self.layer.borderColor = toColor.CGColor;
    
    CAAnimationGroup *both = [CAAnimationGroup animation];
    both.duration   = duration;
    both.animations = @[color];
    both.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:both forKey:@"UIView_Tool|borderViewAnimation"];
}


@end
