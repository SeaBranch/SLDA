//
//  SLDAFirstViewController.m
//  SLDA
//
//  Created by Nathan Sjoquist on 2/3/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import "SLDAToDoViewController.h"
#import "IVGUtils.h"
#import "SLDAProjectVC.h"
#import "SLADataModel.h"
#import "NSManagedObjectContext+IVGUtils.h"
#import "SLACoreDataFiles.h"

@interface SLDAToDoViewController()

@property (nonatomic, copy) NSMutableArray *data;
@property (nonatomic, retain) NSArray* eventsArray;

- (NSArray*) pullDataFromContext;

@end


@implementation SLDAToDoViewController

@synthesize editBBI = editBBI_;
@synthesize addBBI = addBBI_;
@synthesize doneNotDoneSC = doneNotDoneSC_;
@synthesize tableView = tableView_;
@synthesize data = data_;
@synthesize configCell;
@synthesize eventsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"To Do", @"To Do");
        self.tabBarItem.image = [UIImage imageNamed:@"First"];
        eventsArray = [NSArray array];
                
    }
    return self;
}
	
-(void) dealloc {

    [editBBI_ release], editBBI_ = nil;
    [addBBI_ release], addBBI_ = nil;
    [doneNotDoneSC_ release], doneNotDoneSC_ = nil;
    [tableView_ release], tableView_ = nil;
    [data_ release], data_ = nil;
    [super dealloc];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.eventsArray = [self pullDataFromContext];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    self.editBBI = nil;
    self.addBBI = nil;
    self.doneNotDoneSC = nil;
    self.tableView = nil;
    self.data = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)configureTable {
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *title = [self.dataIndex objectAtIndex:section outOfRange:@""];
//    if ([title isEqualToString:kSportysIndexKey]) {
//        title = kSportysTitle;
//    }
//    return title;
//}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return self.dataIndex;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSMutableArray *sectionData = [self.data objectAtIndex:section outOfRange:nil];
//    return [sectionData count];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSMutableArray *sectionData = [self.data objectAtIndex:[indexPath section] outOfRange:nil];
//    NSMutableArray *exhibitorData = [sectionData objectAtIndex:[indexPath row] outOfRange:nil];
//    return [SPSExhibitorTableViewCell heightForRow:exhibitorData];
//}

- (NSDate *) dateFromYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day
                     hour:(NSInteger) hour minute:(NSInteger) minute second:(NSInteger) second {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setHour:hour];
    [comps setMinute:minute];
    [comps setSecond:second];
    [comps setTimeZone:[[NSCalendar currentCalendar] timeZone]];
    NSDate *result = [[NSCalendar currentCalendar] dateFromComponents:comps];
    [comps release];
    return result;
}


-(IBAction)pressedAddButton:(id)sender{

    SLDAProjectVC* projectVC = [[[SLDAProjectVC alloc] init] autorelease];
    
    NSLog(@"add a project");
    [self presentModalViewController:projectVC animated:YES];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SLDAToDoTVCellid";
    SLDAToDoTVCell *cell = (SLDAToDoTVCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSString *nibName =  @"SLDAToDoTVCell";
        [[NSBundle mainBundle] loadNibNamed:nibName
                                      owner:self 
                                    options:nil];
        cell = self.configCell;
        //[cell configureInitial];
    }
    
    CalendarEvent *aEvent = [eventsArray objectAtIndex:indexPath.row];
    NSString* titleStr = aEvent.title;
    NSDate* displayDate = aEvent.endDate;
    
    [cell configureData:titleStr withDate:displayDate];
    
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSArray*) pullDataFromContext{

    NSManagedObjectContext* ctx = [SLADataModel sharedDataModel].context;    
    
    NSArray *fetchedResults = [[ctx fetchObjectsForEntityName:@"CalendarEvent" withPredicate:nil] autorelease];
    NSMutableArray *filteredResults = [NSMutableArray array];
    
    
    for (CalendarEvent* evnt in fetchedResults){
                
        NSComparisonResult r = [evnt.startDate compare:[NSDate date]];
        
        NSLog(@"start date = %@ r = %d",evnt.startDate, r);
        if (r <= NSOrderedSame) {
            [filteredResults addObject:evnt];
        }
        else{
        
            NSLog(@"too late");
        
        }
        
    
    }
    
    NSArray* result = [NSArray arrayWithArray:filteredResults];
    
    return result;
}


#pragma mark- table view delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   return [eventsArray count];
}




@end
