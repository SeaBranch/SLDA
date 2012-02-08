//
//  EditBubble.m
//  ResizeBarTemp
//
//  Created by Nathan Sjoquist on 9/1/11.
//  Copyright 2011 Cedarville University. All rights reserved.
//

#import "EditBubble.h"
#import <QuartzCore/QuartzCore.h>


@implementation EditBubble
@synthesize message;

-(id)initWithFrame:(CGRect)     frame
                   {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

-(void) setMessage:(NSString *)aMessage{
    [message release];
    message = [aMessage copy];
    [self setNeedsDisplay];
}
- (void) drawRect:(CGRect)frame {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, self.bounds);
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    
    CGContextSelectFont (context, "Helvetica", 10, kCGEncodingMacRoman);
    CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
    CGContextSetTextMatrix(context, xform);
    CGContextSetTextDrawingMode (context, kCGTextStroke);
    CGContextSetTextPosition (context, 0.0, 30.0);
    CGContextShowText (context, [message cStringUsingEncoding:NSUTF8StringEncoding], [message length]);

}

-(void) dealloc{
    [message release], message = nil;
    [super dealloc];

}


@end
