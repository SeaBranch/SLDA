//
//  ResizeBarTempViewController.h
//  ResizeBarTemp
//
//  Created by Nathan Sjoquist on 8/29/11.
//  Copyright 2011 Cedarville University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResizeableBar.h"
#import "EditBubble.h"

@interface ResizeBarTempViewController : UIViewController <ResizeableBarDelegate> {
    CGPoint panStart;
    NSMutableArray *resisableBars;
    ResizeableBar *bar;
    ResizeableBar *bar2;
    
    EditBubble *bubble;
}

@end
