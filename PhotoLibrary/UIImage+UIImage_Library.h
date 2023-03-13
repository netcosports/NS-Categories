//
//  UIImage+UIImage_Library.h
//  Extends
//
//  Created by Guillaume Derivery on 09/12/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_Library)

#pragma mark Class methods
+(NSArray *) getImagesFromLibraryAfter:(NSDate *)date;
+(NSArray *) getLatestImagesFromLibraryLimitedTo:(NSUInteger)limit;

#pragma mark - Instance methods
-(void) saveToLibraryInAlbum:(NSString *)album withCompletionBlock:(void(^)(BOOL success, NSError *error))completion;

@end
