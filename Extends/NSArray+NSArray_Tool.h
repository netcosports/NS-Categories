//
//  NSArray+NSArray_Tool.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    NSCategoryDiffCompNotFound,
    NSCategoryDiffCompEqual,
    NSCategoryDiffCompUpdate
} NSCategoryDiffComp;

#pragma mark - NSArray (NSArray_Tool)

@interface NSArray (NSArray_Tool)

/**
 *  It creates an instance of NSArray filled with the content of all arrays passed in the variable arguments list.
 *  Basically, it appends all arrays to create a new one.
 *
 *  @param array VA_LIST of arrays
 *
 *  @return NSArray instance created on the content from the array arguments list.
 */
+ (instancetype)arrayWithArrays:(NSArray *)array, ...;

/**
 *  Diff checking on array
 *
 *  @param newArray  The updated array to compare with
 *  @param comp      NSCategoryDiffComp type to base the diff with
 *  @param completed Completion block providing arrays with removed, inserted, and updated element.
 *
 *  @return Yes is the array has changed, No if not.
 */
-(BOOL)diffForNewArrayElement:(NSArray*)newArray comp:(NSCategoryDiffComp(^)(id itemOld, id itemNew))comp complete:(void(^)(BOOL changed, NSArray *remove, NSArray *insert, NSArray *update))completed;

-(BOOL)diffForNewArrayItem:(NSArray *)newArray section:(NSInteger)section comp:(NSCategoryDiffComp(^)(id itemOld, id itemNew))comp complete:(void(^)(BOOL changed, NSArray *remove, NSArray *insert, NSArray *update))completed;

/**
 *  Create an alphabetically sorted array from an array of strings.
 *
 *  @param keys Array of strings to sort
 *  @param asc  Ascending parameter (From A to Z or Z to A)
 *
 *  @return Array of sorted string
 */
-(NSArray *) sortAlphabeticallyArrayOfObjectUsing:(NSString *)keys isAsc:(BOOL)asc;

/**
 *  Check if the current NSArray constains an element which is a string and returns the value of isEqualToString:
 *
 *  @param stringToCompareWith The string to compare the NSArray with
 *
 *  @return It returns the value of isEqualToString:
 */
-(BOOL)containsString:(NSString *)stringToCompareWith;

/**
 *  Reverse the array
 *
 *  @return A new instance of a NSArray representing the reversed array of self.
 */
-(NSArray *)reversedArray;

/**
 *  It creates a string appending every elements of the array with a separator between each.
 *
 *  @param separator Separator betweend each elements in the string.
 *
 *  @return String representation of the array.
 */
-(NSString *)implode:(NSString *)separator;

@end
