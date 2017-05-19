//
//  TouchScrollView.m
//  Looper
//
//  Created by lujiawei on 3/31/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "TouchScrollView.h"

@implementation TouchScrollView

@synthesize touchDelegate = _touchDelegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    
    [_touchDelegate tableView:self touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

    [_touchDelegate tableView:self touchesCancelled:touches withEvent:event];


     NSLog(@"touchesCancelled");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    [_touchDelegate tableView:self touchesEnded:touches withEvent:event];
 
    NSLog(@"touchesEnded");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
 
    [_touchDelegate tableView:self touchesMoved:touches withEvent:event];
    NSLog(@"touchesMoved");
    
}



@end
