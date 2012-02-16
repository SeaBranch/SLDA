//
//  SLDAToDoTVCell.m
//  SLDA
//
//  Created by Nathan Sjoquist on 2/3/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import "SLDAToDoTVCell.h"
#import "IVGUtils.h"
#import "SLACoreDataFiles.h"

@interface SLDAToDoTVCell()

@property (nonatomic,retain) CalendarEvent* cellsEvent;

@end


@implementation SLDAToDoTVCell

@synthesize toggleDoneButton = toggleDoneButton_;
@synthesize nameLabel = nameLabel_;
@synthesize dueLabel = dueLabel_;
@synthesize dueDate = dueDate_;
@synthesize cellsEvent = cellsEvent_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        cellsEvent_ = [[CalendarEvent alloc] init];
        // Initialization code
    }
    return self;
}

- (void) dealloc {

    [toggleDoneButton_ release], toggleDoneButton_ = nil;
    [nameLabel_ release], nameLabel_ = nil;
    [dueLabel_ release], dueLabel_ = nil;
    [dueDate_ release], dueDate_ = nil;
    [cellsEvent_ release],cellsEvent_ = nil;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureData:(CalendarEvent*)evnt{
    self.cellsEvent = evnt;
    self.nameLabel.text = evnt.title;
    self.dueLabel.text = [IVGUtils stringFromDate:evnt.endDate withFormat:@"MMM d"];
}

-(IBAction)doneButtonPressed:(id)sender{
    self.cellsEvent.isDone = [NSNumber numberWithBool:![self.cellsEvent.isDone boolValue]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kToDoCellDoneNotification object:self.cellsEvent];
}

@end
