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
    UIScrollView *scrollV;
    int scorllType;


}

@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    if(self = [super initWithFrame:frame]) {
        self.obj = idObject;
    }
    return self;
}


-(UILabel*)createLable:(CGPoint)point andStr:(NSString*)LableStr andFrameSize:(CGSize)FrameSize andFont:(NSString*)FontStr andFontSize:(int)fontSize andType:(int)type{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x,point.y,FrameSize.width,FrameSize.height)];
    
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.text = LableStr;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:FontStr size:fontSize];
    
    if(type==1){
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithRed:88/255.0 green:85/255.0 blue:111/255.0 alpha:1.0];
        label.layer.cornerRadius = FrameSize.height/2;
        label.layer.masksToBounds = YES;
    }
    
    return  label;
}

-(float)getXWithForContentStr:(NSString*)contentStr{
    
    float num_x =0;
    NSString *perchar;
    int alength = [contentStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [contentStr characterAtIndex:i];
        NSString *temp = [contentStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            num_x = num_x+26*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>64)&&(commitChar<91)){
            num_x = num_x +23*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>96)&&(commitChar<123)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>47)&&(commitChar<58)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else{
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }
    }
    return num_x;
}


-(void)updateLableMove{
    
    if(scrollV.contentOffset.x>scrollV.contentSize.width){
           scrollV.contentOffset = CGPointMake(self.frame.size.width*-1, scrollV.contentOffset.y);
    
    }else{
        scrollV.contentOffset = CGPointMake(scrollV.contentOffset.x+0.3, scrollV.contentOffset.y);
    }
}


-(void)initView:(CGRect)frame andStr:(NSArray*)strArray andType:(int)type{
    scorllType = type;
    LableArray =[[NSMutableArray alloc] initWithArray:strArray];
    
    scrollV = [[UIScrollView alloc] initWithFrame:frame];
    
    [self addSubview:scrollV];
    scrollV.showsVerticalScrollIndicator = FALSE;
    scrollV.showsHorizontalScrollIndicator = FALSE;
  
    
    scrollV.bounces=NO;
    
    if(scorllType==1){
        int start_num_x=0;
        for (int i=0;i<[strArray count];i++){
            UILabel *labelTemp=[self createLable:CGPointMake(start_num_x, 0) andStr:[strArray objectAtIndex:i] andFrameSize:CGSizeMake(120*DEF_Adaptation_Font*0.5, frame.size.height) andFont:looperFont andFontSize:12 andType:type];
            [scrollV addSubview:labelTemp];
            start_num_x = start_num_x+120*DEF_Adaptation_Font*0.5+20*DEF_Adaptation_Font*0.5;
        }
        [scrollV setContentSize:CGSizeMake(start_num_x+120*DEF_Adaptation_Font*0.5, frame.size.height)];
    }else if(scorllType==2 ||scorllType==3){
        NSString *string = [strArray objectAtIndex:0];
        float num_x = [self getXWithForContentStr:string];
        UILabel *labelTemp=[self createLable:CGPointMake(0, 0) andStr:string andFrameSize:CGSizeMake(num_x, frame.size.height) andFont:looperFont andFontSize:15 andType:type];
        [scrollV addSubview:labelTemp];
        
        if(num_x>frame.size.width){
            UILabel *labelTwo=[self createLable:CGPointMake(num_x+20*DEF_Adaptation_Font*0.5, 0) andStr:string andFrameSize:CGSizeMake(num_x, frame.size.height) andFont:looperFont andFontSize:15 andType:type];
            [scrollV addSubview:labelTwo];
            [scrollV setContentSize:CGSizeMake(num_x+num_x+20*DEF_Adaptation_Font*0.5, frame.size.height)];
            if(scorllType==2){
                scrollV.userInteractionEnabled=NO;
                scrollV.scrollEnabled=false;
                NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(updateLableMove) userInfo:nil repeats:YES];
            }
        }else{
            [scrollV setContentSize:CGSizeMake(num_x,frame.size.height)];
        }
        
       // [self performSelector:@selector(updateLableMove) withObject:nil afterDelay:0.01];
      
    }
}



@end
