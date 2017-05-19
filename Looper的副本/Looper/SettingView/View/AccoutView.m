//
//  AccoutView.m
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "AccoutView.h"
#import "SettingViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"


@implementation AccoutView{

    UIButton *phonebind;
    
    UIButton *wechatbind;

}
@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (SettingViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==3000){
    
        [_obj removeAccoutView];
    
    }else if(button.tag==3003){
        if([[LocalDataMangaer sharedManager].userData objectForKey:@"openid"]==[NSNull null]){
            
        
        }
    
    }else if(button.tag==3002){
        
        if([[LocalDataMangaer sharedManager].userData objectForKey:@"mobile"]==[NSNull null]){
            
             [_obj addPhoneBindView];
        }
       
    }
    
}



-(void)updataAccess:(int)accessNum{
    if(accessNum==1){
        [wechatbind setSelected:true];
    }else if(accessNum==2){
        [phonebind setSelected:true];
    }
}



-(void)initView{
    
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    
    UIButton *backBtn =[LooperToolClass createBtnImageName:@"btn_looper_back.png" andRect:CGPointMake(15, 65) andTag:3000 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: backBtn];
    
    UIImageView * title=[LooperToolClass createImageView:@"bg_account_title.png" andRect:CGPointMake(224, 54) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:title];
    
    UIImageView * wechat=[LooperToolClass createImageView:@"icon_wechat.png" andRect:CGPointMake(38, 264) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:wechat];
    
    UIImageView * phone=[LooperToolClass createImageView:@"icon_phone.png" andRect:CGPointMake(38, 168) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:phone];
    
    UIImageView * lineV1=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(43, 246) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:lineV1];
    
    UIImageView * lineV2=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(43, 320) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:lineV2];

    phonebind=[LooperToolClass createBtnImageName:@"btn_unBind.png" andRect:CGPointMake(471, 161) andTag:3002 andSelectImage:@"btn_bind.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: phonebind];
    
    wechatbind=[LooperToolClass createBtnImageName:@"btn_unBind.png" andRect:CGPointMake(471, 257) andTag:3003 andSelectImage:@"btn_bind.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: wechatbind];
    
    
    
    if([[LocalDataMangaer sharedManager].userData objectForKey:@"openid"]!=[NSNull null]){
    
        [wechatbind setSelected:true];
    }
    
    if([[LocalDataMangaer sharedManager].userData objectForKey:@"mobile"]!=[NSNull null]){
        
        [phonebind setSelected:true];
    }
    
    
    
    
    
}

@end
