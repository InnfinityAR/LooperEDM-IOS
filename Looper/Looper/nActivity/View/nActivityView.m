//
//  nActivityView.m
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nActivityView.h"
#import "nActivityViewModel.h"
#import "LooperToolClass.h"
#include "LooperConfig.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"

@implementation nActivityView{

    UIImageView *backImageV;
    
    
    NSMutableArray *allActivityArray;
    
    NSMutableArray *recommendArray;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
       
        [self requestData];
        
    }
    return self;
   
    
}

-(void)requestData{
    allActivityArray = [[NSMutableArray alloc] initWithCapacity:50];
    recommendArray = [[NSMutableArray alloc] initWithCapacity:50];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformation" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            for (int i=0;i<[responseObject[@"data"] count];i++){
                NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[responseObject[@"data"] objectAtIndex:i]];
                if([[dic objectForKey:@"recommendation"] intValue]==1){
                    [recommendArray addObject:dic];
                }
                [allActivityArray addObject:dic];
            }
             [self initView];
        }else{
            
            
        }
    }fail:^{
        
    }];
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        
        
        
    
    }else if(button.tag==102){
    
    
    
    }else if(button.tag==103){
        
        
        
    }
}


-(void)createBkView{
    backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [self addSubview:backImageV];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT);
    effectView.alpha=0.7f;
    [self addSubview:effectView];
}



-(void)createHudView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,32*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];
    
    UIButton *AllActivityBtn = [LooperToolClass createBtnImageNameReal:@"btn_allActivity.png" andRect:CGPointMake(480*DEF_Adaptation_Font*0.5,1013*DEF_Adaptation_Font*0.5) andTag:103 andSelectImage:@"btn_allActivity.png" andClickImage:@"btn_allActivity.png" andTextStr:nil andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5,123*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:AllActivityBtn];
    
    UIButton * tripBtn = [LooperToolClass createBtnImageNameReal:@"un_trip.png" andRect:CGPointMake(349*DEF_Adaptation_Font*0.5,991*DEF_Adaptation_Font*0.5) andTag:103 andSelectImage:@"trip.png" andClickImage:@"trip.png" andTextStr:nil andSize:CGSizeMake(78*DEF_Adaptation_Font*0.5,72*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:tripBtn];
    
    UIButton *activityFollowBtn = [LooperToolClass createBtnImageNameReal:@"activity_unfollow.png" andRect:CGPointMake(195*DEF_Adaptation_Font*0.5,991*DEF_Adaptation_Font*0.5) andTag:103 andSelectImage:@"activity_follow.png" andClickImage:@"activity_follow.png" andTextStr:nil andSize:CGSizeMake(78*DEF_Adaptation_Font*0.5,72*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:activityFollowBtn];

}


-(void)initView{
    [self createBkView];
    [self createHudView];



}


@end
