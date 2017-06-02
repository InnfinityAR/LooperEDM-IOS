//
//  UICollectionView+UITouch.m
//  Looper
//
//  Created by 工作 on 2017/6/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "UICollectionView+UITouch.h"

@implementation UICollectionView (UITouch)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    {
        [[self nextResponder] touchesMoved:touches withEvent:event];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}
@end
