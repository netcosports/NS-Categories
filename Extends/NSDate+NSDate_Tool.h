//
//  NSDate+NSDate_Tool.h
//  FoxSports
//
//  Created by Guillaume on 31/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_Tool)

/**
 *  Create a NSDate instance from a string representing a date-time following the given format.
 *
 *  @param dateTime       Date-time as string
 *  @param dateTimeFormat Format used to describe the date-time
 *
 *  @return New NSDate instance
 */
+(NSDate *)dateWithString:(NSString *)dateTime followingFormat:(NSString *)dateTimeFormat;

/**
 *  Create a NSDate instance from an ISO 8601 string representation
 *
 *  @param `dateTime' ISO 8601 string representation
 *
 *  @return New NSDate instance
 */
+(NSDate *) dateWithISO8601String:(NSString *)dateTimeZFormat;

/**
 *  Transform a NSDate instance to a string representation following the given format
 *
 *  @param `dateTime' NSDate
 *  @param `dateTimeFormat' Format followed by the output string
 *
 *  @return New string representation
 */
+(NSString *) stringWithDate:(NSDate *)dateTime followingFormat:(NSString *)dateTimeFormat;

/**
 *  Transform a NSDate instance to an ISO 8601 string representation
 *
 *  @param `dateTime' ISO 8601 NSDate
 *
 *  @return New string representation
 */
+(NSString *) stringWithISO8601Date:(NSDate *)dateTime;

/**
 *  Check if self is today or not
 *
 *  @return Boolean value describing if the date is today or not.
 */
-(BOOL) isToday;

@end
