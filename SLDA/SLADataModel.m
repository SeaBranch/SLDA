//
//  SLADataModel.m
//  SLDA
//
//  Created by Nathan Sjoquist on 2/13/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import "SLADataModel.h"


@interface SLADataModel()

@property (nonatomic, retain) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, retain) NSManagedObjectModel *model;

- (void) handleError:(NSError *) error;
@end

@implementation SLADataModel

@synthesize coordinator = coordinator_;
@synthesize context = context_;
@synthesize model = model_;

- (id) init {
    if ((self = [super init])) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ScheduleDataModel" withExtension:@"momd"];
        model_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        
        NSURL *baseURL = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [baseURL URLByAppendingPathComponent:@"ScheduleDataModel.sqlite"];
        
        coordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model_];
        
        NSError *error = nil;
        NSDictionary *options = [NSDictionary
                                 dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                                 nil];
        if (![coordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            [self handleError:error];
        }
        
        context_ = [[NSManagedObjectContext alloc] init];
        [context_ setPersistentStoreCoordinator: coordinator_];
    }
    return self;
}
- (void) dealloc {
    [context_ release], context_ = nil;
    [coordinator_ release], coordinator_ = nil;
    [model_ release], model_ = nil;
    
    [super dealloc];
}


-(void) showAlertViewTitle:(NSString *) title
                    message:(NSString *) message
                   delegate:(id<UIAlertViewDelegate>) delegate
          cancelButtonTitle:(NSString *) cancelButtonTitle {
    UIAlertView* alertView = [[[UIAlertView alloc]
                               initWithTitle:title
                               message:message
                               delegate:delegate
                               cancelButtonTitle:cancelButtonTitle
                               otherButtonTitles:nil] autorelease];
    [alertView show];
}

- (void) handleError:(NSError *) error {
    NSString *message = [NSString stringWithFormat:@"There was a fatal error in the application\n%@", [error userInfo]];
    
    [self showAlertViewTitle:@"Persistence Error" message:message delegate:nil cancelButtonTitle:@"Close"];
}

- (void)saveContext {
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSString *message = [NSString stringWithFormat:@"There was a fatal error in the application\n%@", [error localizedDescription]];
        [self showAlertViewTitle:@"Persistence Error" message:message delegate:nil cancelButtonTitle:@"Close"];
    }
}


+(SLADataModel*) sharedDataModel;
{

    static dispatch_once_t pred_sharedDataModel;
    static SLADataModel *sharedDataModel_ = nil;
    dispatch_once(&pred_sharedDataModel, ^{
        sharedDataModel_ = [[SLADataModel alloc]init];
    });
    
    return sharedDataModel_;

}



@end
