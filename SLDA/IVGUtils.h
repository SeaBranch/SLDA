//
//  IVGUtils.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 09/01/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IVGUtils : NSObject

+ (NSDateFormatter *) sharedDateFormatter;
+ (NSString *) stringFromDate:(NSDate *) value withFormat:(NSString *) format;
+ (NSDate *) dateFromString:(NSString *) value withFormat:(NSString *) format;

+ (id) ifNil:(id) value use:(id) defaultValue;
+ (BOOL) haveValue:(NSString *) value;

@end
