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
@property (nonatomic, retain) NSMutableArray* toDoEvents;
@property (nonatomic, retain) NSMutableArray* doneEvents;
@property (nonatomic, retain) NSMutableArray* viewedEvents;

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
@synthesize doneEvents;
@synthesize toDoEvents;
@synthesize viewedEvents;
@synthesize displayYetToDoItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"To Do", @"To Do");
        self.tabBarItem.image = [UIImage imageNamed:@"First"];
        eventsArray = [[NSArray alloc] init];
        toDoEvents = [[NSMutableArray alloc] init];
        doneEvents = [[NSMutableArray alloc] init];
        viewedEvents = [[NSMutableArray alloc] init];
        displayYetToDoItems = YES;
                
    }
    return self;
}
	
-(void) dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self sortData]; 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleToDoDoneToggle:) name:kToDoCellDoneNotification object:nil];   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.eventsArray = nil;
    self.toDoEvents = nil;
    self.doneEvents = nil;
    self.editBBI = nil;
    self.addBBI = nil;
    self.doneNotDoneSC = nil;
    self.tableView = nil;
    self.data = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)configureViewed{
    
    [viewedEvents removeAllObjects];

    if (displayYetToDoItems) {
        viewedEvents = [NSMutableArray arrayWithArray:toDoEvents];
    }
    else{
        viewedEvents = [NSMutableArray arrayWithArray:doneEvents];
    }
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

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

-(IBAction)pressedSegmentedButton:(id)sender{

    displayYetToDoItems = !displayYetToDoItems;
    [self.tableView reloadData];
    [self sortData]; 


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarEvent *aEvent = [viewedEvents objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"SLDAToDoTVCellid";
    SLDAToDoTVCell *cell = (SLDAToDoTVCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        NSString *nibName =  @"SLDAToDoTVCell";
        [[NSBundle mainBundle] loadNibNamed:nibName
                                      owner:self 
                                    options:nil];
        cell = self.configCell;
    }

    [cell configureData:aEvent];
    
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSArray*) pullDataFromContext{
    
    NSLog(@"NSLOG ALL THE LINES!!!!");
    

    NSManagedObjectContext* ctx = [SLADataModel sharedDataModel].context;  
    NSArray *fetchedResults = [[ctx fetchObjectsForEntityName:@"CalendarEvent" withPredicate:nil] autorelease];
    NSMutableArray *filteredResults = [NSMutableArray array];
    
    for (CalendarEvent* evnt in fetchedResults){
        NSComparisonResult r = [evnt.startDate compare:[NSDate date]];
        
        NSLog(@"start date = %@ r = %d",evnt.startDate, r);
        if (r <= NSOrderedSame) {
            [filteredResults addObject:evnt];
        }
    }
    NSArray* result = [NSArray arrayWithArray:filteredResults];    
    return result;
}

- (void)sortData{
    [toDoEvents removeAllObjects];
    [doneEvents removeAllObjects];
    
    for (CalendarEvent* evnt in eventsArray){
        
        if ([evnt.isDone boolValue]) {
            [doneEvents addObject:evnt];
        }
        else{
            [toDoEvents addObject:evnt];
        }
    }
    [self configureViewed];
}


#pragma mark- table view delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   return [viewedEvents count];
}

- (void) handleToDoDoneToggle:(NSNotification*)notification{
    
    [self.tableView reloadData];

}


@end
