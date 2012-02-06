//
//  SLDAToDoTVCell.m
//  SLDA
//
//  Created by Nathan Sjoquist on 2/3/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import "SLDAToDoTVCell.h"

@implementation SLDAToDoTVCell


@synthesize toggleDoneButton = toggleDoneButton_;
@synthesize nameLabel = nameLabel_;
@synthesize dueLabel = dueLabel_;
@synthesize dueDate = dueDate_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc {

    [toggleDoneButton_ release], toggleDoneButton_ = nil;
    [nameLabel_ release], nameLabel_ = nil;
    [dueLabel_ release], dueLabel_ = nil;
    [dueDate_ release], dueDate_ = nil;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) configureData:(NSString*)name withDate:(NSDate*)date{

    self.nameLabel.text = name;
    
    NSString* dueText = [date accessibilityValue];
    self.dueLabel.text = dueText;
}

@end
