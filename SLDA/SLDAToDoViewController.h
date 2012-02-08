//
//  SLDAFirstViewController.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/3/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLDAToDoTVCell.h"


@interface SLDAToDoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) IBOutlet UIBarButtonItem *editBBI;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *addBBI;
@property (nonatomic,retain) IBOutlet UISegmentedControl *doneNotDoneSC;
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) IBOutlet SLDAToDoTVCell *configCell;

-(IBAction)pressedAddButton:(id)sender;

@end
