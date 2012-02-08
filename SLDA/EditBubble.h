//
//  EditBubble.h
//  ResizeBarTemp
//
//  Created by Nathan Sjoquist on 9/1/11.
//  Copyright 2011 Cedarville University. All rights reserved.
//

#import "ResizeableBar.h"
#import <UIKit/UIKit.h>

//these objects are created to display a value while your finger blocks viewspace
@interface EditBubble : UIView {
        /*this has*/
    //a message variable
    NSString *message;
    
    //an animation?
    
}
-(id) initWithFrame:(CGRect)frame; 
@property (nonatomic, copy) NSString * message;


@end
