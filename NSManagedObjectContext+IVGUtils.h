//
//  NSManagedObjectContextIvy Gulch, LLC.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/18/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (IVGUtils)

- (id)insertNewEntityWithName:(NSString *)name;
- (NSArray *)fetchObjectsForEntityName:(NSString *)newEntityName
                         withPredicate:(id)stringOrPredicate;

+ (NSURL *) writeableDatabaseUrl:(NSString *) databaseName error:(NSError **) errorPointer;
+ (NSManagedObjectContext *) newManagedObjectContextForDatastore:(NSURL *) storeUrl error:(NSError **) errorPointer;


@end
