//
//  looperDetailView.m
//  Looper
//
//  Created by lujiawei on 1/19/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "looperDetailView.h"
#import "looperViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "UIScrollView+TwitterCover.h"

@implementation looperDetailView{

    NSDictionary *looper;
    UIScrollView *scrollView;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;
        
    }
    return self;
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag == 500){
        [_obj removeLooperDatail];
    
    }else if(button.tag == 501){
        [_obj shareH5];
    
    
    }
}


-(void)createScrollView{

    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [scrollView setContentSize:CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT+71*DEF_Adaptation_Font*0.5)];
    [self addSubview:scrollView];
    
    UIImage *imageLoop = [UIImage imageNamed:@"looper_bk.png"];
    UIImageView *looperImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -71*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    looperImage.image = imageLoop;
    
    UILabel *looperName = [LooperToolClass createLableView:CGPointMake(96*DEF_Adaptation_Font_x*0.5, 232*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(448*DEF_Adaptation_Font_x*0.5, 45*DEF_Adaptation_Font_x*0.5) andText:[looper objectForKey:@"LoopName"] andFontSize:18 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [looperImage addSubview:looperName];
    
    UIImageView *ownerImage = [LooperToolClass createImageView:@"icon_looperOwner_.png" andRect:CGPointMake(39, 416) andTag:100 andSize:CGSizeMake(125, 32) andIsRadius:false];
    [looperImage addSubview:ownerImage];
    
    UIImageView *person = [LooperToolClass createImageView:@"icon_player_looperDetail.png" andRect:CGPointMake(568, 410) andTag:100 andSize:CGSizeMake(32, 36) andIsRadius:false];
    [looperImage addSubview:person];

    UIImageView *line = [LooperToolClass createImageView:@"line_looperDetail.png" andRect:CGPointMake(0, 474) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 1) andIsRadius:false];
    [looperImage addSubview:line];
    
    UIImageView *about = [LooperToolClass createImageView:@"icon_about_looperDetail.png" andRect:CGPointMake(39, 528) andTag:100 andSize:CGSizeMake(125*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
    [looperImage addSubview:about];

    UILabel *looperNum = [LooperToolClass createLableView:CGPointMake(472*DEF_Adaptation_Font_x*0.5, 419*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(87*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font_x*0.5) andText:[NSString stringWithFormat:@"%d",[[looper objectForKey:@"UserCount"] intValue]] andFontSize:15 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentRight];
    [looperImage addSubview:looperNum];
    
    UILabel *looperOwner = [LooperToolClass createLableView:CGPointMake(154*DEF_Adaptation_Font_x*0.5, 414*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(290*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font_x*0.5) andText:[looper objectForKey:@"OwnerName"] andFontSize:14 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [looperImage addSubview:looperOwner];

    
    if([looper objectForKey:@"LoopType"]!=[NSNull null]){
        UIImageView *type1 = [LooperToolClass createBtnImage:[looper objectForKey:@"LoopType"] andRect:CGPointMake(264, 320) andTag:100 andSize:CGSizeMake(112, 46) andTarget:self];
        [looperImage addSubview:type1];
    }
    
    UILabel *looperContent = [LooperToolClass createLableView:CGPointMake(40*DEF_Adaptation_Font_x*0.5, 604*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(559*DEF_Adaptation_Font_x*0.5, 171*DEF_Adaptation_Font_x*0.5) andText:[looper objectForKey:@"LoopDescription"] andFontSize:15 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    looperContent.numberOfLines = 0;
    [looperContent sizeToFit];
    [looperImage addSubview:looperContent];

    [scrollView addSubview:looperImage];

}

-(void)createBk{
    UIView *bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk setBackgroundColor:[UIColor colorWithRed:24/255.0 green:24/255.0 blue:28/255.0 alpha:1.0]];
    [self addSubview:bk];
    
    
    if([[looper objectForKey:@"OwnerID"] intValue]==-1)
    {
        UIImage *imageLoop = [UIImage imageNamed:@"looper_detail.png"];
        UIImageView *looperImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_WIDTH)];
        looperImage.image = imageLoop;
        [self addSubview:looperImage];
    }else{
    
        UIImageView *looperImage = [LooperToolClass createBtnImage:[looper objectForKey:@"LoopImage"] andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH/0.5/DEF_Adaptation_Font, DEF_SCREEN_WIDTH/0.5/DEF_Adaptation_Font) andTarget:self];
        [self addSubview:looperImage];
    }
  
    
   }

- (void)dealloc
{
    [scrollView removeTwitterCoverView];
}


-(void)createHudView{
  

    UIButton *backBtn = [LooperToolClass createBtnImageName:@"icon_back_looperDetail.png" andRect:CGPointMake(24, 61) andTag:500 andSelectImage:@"icon_back_looperDetail.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageName:@"btn_share_looperDetail.png" andRect:CGPointMake(575, 66) andTag:501 andSelectImage:@"btn_share_looperDetail.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:shareBtn];

}


-(void)initViewData:(NSDictionary*)looperData{
    looper =looperData;
    
    [self createBk];
    [self createScrollView];
     [self createHudView];
   
    
    

}

@end
