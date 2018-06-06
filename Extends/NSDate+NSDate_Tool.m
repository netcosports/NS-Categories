//
//  NSDate+NSDate_Tool.m
//  FoxSports
//
//  Created by Guillaume on 31/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import "NSDate+NSDate_Tool.h"

@implementation NSDate (NSDate_Tool)

+(NSDate *)dateWithString:(NSString *)dateTime followingFormat:(NSString *)dateTimeFormat
{
    return [NSDate dateWithString:dateTime followingFormat:dateTimeFormat forLocale:[NSLocale currentLocale]];;
}

+(NSDate *)dateWithString:(NSString *)dateTime followingFormat:(NSString *)dateTimeFormat forLocale:(NSLocale *)locale
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setLocale:locale];
    [formatter setDateFormat:dateTimeFormat];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}

+(NSString *) stringWithDate:(NSDate *)dateTime followingFormat:(NSString *)dateTimeFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:dateTimeFormat];
    NSString *stringFromDate = [formatter stringFromDate:dateTime];
    return stringFromDate;
}

+(NSDate *) dateWithTimeStamp:(NSTimeInterval)gmtTimestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:gmtTimestamp];
    return [date toLocalTime];
}

+(NSDate *) dateWithISO8601String:(NSString *)dateTimeZFormat;
{
    return [NSDate dateWithString:dateTimeZFormat followingFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"];
}

+(NSString *) stringWithISO8601Date:(NSDate *)dateTime
{
    return [NSDate stringWithDate:dateTime followingFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"];
}

-(BOOL) isToday
{
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    if([today day] == [otherDay day] &&
       [today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(NSDate *) toLocalTime
{
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate:self];
    return [NSDate dateWithTimeInterval: seconds sinceDate:self];
}

-(NSDate *) toGlobalTime
{
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate:self];
    return [NSDate dateWithTimeInterval:seconds sinceDate:self];
}

@end