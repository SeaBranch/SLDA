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

@property (nonatomic, retain) NSArray* eventsArray;

@end


@implementation SLDAToDoViewController

@synthesize editBBI = editBBI_;
@synthesize addBBI = addBBI_;
@synthesize doneNotDoneSC = doneNotDoneSC_;
@synthesize tableView = tableView_;
@synthesize configCell = configCell_;
@synthesize eventsArray = eventsArray_;
@synthesize displayYetToDoItems = displayYetToDoItems_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"To Do", @"To Do");
        self.tabBarItem.image = [UIImage imageNamed:@"First"];
        displayYetToDoItems_ = YES;          
    }
    return self;
}
	
-(void) dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [editBBI_ release], editBBI_ = nil;
    [addBBI_ release], addBBI_ = nil;
    [doneNotDoneSC_ release], doneNotDoneSC_ = nil;
    [tableView_ release], tableView_ = nil;
    [eventsArray_ release], eventsArray_ = nil;

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
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleToDoDoneToggle:) name:kToDoCellDoneNotification object:nil];   
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.eventsArray = nil;
    self.editBBI = nil;
    self.addBBI = nil;
    self.doneNotDoneSC = nil;
    self.tableView = nil;

    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureTableView];
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

    NSLog(@"pressed SC");
    
    self.displayYetToDoItems = !self.displayYetToDoItems;
    [self configureTableView];
    [self.tableView reloadData];


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarEvent *aEvent = [self.eventsArray objectAtIndex:indexPath.row];
    
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

-(void)configureTableView{
    NSLog(@"got rid of old");
    
    NSManagedObjectContext* ctx = [SLADataModel sharedDataModel].context;  
    NSArray *fetchedResults = [ctx fetchObjectsForEntityName:@"CalendarEvent" withPredicate:nil];
    NSMutableArray *filteredResults = [NSMutableArray array];
    
    NSLog(@"got context and pulled data");
    
    for (CalendarEvent* evnt in fetchedResults){
        NSComparisonResult r = [evnt.startDate compare:[NSDate date]];
        
        NSLog(@"start date = %@ r = %d",evnt.startDate, r);
        if (r <= NSOrderedSame) {

            if ([evnt.isDone boolValue] != self.displayYetToDoItems) {
                [filteredResults addObject:evnt];
            }
        }
    }
    NSLog(@"did the loop");
    
    self.eventsArray = [NSArray arrayWithArray:filteredResults]; 
}


#pragma mark- table view delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   return [self.eventsArray count];
}

- (void) handleToDoDoneToggle:(NSNotification*)notification{
    
    NSManagedObjectContext* ctx = [SLADataModel sharedDataModel].context;  
    if ([ctx save:nil]) {
        NSLog(@"saved event changes");
    }
    
    [self configureTableView];
    [self.tableView reloadData];
    
    NSLog(@"object: %@", self.eventsArray);

}


@end
