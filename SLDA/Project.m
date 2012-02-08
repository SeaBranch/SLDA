//
//  Project.m
//  SLDA
//
//  Created by Nathan Sjoquist on 2/8/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import "Project.h"
#import "Category.h"
#import "CalendarEvent.h"


@implementation Project

@dynamic title;
@dynamic completionDate;
@dynamic type;
@dynamic events;
@dynamic category;



- (id)init {
    self = [super init];
    if (self) {
        
        CalendarEvent* endEvent;
        endEvent.title = @"complete";
        endEvent.endDate = nil;
        endEvent.startDate = self.completionDate;
        endEvent.category = self.category;
        
        [self addEventsObject:endEvent];
    }
    return self;
}

@end
