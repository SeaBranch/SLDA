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

@implementation DummyDataLoader


+(void) loadData{


    NSManagedObjectContext* ctx = [SLADataModel sharedDataModel].context;
    
    Category* cat1 = [ctx insertNewEntityWithName:@"Category"];
    cat1.title = @"my title";
    [ctx save:nil];

}

@end
