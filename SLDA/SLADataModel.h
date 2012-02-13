//
//  SLADataModel.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/13/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SLADataModel : NSObject 

@property (nonatomic, readonly) NSManagedObjectContext *context;


+(SLADataModel*) sharedDataModel;

@end
