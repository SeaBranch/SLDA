//
//  ResizeableBar.h
//  ResizeBarTemp
//
//  Created by Nathan Sjoquist on 8/29/11.
//  Copyright 2011 Cedarville University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResizeableBar;

@protocol ResizeableBarDelegate <NSObject>

//declare resized
-(void) resizeableBar:(ResizeableBar *) bar frameChanged: (CGRect) rect;

@end
@interface ResizeableBar : UIView {
    UILongPressGestureRecognizer *lp;
    UIPanGestureRecognizer *pan;
    CGPoint panStart;
    CGSize size;
    CGPoint lastPt;
    CGFloat resizerScale;
    NSTimeInterval raStartTime;
    NSTimer *timer;
       BOOL resizingLeft;
    
    //generics
    id <ResizeableBarDelegate> delegate;
}

@property (nonatomic,assign) BOOL resizing;
@property (nonatomic,assign) id <ResizeableBarDelegate> delegate;
- (void) configureRecognizers;
@end
