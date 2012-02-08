//
//  Project.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/8/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * completionDate;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *events;
@property (nonatomic, retain) Category *category;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addEventsObject:(NSManagedObject *)value;
- (void)removeEventsObject:(NSManagedObject *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;
@end
