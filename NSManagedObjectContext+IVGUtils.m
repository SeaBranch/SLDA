//
//  NSManagedObjectContextIvy Gulch, LLC.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/18/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import "NSManagedObjectContext+IVGUtils.h"

@implementation NSManagedObjectContext (IVGUtils)

- (id) insertNewEntityWithName:(NSString *)name {
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self];
}

- (NSArray *)fetchObjectsForEntityName:(NSString *)newEntityName
                         withPredicate:(id)stringOrPredicate {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:newEntityName];
    
    if (stringOrPredicate) {
        NSPredicate *predicate;
        if ([stringOrPredicate isKindOfClass:[NSString class]]) {
            predicate = [NSPredicate predicateWithFormat:stringOrPredicate];
        } else {
            NSAssert2([stringOrPredicate isKindOfClass:[NSPredicate class]],
                      @"Second parameter passed to %s is of unexpected class %@",
                      sel_getName(_cmd), stringOrPredicate);
            predicate = (NSPredicate *)stringOrPredicate;
        }
        [request setPredicate:predicate];
    }
    
    NSError *error = nil;
    NSArray *results = [self executeFetchRequest:request error:&error];
    if (error != nil) {
        [NSException raise:NSGenericException format:@"%@", [error description]];
    }
    return results;
}

#pragma mark - Class methods

+ (NSURL *) writeableDatabaseUrl:(NSString *) databaseName error:(NSError **) errorPointer {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *writableDBPath = [docDir stringByAppendingPathComponent:databaseName];
    
    NSURL *storeUrl = [NSURL fileURLWithPath:writableDBPath];
    
    if([fileManager fileExistsAtPath:writableDBPath]) {
        return storeUrl;
    }
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    if ([fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:errorPointer]) {
        return storeUrl;
    }
    return nil;
}

+ (NSManagedObjectContext *) newManagedObjectContextForDatastore:(NSURL *) storeUrl error:(NSError **) errorPointer {
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSPersistentStore *persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:errorPointer];
    if (!persistentStore) {
        return nil;
    }
    
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator: persistentStoreCoordinator];
    return managedObjectContext;
}

@end
