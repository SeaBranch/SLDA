//
//  SLDAToDoTVCell.h
//  SLDA
//
//  Created by Nathan Sjoquist on 2/3/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLDAToDoTVCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIButton *toggleDoneButton;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *dueLabel;
@property (nonatomic, retain) NSDate *dueDate;

-(void) configureData:(NSString*)name withDate:(NSDate*)date;

@end
