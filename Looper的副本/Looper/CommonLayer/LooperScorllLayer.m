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

@implementation LooperScorllLayer{

    NSMutableArray *LableArray;


}

@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    if(self = [super initWithFrame:frame]) {
        self.obj = idObject;
    }
    return self;
}


-(UILabel*)createLable:(CGPoint)point andStr:(NSString*)LableStr andFrameSize:(CGSize)FrameSize andFont:(NSString*)FontStr andFontSize:(int)fontSize{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x,point.y,FrameSize.width,FrameSize.height)];
    label.backgroundColor = [UIColor colorWithRed:88/255.0 green:85/255.0 blue:111/255.0 alpha:1.0];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = LableStr;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:FontStr size:fontSize];
    label.layer.cornerRadius = FrameSize.height/2;
    label.layer.masksToBounds = YES;

    
    return  label;
}




-(void)initView:(CGRect)frame andStr:(NSArray*)strArray{
    LableArray =[[NSMutableArray alloc] initWithArray:strArray];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:frame];
   
    [self addSubview:scrollV];
    scrollV.showsVerticalScrollIndicator = FALSE;
    scrollV.showsHorizontalScrollIndicator = FALSE;
    
    int start_num_x=0;
    
    for (int i=0;i<[strArray count];i++){
        UILabel *labelTemp=[self createLable:CGPointMake(start_num_x, 0) andStr:[strArray objectAtIndex:i] andFrameSize:CGSizeMake(120*DEF_Adaptation_Font*0.5, frame.size.height) andFont:looperFont andFontSize:12];
        [scrollV addSubview:labelTemp];
        
    
        start_num_x = start_num_x+120*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5;
    }
     [scrollV setContentSize:CGSizeMake(start_num_x+120*DEF_Adaptation_Font*0.5, frame.size.height)];

}



@end
