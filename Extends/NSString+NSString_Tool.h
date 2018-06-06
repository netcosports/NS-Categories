//
//  NSString+NSString_Tool.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Tool)

// ABOUT TO BE DOCUMENTED:
-(NSData *) obfuscatewithKey:(NSString *)key;
-(id) StrTrFromData:(NSString*)from to:(NSString*)to;

/**
 *  Insert a string into self starting at the given index
 *
 *  @param stringToInsert     The string to insert
 *  @param index              The index where to start the insertion
 *
 *  @return A new instance of NSString representing a new version of self with the inserted string
 */
-(NSString *)stringByInsertingString:(NSString *)stringToInsert atIndex:(NSUInteger)index;

/**
 *  Enumerates the different occurences of a potential substring using a mask as the string comparison option through a block.
 *
 *  @param substring          The string to find
 *  @param mask               The string comparison option to use for matching strings
 *  @param enumerationBlock   The enumeration block called each time an occurence is found. It gives its index.
 *
 */
-(void) enumerateOccurencesOfSubstring:(NSString *)substring  options:(NSStringCompareOptions)mask usingBlock:(void(^)(NSUInteger indexOfOccurence, BOOL *stop))enumerationBlock;

/**
 *  Check if parts of self respond to the given regular expression
 *
 *  @param regex              Regular Expression
 *
 *  @return Self's signature
 */
-(NSArray*)componentsMatchedByRegex:(NSString*)regex;

/**
 *  Compute self signature [MD5/SHA1/SHA1/SHA1HMAC]
 *
 *  @return Self's signature
 */
-(NSString *)   md5;
-(NSString *)   sha1;
-(NSString *)   sha1Hmac:(NSString *)key;

/**
 *  Cycli Redundancy Check
 *
 *  @return Unsigned long representing self
 */
-(unsigned long)crc32;

/**
 *  Check if self has at least one substring like search (Case sensitive)
 *
 *  @param search              String to find
 *
 *  @return Yes is search has been found, NO if not.
 */
-(BOOL) hasSubstring:(NSString *)search;

/**
 *  Check if self has at least one substring like search (Case snsensitive)
 *
 *  @param search              String to find
 *
 *  @return Yes is search has been found, NO if not.
 */
-(BOOL) hasInsensitiveSubString:(NSString *)search;

/**
 *  Check if self has at least one substring like search (Case snsensitive)
 *
 *  @param search              String to find
 *
 *  @return Index of search if is has been found, NSNotFound if not.
 */
-(NSInteger) indexOfSubString:(NSString*) search;

/**
 *  Compute the number of occurences of a string in self.
 *
 *  @param search              String to find
 *
 *  @return number of found occurences.
 */
-(NSInteger) nbrOccurenceString:(NSString *)search;

/**
 *  Check if self has at least one substring like search (Case snsensitive)
 *
 *  @param source              String to find
 *  @param newString           String replacing `source'
 *
 *  @return Index of search if is has been found, NSNotFound if not.
 */
-(NSString*) strReplace:(NSString*)source by:(NSString*)newString;

/**
 *  UTF8 encode self
 *
 *  @return Encoded string.
 */
-(NSString *) urlencode;

/**
 *  Clean self by removing white spaces & new line charset.
 *
 *  @return Encoded string.
 */
-(NSString*) trim;

/**
 *  Split string using a separator & put substring into a NSArray
 *
 *  @param seperator Separator used
 *
 *  @return NSArray containing all substring
 */
-(NSArray*) explode:(NSString*)seperator;

/**
 *  Check if a string is equal to self
 *
 *  @param string String to compare with
 *
 *  @return YES if string is the same as self.
 */
-(BOOL) isNotEqualToString:(NSString*)string;

/**
 *  Make a string's first character uppercase
 *
 *  @return Result string.
 */
-(NSString *)ucfirst;

/**
 *  Make a string's first character uppercase and the rest lowercase
 *
 *  @return Result string.
 */
-(NSString *)ucfirstlc;

/**
 *  Check if candidate match e-mail regex @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
 *
 *  @return YES if self is e-mail format complient.
 */
-(BOOL)validateEmail;

/**
 *  Compare two version strings with number(.number)? format
 *
 *  @param version               Version to compare to
 *
 *  @return Comparison result.
 */
- (NSComparisonResult)compareToVersion:(NSString *)version;

/**
 *  Transform string into NSNumber.
 *
 *  @return Comparison result
 */
-(NSNumber *)toNumber;

@end


@interface NSMutableAttributedString (NSMutableAttributedString_BOLD)

/**
 *  Upgrading the current attribute Font by adding/removing `-Bold' to its fontname on the given range.
 *
 *  @param bold                   BOOL describing wether it has `-Bold' or not.
 *  @param range                  Range of application.
 */
-(void)setBold:(BOOL)bold range:(NSRange)range;

@end
