//
//  ActivityLayer.m
//  Looper
//
//  Created by lujiawei on 12/22/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "ActivityLayer.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "MainViewModel.h"


@implementation ActivityLayer
@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = idObject;
    }
    return self;
}

-(void)createBk{
    
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];

    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(18*0.5*DEF_Adaptation_Font,41*0.5*DEF_Adaptation_Font,604*DEF_Adaptation_Font_x*0.5, 1006*DEF_Adaptation_Font*0.5);
    effectView.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    effectView.layer.masksToBounds = YES;

    [self addSubview:effectView];
    
    /*
    
    UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(18*DEF_Adaptation_Font*0.5,39*DEF_Adaptation_Font*0.5,604*DEF_Adaptation_Font_x*0.5, 1006*DEF_Adaptation_Font*0.5)];
    
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self addSubview:bk1];
    bk1.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    */
     

    UIImageView *bk_down=[LooperToolClass createImageView:@"bg_down.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bk_down];
    
    UIImageView *bg_up=[LooperToolClass createImageView:@"bg_up.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bg_up];
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    [self.obj hudOnClick:button.tag];
    
}


-(void)createHudView{


    UIButton *backBtn = [LooperToolClass createBtnImageName:@"btn_back.png" andRect:CGPointMake(49, 71) andTag:ActivityBackBtnTag andSelectImage:@"btn_back.png" andClickImage:@"btn_back.png" andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:backBtn];
    
    
    UIImageView *hot=[LooperToolClass createImageView:@"btn_hot.png" andRect:CGPointMake(506, 92) andTag:100 andSize:CGSizeMake(85*DEF_Adaptation_Font_x*0.5, 37*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:hot];
    
    UIButton *follow = [LooperToolClass createBtnImageName:@"btn_unfollow.png" andRect:CGPointMake(459, 225) andTag:ActivityFollowBtnTag andSelectImage:@"btn_follow.png" andClickImage:@"btn_follow.png" andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:follow];

    UIImageView *head=[LooperToolClass createImageView:@"icon_head.png" andRect:CGPointMake(49, 170) andTag:100 andSize:CGSizeMake(99*DEF_Adaptation_Font_x*0.5, 99*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:head];
    
    UIButton *like= [LooperToolClass createBtnImageName:@"btn_unlike.png" andRect:CGPointMake(142, 984) andTag:ActivityLikeBtnTag andSelectImage:@"btn_like.png" andClickImage:@"btn_like.png" andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:like];
    
    UIButton *share = [LooperToolClass createBtnImageName:@"btn_share.png" andRect:CGPointMake(464, 992) andTag:ActivityShareBtnTag andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:share];
    
    
    
    
}

-(void)initViewWithData:(NSDictionary*)data{
    
    [self createBk];
    [self createHudView];
    
}







@end
