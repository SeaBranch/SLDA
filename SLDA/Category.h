//
//  Category.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/14/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * poc;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *projects;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addProjectsObject:(Project *)value;
- (void)removeProjectsObject:(Project *)value;
- (void)addProjects:(NSSet *)values;
- (void)removeProjects:(NSSet *)values;
@end
