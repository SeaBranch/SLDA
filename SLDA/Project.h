//
//  Project.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/14/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CalendarEvent, Category;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSDate * completionDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) NSSet *events;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addEventsObject:(CalendarEvent *)value;
- (void)removeEventsObject:(CalendarEvent *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;
@end
