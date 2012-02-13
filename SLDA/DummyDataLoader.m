//
//  DummyDataLoader.m
//  SLDA
//
//  Created by Nathan Sjoquist on 2/13/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import "DummyDataLoader.h"
#import "SLADataModel.h"
#import "NSManagedObjectContext+IVGUtils.h"
#import "Category.h"
#import "Project.h"
#import "CalendarEvent.h"
#import "IVGUtils.h"

@implementation DummyDataLoader

+(void) rmData{

    NSURL *baseURL = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [baseURL URLByAppendingPathComponent:@"ScheduleDataModel.sqlite"];

    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
}

+(void) loadData{


    NSManagedObjectContext* ctx = [SLADataModel sharedDataModel].context;
    
    Category* cat1 = [ctx insertNewEntityWithName:@"Category"];
    cat1.title = @"my title";
    cat1.poc = @"the last airbender";
    
    Project* projA = [ctx insertNewEntityWithName:@"Project"];
    projA.title = @"cat1 first Proj";
    projA.type = @"defaultType";
    projA.completionDate = [IVGUtils dateFromString:@"Sep 10" withFormat:@"MMM d"];

    
    Project* projB = [ctx insertNewEntityWithName:@"Project"];
    projB.title = @"cat1 second Proj";
    projB.type = @"defaultType";
    projB.completionDate = [IVGUtils dateFromString:@"Sep 14" withFormat:@"MMM d"];
    
    [cat1 addProjectsObject:projA],[cat1 addProjectsObject:projB];
    
    CalendarEvent* even1a = [ctx insertNewEntityWithName:@"CalendarEvent"];
    CalendarEvent* even1b = [ctx insertNewEntityWithName:@"CalendarEvent"];
    CalendarEvent* even2a = [ctx insertNewEntityWithName:@"CalendarEvent"];
    CalendarEvent* even2b = [ctx insertNewEntityWithName:@"CalendarEvent"];
    
    even1a.title = @"event 1 a";
    even1b.title = @"event 1 b";
    even2a.title = @"event 2 a";
    even2b.title = @"event 2 b";
    even1a.startDate = [IVGUtils dateFromString:@"Sep 1" withFormat:@"MMM d"];
    even1b.startDate = [IVGUtils dateFromString:@"Sep 4" withFormat:@"MMM d"];
    even2a.startDate = [IVGUtils dateFromString:@"Sep 2" withFormat:@"MMM d"];
    even2b.startDate = [IVGUtils dateFromString:@"Sep 7" withFormat:@"MMM d"];
    even1a.endDate = [IVGUtils dateFromString:@"Sep 4" withFormat:@"MMM d"];
    even1b.endDate = even1b.project.completionDate;
    even2a.endDate = [IVGUtils dateFromString:@"Sep 6" withFormat:@"MMM d"];
    even2b.endDate = even2b.project.completionDate;
    
    [projA addEventsObject:even1a],[projA addEventsObject:even1b];
    [projB addEventsObject:even2a],[projB addEventsObject:even2b];

    
    
    [ctx save:nil];

}

@end
