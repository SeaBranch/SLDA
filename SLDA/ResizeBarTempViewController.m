//
//  ResizeBarTempViewController.m
//  ResizeBarTemp
//
//  Created by Nathan Sjoquist on 8/29/11.
//  Copyright 2011 Cedarville University. All rights reserved.
//

#import "ResizeBarTempViewController.h"


@implementation ResizeBarTempViewController


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    CGFloat placementHight = 10;
//    CGFloat placementWidth = 50;
    
//    for (int i; i<4; i++) {
//        placementHight = placementHight +10;
//        [resisableBars arrayByAddingObject:[[ResizeableBar alloc] initWithFrame:CGRectMake(placementHight,placementWidth,200,30)]];
//        placementHight = placementHight + 30;
//        
//        
//    }
    
//    [resisableBars autorelease];
    bar = [[ResizeableBar alloc] initWithFrame:CGRectMake(10,110,80,30)];
    [self.view addSubview:bar];
    bar2 = [[ResizeableBar alloc] initWithFrame:CGRectMake(10,190,80,30)];
    [self.view addSubview:bar2];
    
     
    bubble = [[EditBubble alloc] 
              initWithFrame:CGRectMake(bar.frame.origin.x + bar.frame.size.width ,bar.frame.origin.y - 40, 50, 30)]; 
    
    [self.view addSubview:bubble];
    bar.delegate = self;
   
}
-(void) resizeableBar:(ResizeableBar *) bar frameChanged:(CGRect)rect{
    bubble.message = [NSString stringWithFormat: @"%3.0f,%3.0f %3.0f,%3.0f", 
                      rect.origin.x,
                      rect.origin.y,
                      rect.size.width,
                      rect.size.height];
    
}

@end
