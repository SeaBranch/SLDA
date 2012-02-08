//
//  SLDAProjectVC.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/6/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLDAProjectVC : UIViewController

@property (nonatomic,retain) IBOutlet UIBarItem* navBI;
@property (nonatomic,retain) IBOutlet UIBarButtonItem* cancelBBI;
@property (nonatomic,retain) IBOutlet UIBarButtonItem* addBBI;
@property (nonatomic,retain) IBOutlet UITextField* titleTextField;
@property (nonatomic,retain) IBOutlet UIButton* startTimeButton;
@property (nonatomic,retain) IBOutlet UILabel* startTimeLabel;
@property (nonatomic,retain) IBOutlet UIButton* endDateButton;
@property (nonatomic,retain) IBOutlet UILabel* endDateLabel;
@property (nonatomic,retain) IBOutlet UIButton* typeButton;
@property (nonatomic,retain) IBOutlet UILabel* typeLabel;
@property (nonatomic,retain) IBOutlet UIButton* categoryButton;
@property (nonatomic,retain) IBOutlet UILabel* categoryLabel;


@end
