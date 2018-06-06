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
 *  Create a NSDate instance (with device timezone & device locale) from a string representing a date-time following the given format.
 *
 *  @param dateTime          Date-time as string
 *  @param dateTimeFormat    Format used to describe the date-time
 *
 *  @return New NSDate instance
 */
+(NSDate *)dateWithString:(NSString *)dateTime followingFormat:(NSString *)dateTimeFormat;

/**
 *  Create a NSDate instance (with device timezone & specified locale) from a string representing a date-time following the given format.
 *
 *  @param dateTime          Date-time as string
 *  @param dateTimeFormat    Format used to describe the date-time
 *  @param locale            Locale used to parse the date sting
 *
 *  @return New NSDate instance
 */
+(NSDate *)dateWithString:(NSString *)dateTime followingFormat:(NSString *)dateTimeFormat forLocale:(NSLocale *)locale;

/**
 *  Create a NSDate instance (with device timezone & device locale) from an ISO 8601 string representation
 *
 *  @param dateTimeZFormat   ISO 8601 string representation
 *
 *  @return New NSDate instance
 */
+(NSDate *) dateWithISO8601String:(NSString *)dateTimeZFormat;

/**
 *  Transform a NSDate instance (with device timzone & device local) to a string representation following the given format
 *
 *  @param dateTime           NSDate
 *  @param dateTimeFormat     Format followed by the output string
 *
 *  @return New string representation
 */
+(NSString *) stringWithDate:(NSDate *)dateTime followingFormat:(NSString *)dateTimeFormat;

/**
 *  Transform a NSDate instance to an ISO 8601 string representation
 *
 *  @param dateTime           ISO 8601 NSDate
 *
 *  @return New string representation
 */
+(NSString *) stringWithISO8601Date:(NSDate *)dateTime;

/**
 *  Create a NSDate (with device timezone & device locale) from a gmt timestamp
 *
 *  @param gmtTimestamp       Timestamp
 *
 *  @return New NSDate instance
 */
+(NSDate *) dateWithTimeStamp:(NSTimeInterval)gmtTimestamp;

/**
 *  Check if self is today or not
 *
 *  @return Boolean value describing if the date is today or not.
 */
-(BOOL) isToday;

/**
 *  Create a NSDate instance (with device timezone & device locale) from the current self (NSDate)
 *
 *  @return New NSDate instance
 */
-(NSDate *) toLocalTime;

/**
 *  Create a NSDate instance (GMT) from the current self (NSDate)
 *
 *  @return New NSDate instance
 */
-(NSDate *) toGlobalTime;

@end
