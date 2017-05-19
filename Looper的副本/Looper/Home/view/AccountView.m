//
//  AccountView.m
//  Looper
//
//  Created by lujiawei on 12/29/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "AccountView.h"
#import "HomeViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "UIImage+RTTint.h"

@implementation AccountView{

    NSMutableDictionary *data;
    
    NSTimer *timeColor;
    UIImageView *bk;
    double colorNum;
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

-(void)initView{
    [self createBackGround];
    [self getSettingInfo];
   
  

}


-(void)getSettingInfo{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getBinding" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            data = responseObject[@"data"];
            [self createHudBtn];
        }else{
            
            
        }
    }fail:^{
        
    }];
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
    
    if(button.tag ==AccountBackTag){
    
    
        [timeColor invalidate];
    }
    
    
    
    [self.obj hudOnClick:button.tag];
    
}


-(void)createHudBtn{
    
    UIButton *backBtn = [LooperToolClass createBtnImageName:@"btn_accounts_back.png" andRect:CGPointMake(48, 76) andTag:AccountBackTag andSelectImage:@"btn_accounts_back.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:backBtn];
    
    
    UIImageView *info=[LooperToolClass createImageView:@"icon_accounts_info.png" andRect:CGPointMake(82, 213) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:info];
    
    UIButton *phoneBtn = [LooperToolClass createBtnImageName:@"btn_accounts_unbinding.png" andRect:CGPointMake(461, 271) andTag:AccountBindPhoneTag andSelectImage:@"btn_accounts_binding.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:phoneBtn];

    if([data objectForKey:@"AccountMobile"]!=[NSNull null]){
        [phoneBtn setSelected:true];
    }

    UIButton *wechatBtn = [LooperToolClass createBtnImageName:@"btn_accounts_unbinding.png" andRect:CGPointMake(461, 350) andTag:AccountBindWechatTag andSelectImage:@"btn_accounts_binding.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:wechatBtn];
    if([data objectForKey:@"WeixinID"]!=[NSNull null]){
        [wechatBtn setSelected:true];
    }
    
    
    UIButton *QQBtn = [LooperToolClass createBtnImageName:@"btn_accounts_unbinding.png" andRect:CGPointMake(461, 430) andTag:AccountBackQQTag andSelectImage:@"btn_accounts_binding.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:QQBtn];
    if([data objectForKey:@"QQID"]!=[NSNull null]){
        [QQBtn setSelected:true];
    }
    
    UIButton *WEIBOBtn = [LooperToolClass createBtnImageName:@"btn_accounts_unbinding.png" andRect:CGPointMake(461, 510) andTag:AccountBindWEIBOTag andSelectImage:@"btn_accounts_binding.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:WEIBOBtn];
    if([data objectForKey:@"WeiBoID"]!=[NSNull null]){
        [WEIBOBtn setSelected:true];
    }

    


}


@end
