//
//  CalendarEvent.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/8/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface CalendarEvent : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Project *project;

@end
