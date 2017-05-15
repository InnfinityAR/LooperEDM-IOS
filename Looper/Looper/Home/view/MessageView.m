//
//  MessageView.m
//  Looper
//
//  Created by lujiawei on 12/29/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "MessageView.h"
#import "HomeViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "ZJSwitch.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "UIImage+RTTint.h"

@implementation MessageView
{

    ZJSwitch *switch1;
    ZJSwitch *switch2;
    ZJSwitch *switch3;
    NSMutableDictionary *data;
    UIImageView *bk;
    
    double colorNum;
    NSTimer *timeColor;


}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (HomeViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
}


-(void)createBackGround{
    
    colorNum = 0.01f;
    
     UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(18*DEF_Adaptation_Font*0.5,39*DEF_Adaptation_Font*0.5,615*DEF_Adaptation_Font_x*0.5, 1018*DEF_Adaptation_Font*0.5)];
    
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self addSubview:bk1];
    bk1.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    
    bk=[LooperToolClass createImageView:@"bg_setting_behind.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bk];
    
    UIImageView *bk_font=[LooperToolClass createImageView:@"bg_setting_front.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:bk_font];
    
    timeColor = [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(updateColor) userInfo:nil repeats:YES];
}



-(void)updateColor{
    
    UIImage *tinted = [bk.image rt_tintedImageWithColor: [UIColor colorWithHue:colorNum+0.003f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    colorNum = colorNum +0.003f;
    bk.image = tinted;
    if(colorNum>1.0){
        colorNum = 0.001f;
    }
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag ==MessageBackTag){
    
        [timeColor invalidate];
    }
    
    
    [self.obj hudOnClick:button.tag];
    
}

-(void)getSettingInfo{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];

    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getNotificationSetting" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            data = responseObject[@"data"];
          
            [self createHudBtn];
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}



-(void)createHudBtn{
    
    UIButton *backBtn = [LooperToolClass createBtnImageName:@"btn_message_back.png" andRect:CGPointMake(48, 76) andTag:MessageBackTag andSelectImage:@"btn_message_back.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:backBtn];
    
    UIImageView *set=[LooperToolClass createImageView:@"btn_message_set.png" andRect:CGPointMake(85, 187) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:set];
    
    UIImageView *info=[LooperToolClass createImageView:@"lable_message_info.png" andRect:CGPointMake(74, 231) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:info];

    switch1 = [[ZJSwitch alloc] initWithFrame:CGRectMake(490*DEF_Adaptation_Font*0.5, 235*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    switch2.backgroundColor = [UIColor clearColor];
    switch1.tintColor = [UIColor colorWithRed:82.0 / 255.0 green:82.0 / 255.0 blue:82.0 / 255.0 alpha:1.0];
    switch1.onText = @"ON";
    switch1.offText = @"OFF";
    switch1.tag =1;
    [switch1 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:switch1];
    if([[data objectForKey:@"ThumbUpNotification"] intValue]==1){
        [switch1 setOn:true];
    }

    switch2 = [[ZJSwitch alloc] initWithFrame:CGRectMake(490*DEF_Adaptation_Font*0.5, 282*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    switch2.backgroundColor = [UIColor clearColor];
    switch2.tintColor = [UIColor colorWithRed:82.0 / 255.0 green:82.0 / 255.0 blue:82.0 / 255.0 alpha:1.0];
    switch2.onText = @"ON";
    switch2.offText = @"OFF";
    switch2.tag =2;
    [switch2 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:switch2];
    if([[data objectForKey:@"FansNotification"] intValue]==1){
        [switch2 setOn:true];
    }

    switch3 = [[ZJSwitch alloc] initWithFrame:CGRectMake(490*DEF_Adaptation_Font*0.5, 410*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    switch3.backgroundColor = [UIColor clearColor];
    switch3.tintColor = [UIColor colorWithRed:82.0 / 255.0 green:82.0 / 255.0 blue:82.0 / 255.0 alpha:1.0];
    switch3.onText = @"ON";
    switch3.offText = @"OFF";
    switch3.tag =3;
    [switch3 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:switch3];
    if([[data objectForKey:@"MessageNotification"] intValue]==1){
        [switch3 setOn:true];
    }

}




- (void)handleSwitchEvent:(ZJSwitch *)sender
{
    NSLog(@"%s", __FUNCTION__);
    int num;
    if(sender.on==true){
        num =1;
    }else{
         num =0;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInt:num] forKey:@"value"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[NSNumber numberWithInt:sender.tag] forKey:@"type"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"updateNotificationSettingByUserID" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){

        }else{
            
            
        }
    }fail:^{
        
    }];
}



-(void)initView{
    [self createBackGround];
    [self getSettingInfo];
  

}

@end
