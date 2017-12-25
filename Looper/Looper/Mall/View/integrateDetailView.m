//
//  integrateDetailView.m
//  Looper
//
//  Created by lujiawei on 13/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "integrateDetailView.h"
#import "MallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"-

@implementation integrateDetailView{
    
    
    UIScrollView *mallScrollV;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (MallViewModel*)idObject;
        [self createScrollView];
        [self initView];
        
    }
    return self;
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag ==100){
        [self removeFromSuperview];
    }
}


-(void)updateDataView:(NSArray*)arrayData{
    
    NSLog(@"%@",arrayData);
    
    
    int num_y = 364*DEF_Adaptation_Font*0.5;
    
    for (int i=0;i<[arrayData count];i++){
        
        NSLog(@"%@",[arrayData objectAtIndex:i]);
        
        NSString *showTitle;
        if([[[arrayData objectAtIndex:i] objectForKey:@"creditfrom"] intValue]==1){
            showTitle = @"打卡签到";
        }else{
            showTitle = @"每天签到";
        }
        UILabel *titleName=[[UILabel alloc]initWithFrame:CGRectMake(27*DEF_Adaptation_Font*0.5, num_y, 99*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font*0.5)];
        titleName.font=[UIFont systemFontOfSize:13];
        titleName.textColor=[UIColor whiteColor];
        titleName.text=showTitle;
        [mallScrollV addSubview:titleName];
        
        UILabel *timeName=[[UILabel alloc]initWithFrame:CGRectMake(27*DEF_Adaptation_Font*0.5,num_y+35*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font*0.5)];
        timeName.font=[UIFont systemFontOfSize:13];
        timeName.textColor=[UIColor whiteColor];

        [mallScrollV addSubview:timeName];
        

        
        NSString* timeStr =[[arrayData objectAtIndex:i] objectForKey:@"creationdate"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与      HH的区别:分别表示12小时制,24小时制

        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate* date = [formatter dateFromString:timeStr];
        

        NSDate  *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
        
        NSInteger year=[components year];
        NSInteger month=[components month];
        NSInteger day=[components day];
        NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",currentDate,year,month,day);

        timeName.text=[NSString stringWithFormat:@"%d.%d.%d",year,month,day];

        UILabel *addIntegrateNum=[[UILabel alloc]initWithFrame:CGRectMake(550*DEF_Adaptation_Font*0.5, num_y+16*DEF_Adaptation_Font*0.5, 58*DEF_Adaptation_Font*0.5, 31*DEF_Adaptation_Font*0.5)];
        addIntegrateNum.font=[UIFont systemFontOfSize:13];
        addIntegrateNum.textColor=[UIColor whiteColor];
        addIntegrateNum.text=[NSString stringWithFormat:@"+%@",[[arrayData objectAtIndex:i] objectForKey:@"credit"]];
        [mallScrollV addSubview:addIntegrateNum];
        
        num_y = num_y +90*DEF_Adaptation_Font*0.5;
    }
    
    [mallScrollV setContentSize:CGSizeMake(DEF_SCREEN_WIDTH,num_y)];
    
}

-(void)createScrollView{
    mallScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    mallScrollV.showsVerticalScrollIndicator = NO;
    mallScrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:mallScrollV];
    
    [mallScrollV setContentSize:CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2)];
}





-(void)initView{
    
    
    [self createScrollView];
    
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    [self setBackgroundColor:[UIColor colorWithRed:39/255.0 green:39/255.0 blue:72/255.0 alpha:1.0]];
    
    UILabel *titleName=[[UILabel alloc]initWithFrame:CGRectMake(279*DEF_Adaptation_Font*0.5, 66*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    titleName.font=[UIFont systemFontOfSize:11];
    titleName.textColor=[UIColor whiteColor];
    titleName.text=@"积分明细";
    [mallScrollV addSubview:titleName];
    
    UILabel *integrateLable=[[UILabel alloc]initWithFrame:CGRectMake(282*DEF_Adaptation_Font*0.5, 128*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    integrateLable.font=[UIFont systemFontOfSize:11];
    integrateLable.textColor=[UIColor whiteColor];
    integrateLable.text=@"当前积分";
    [mallScrollV addSubview:integrateLable];
    
    
    UIImageView *integrate_icon = [LooperToolClass createImageView:@"icon_integrate_max.png" andRect:CGPointMake(212, 175) andTag:100 andSize:CGSizeMake(34, 40) andIsRadius:false];
    [mallScrollV addSubview:integrate_icon];
    
    UILabel *integrateNum=[[UILabel alloc]initWithFrame:CGRectMake(269*DEF_Adaptation_Font*0.5, 173*DEF_Adaptation_Font*0.5, 169*DEF_Adaptation_Font*0.5, 52*DEF_Adaptation_Font*0.5)];
    integrateNum.font=[UIFont systemFontOfSize:16];
    integrateNum.textColor=[UIColor whiteColor];
    integrateNum.text=[NSString stringWithFormat:@"%@积分",[LocalDataMangaer sharedManager].creditNum];

    integrateNum.textColor=[UIColor colorWithRed:136/255.0 green:131/255.0 blue:250/255.0 alpha:1.0];
    [mallScrollV addSubview:integrateNum];
    
    UILabel *integrateLog=[[UILabel alloc]initWithFrame:CGRectMake(283*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    integrateLog.font=[UIFont systemFontOfSize:11];
    integrateLog.textColor=[UIColor whiteColor];
    integrateLog.text=@"积分记录";
    [mallScrollV addSubview:integrateLog];
    
}


@end
