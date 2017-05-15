//
//  LooperScorllLayer.m
//  Looper
//
//  Created by lujiawei on 2/9/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LooperScorllLayer.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@implementation LooperScorllLayer

@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andStr:(NSString*)str{
    if(self = [super initWithFrame:frame]) {
        self.obj = idObject;
        [self initView:frame andStr:str];
    }
    return self;
}


-(UILabel*)createLable:(CGPoint)point andStr:(NSString*)LableStr andFont:(NSString*)FontStr andFontSize:(int)fontSize{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, self.frame.size.width, 50)];
    label.backgroundColor = [UIColor grayColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.text = LableStr;
    label.font = [UIFont fontWithName:FontStr size:fontSize];
    
 
    return  label;
}



-(void)initView:(CGRect)frame andStr:(NSString*)str{

    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:frame];
    
    
    
    
    [self addSubview:scrollV];
    



}


@end
