//
//  SettingView.m
//  Looper
//
//  Created by lujiawei on 23/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nSettingView.h"
#import "SettingViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@implementation nSettingView

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
    
    if(button.tag==2000){
    
        [_obj backController];
    
    }else if(button.tag==2001){
        [_obj addInfoView];
    
    }else if(button.tag==2002){
        [_obj addAccoutView];
        
    }else if(button.tag==2003){
        [_obj addOpinionView];
        
    }else if(button.tag==2005){
        [_obj jumpLoginViewC];
        
    }

}



-(void)initView{
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    

    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:2000 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];


    UIImageView * title=[LooperToolClass createImageView:@"setting_title.png" andRect:CGPointMake(293, 54) andTag:100 andSize:CGSizeMake(51,23) andIsRadius:false];
    [self addSubview:title];
    
    UIButton *myInfo =[LooperToolClass createBtnImageName:@"btn_myInfo.png" andRect:CGPointMake(34, 132) andTag:2001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: myInfo];
    
    
    UIButton *accoutBtn =[LooperToolClass createBtnImageName:@"btn_accout.png" andRect:CGPointMake(34, 243) andTag:2002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: accoutBtn];
    
    
    UIButton *opinionBtn =[LooperToolClass createBtnImageName:@"btn_opinion.png" andRect:CGPointMake(34, 353) andTag:2003 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: opinionBtn];
    
    UIButton *aboutBtn =[LooperToolClass createBtnImageName:@"btn_about.png" andRect:CGPointMake(34, 464) andTag:2004 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: aboutBtn];
    
    
    UILabel *verison = [LooperToolClass createLableView:CGPointMake(500*DEF_Adaptation_Font_x*0.5, 500*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(92*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"v1.0" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:verison];

    
    UIButton *logOut =[LooperToolClass createBtnImageName:@"loginOut.png" andRect:CGPointMake(73, 982) andTag:2005 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: logOut];
    
    
    
    
}



@end
