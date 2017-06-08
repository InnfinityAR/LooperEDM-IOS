//
//  SimpleCellView.m
//  Looper
//
//  Created by lujiawei on 2/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SimpleCellView.h"
#import "SimpleChatView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"

@implementation SimpleCellView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (SimpleChatView*)idObject;
        
    }
    return self;
}


-(int)getContentLength:(NSString*)contentStr{

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

-(int)getYWithForContentStr:(NSString*)contentStr{
    
    
    int num_x=[self getContentLength:contentStr];
    
      int num_y = num_x/(330*DEF_Adaptation_Font_x*0.5);
    
    if(num_x>(330*DEF_Adaptation_Font_x*0.5)){
        return num_y+1;
        
    }else{
        return 1;
    }
    return num_y+1;
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


-(void)createWithData:(NSDictionary*)cellData and:(id)obj and:(BOOL)isHasTime{
    
    int add_y=0;
    if(isHasTime ==true){
        add_y = 54*0.5*DEF_Adaptation_Font;
    
    }
     if(isHasTime ==true){
    NSString *timeStr =[self timeWithTimeIntervalString:[cellData objectForKey:@"sentTime"]];
    UILabel *timeLable = [LooperToolClass createLableView:CGPointMake(220*DEF_Adaptation_Font_x*0.5, 29*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 16*DEF_Adaptation_Font_x*0.5) andText:timeStr andFontSize:10 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:timeLable];
     }
    

    if([[cellData objectForKey:@"senderUserId"] intValue]!=[[[LocalDataMangaer sharedManager] uid] intValue]){
    
        UIView *headView = [LooperToolClass createViewAndRect:CGPointMake(12, 20+add_y/0.5/DEF_Adaptation_Font) andTag:100 andSize:CGSizeMake(55*0.5*DEF_Adaptation_Font,55*0.5*DEF_Adaptation_Font) andIsRadius:true andImageName:cellData[@"HeadImageUrl"]];
        [self addSubview:headView];
        
        int num_y = [self getYWithForContentStr:[cellData objectForKey:@"text"]];
        
        int width = 0;
        if(num_y==1){
            width = [self getContentLength:[cellData objectForKey:@"text"]] +30*0.5*DEF_Adaptation_Font;
        }else{
            width = 330*0.5*DEF_Adaptation_Font+15*0.5*DEF_Adaptation_Font;
        }
        
        UIView *frame = [[UIView  alloc] initWithFrame:CGRectMake((12+55+16)*0.5*DEF_Adaptation_Font, 20*0.5*DEF_Adaptation_Font +add_y,width, (num_y*32+20)*0.5*DEF_Adaptation_Font)];
        [frame setBackgroundColor:[UIColor colorWithRed:246/255.0 green:241/255.0 blue:254/255.0 alpha:1.0]];
        
        frame.layer.cornerRadius = 20*0.5*DEF_Adaptation_Font;
        frame.layer.masksToBounds = YES;
        [self addSubview:frame];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(10*DEF_Adaptation_Font_x*0.5, 5*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(330*DEF_Adaptation_Font_x*0.5, num_y*45*DEF_Adaptation_Font_x*0.5) andText:[cellData objectForKey:@"text"] andFontSize:13 andColor:[UIColor colorWithRed:134/255.0 green:73/255.0 blue:170/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [frame addSubview:titleNum];
        titleNum.numberOfLines=0;
         [titleNum sizeToFit];
 
    }else{
    
        UIView *headView = [LooperToolClass createViewAndRect:CGPointMake(573, 20+add_y/0.5/DEF_Adaptation_Font) andTag:100 andSize:CGSizeMake(55*0.5*DEF_Adaptation_Font, 55*0.5*DEF_Adaptation_Font) andIsRadius:true andImageName:cellData[@"HeadImageUrl"]];
        [self addSubview:headView];
        
        int num_y = [self getYWithForContentStr:[cellData objectForKey:@"text"]];
        int width = 0;
        if(num_y==1){
            width = [self getContentLength:[cellData objectForKey:@"text"]] +30*0.5*DEF_Adaptation_Font;
        }else{
            width = 330*0.5*DEF_Adaptation_Font+15*0.5*DEF_Adaptation_Font;
        }
        
        UIView *frame = [[UIView  alloc] initWithFrame:CGRectMake(573*DEF_Adaptation_Font_x*0.5-width-16*0.5*DEF_Adaptation_Font, 20*0.5*DEF_Adaptation_Font+add_y,width, (num_y*32+20)*0.5*DEF_Adaptation_Font)];
        [frame setBackgroundColor:[UIColor colorWithRed:195/255.0 green:119/255.0 blue:221/255.0 alpha:1.0]];
        frame.layer.cornerRadius = 20*0.5*DEF_Adaptation_Font;
        frame.layer.masksToBounds = YES;
        [self addSubview:frame];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(12*DEF_Adaptation_Font_x*0.5, 5*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(330*DEF_Adaptation_Font_x*0.5, num_y*45*DEF_Adaptation_Font_x*0.5) andText:[cellData objectForKey:@"text"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [frame addSubview:titleNum];
        titleNum.numberOfLines=0;
        [titleNum sizeToFit];

    }
}


@end
