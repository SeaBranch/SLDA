//
//  SLDAProjectVC.m
//  SLDA
//
//  Created by Nathan Sjoquist on 2/6/12.
//  Copyright (c) 2012 Spazz Gaming. All rights reserved.
//

#import "SLDAProjectVC.h"

@implementation SLDAProjectVC

@synthesize navBI;
@synthesize cancelBBI;
@synthesize addBBI;
@synthesize titleTextField;
@synthesize startTimeButton;
@synthesize startTimeLabel;
@synthesize endDateButton;
@synthesize endDateLabel;
@synthesize typeButton;
@synthesize typeLabel;
@synthesize categoryButton;
@synthesize categoryLabel;
@synthesize addCategoryButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)cancelButtonPressed:(id)sender{

    [self.presentingViewController dismissModalViewControllerAnimated:YES];
    
}
-(IBAction)addCategoryButtonPressed:(id)sender{

    NSLog(@"add a Category!!!");

}

@end
