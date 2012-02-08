//
//  ResizeableBar.m
//  ResizeBarTemp
//
//  Created by Nathan Sjoquist on 8/29/11.
//  Copyright 2011 Cedarville University. All rights reserved.
//

#import "ResizeableBar.h"
#import "EditBubble.h"
#import <QuartzCore/QuartzCore.h>

#define kMarginX 10.0
#define kMarginY 10.0
#define kResizingTouchWidth 20.0
#define kAnimationLength 0.1
#define kAnimationintervals 10
#define kInitResizerScale 0.2

@interface ResizeableBar ()

-(void) drawSelectionIdentifier:(CGRect) rect withContext: (CGContextRef) context;
-(void) resizeFrame: (CGRect) rect;

@end

@implementation ResizeableBar

@synthesize resizing = resizing_;
@synthesize delegate;

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        size = frame.size;

        self.bounds = CGRectMake(-kMarginX, -kMarginY, 
                                 size.width + kMarginX*2, 
                                 size.height + kMarginY*2);

        self.opaque = NO;
        self.layer.anchorPoint = CGPointMake(0, 0.5);
        [self configureRecognizers];  
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void) configureRecognizers {
   lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doLongPress:)];
    [self addGestureRecognizer:lp];
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPan:)];
    [self addGestureRecognizer: pan];

}

- (void) stopTimer {
    [timer invalidate];
    [timer release], timer = nil;
}

- (void) setResizing:(BOOL)resizing {
    if (resizing != resizing_) {
        resizing_ = resizing;
        [pan setEnabled:!resizing_];
        
        if (resizing_) {
            //create the Edit Bubble
            
            
            
            //deal with the resizing
            resizerScale = kInitResizerScale;
            raStartTime = [NSDate timeIntervalSinceReferenceDate];
            NSTimeInterval interval = kAnimationLength/kAnimationintervals;
//            NSLog(@"interval: %f", interval);
            
            timer = [[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerTick:) userInfo:nil repeats:YES] retain];
            
            [timer fire];
        }
        else {
        
            [self stopTimer];
        
        }
    }
}

- (void)timerTick:(NSTimer*)timer {
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval difference = currentTime - raStartTime;
    if (difference < kAnimationLength) {
        resizerScale = ((difference/kAnimationLength)*(1 - kInitResizerScale))+kInitResizerScale;
    }
    else{
    
        resizerScale = 1.0;
        [self stopTimer];
    
    }
//    NSLog(@"diff=%f, scale=%f", difference, resizerScale);
    [self setNeedsDisplay];
}
- (void) moveBar:(id) sender {
    UIGestureRecognizerState state = [sender state];
    if (state == UIGestureRecognizerStateBegan) {
        panStart = self.frame.origin;
        return;
    }
    CGPoint pt = [sender translationInView:nil];
    [self resizeFrame: (CGRect) {{panStart.x+pt.x,panStart.y}, self.frame.size}];
}

-(BOOL) startedResize: (CGPoint) pt{
    if (pt.x > kResizingTouchWidth &&  pt.x < (size.width - kResizingTouchWidth)) {
        return NO;
    } 
    CGFloat check = size.width < (kResizingTouchWidth*2) ? size.width / 2:kResizingTouchWidth;
        resizingLeft = (pt.x <= check);
        lastPt = pt;
//        NSLog(@"start: %f", lastPt.x);
    self.resizing = YES;
    return YES;

}

-(void) resizeFrame: (CGRect) rect{
    self.frame = rect;
    [self.delegate resizeableBar:self frameChanged:rect];
}

-(void) handleResize: (CGPoint) pt {

//    NSLog(@"move to: %f", pt.x);
    if (resizingLeft) {
        CGFloat diffX = lastPt.x - pt.x;
        CGFloat newWidth = size.width + diffX;
        if (newWidth < 10) {
            return;
        }
        CGRect f  = self.frame;
        [self resizeFrame:CGRectMake(f.origin.x - diffX,
                                f.origin.y, 
                                f.size.width + diffX,
                                f.size.height)];
        size = CGSizeMake(newWidth, size.height);
        [self setNeedsDisplay];
    } else {
        CGFloat diffX = pt.x - lastPt.x;
        CGFloat newWidth = size.width + diffX;
        if (newWidth < 10) {
            return;
        }
        CGRect f  = self.frame;
        [self resizeFrame: CGRectMake(f.origin.x,
                                f.origin.y, 
                                f.size.width + diffX,
                                f.size.height)];
        size = CGSizeMake(newWidth, size.height);
        lastPt = pt;
        [self setNeedsDisplay];
    }
    


}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (!resizing_) {
        return;
    }
    CGPoint pt = [touch locationInView:self];
    [self startedResize:pt];
    
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (!resizing_) {
        return;
    }
    CGPoint pt = [touch locationInView:self];
    [self handleResize:pt];
    
}



- (void) doPan:(id) sender {
        [self moveBar:sender];
}

- (void) doLongPress:(id) sender {
//    NSLog(@"doLongPress: state=%u", [sender state]);
    if ([sender state] == UIGestureRecognizerStateBegan) {
        self.resizing = !self.resizing;
        [self setNeedsDisplay];
    }
}


- (void) drawRect:(CGRect)frame {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 0.3, 0.3, 0.5);
    CGContextFillRect(context, (CGRect) {CGPointZero,size});
    
    if (self.resizing) {
                [self drawSelectionIdentifier: frame withContext: context];
        
    }
}

//what we do to show selected Resizeable Bars
- (void) drawSelectionIdentifier:(CGRect)frame 
                     withContext:(CGContextRef) context
{

    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 1.5);
    
    //draw upper lines
    
    CGFloat margin = 2.0;
    CGFloat offset = 6.0;
    
    CGFloat centerX = size.width / 2;
    CGFloat xRadius = (size.width / 2) * resizerScale;

    CGFloat centerY = size.height / 2;
    CGFloat yRadius = (size.height / 2) * resizerScale;
    
    CGFloat left =  centerX - xRadius;
    CGFloat right = centerX + xRadius;
    
    CGFloat top = centerY - yRadius;
    CGFloat bottom = centerY + yRadius;
    
    CGFloat x1 = left + offset;
    CGFloat y1 = top - margin;
    
    CGFloat x2 = right + margin;
    CGFloat y2 = y1;
    
    CGFloat x3 = x2;
    CGFloat y3 = bottom - offset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x1, y1);
    CGContextAddLineToPoint(context, x2, y2);
    CGContextAddLineToPoint(context, x3, y3);
    
    //draw lower lines
    
    CGFloat x4 = right - offset;
    CGFloat y4 = bottom + margin;
    
    CGFloat x5 = left - margin;
    CGFloat y5 = y4;

    CGFloat x6 = x5;
    CGFloat y6 = top + offset;
    
    CGContextMoveToPoint(context, x4, y4);
    CGContextAddLineToPoint(context, x5, y5);
    CGContextAddLineToPoint(context, x6, y6);

    CGContextStrokePath(context);
    
    CGContextSetRGBFillColor(context, 0, 0.0, 0.0, 1);
    CGContextFillRect(context, (CGRectMake(-4, -4, 8, 8)));
    CGContextFillRect(context, (CGRectMake(size.width -4,size.height -4, 8, 8)));
}


@end
