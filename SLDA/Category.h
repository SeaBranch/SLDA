//
//  Category.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/8/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * poc;
@property (nonatomic, retain) NSSet *projects;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addProjectsObject:(NSManagedObject *)value;
- (void)removeProjectsObject:(NSManagedObject *)value;
- (void)addProjects:(NSSet *)values;
- (void)removeProjects:(NSSet *)values;
@end
