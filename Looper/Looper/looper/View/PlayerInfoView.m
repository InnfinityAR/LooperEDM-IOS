//
//  PlayerInfoView.m
//  Looper
//
//  Created by lujiawei on 1/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PlayerInfoView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "looperViewModel.h"
#import "LocalDataMangaer.h"
#import "DataHander.h"
#import "UserInfoViewController.h"
#import "UIImageView+WebCache.h"


@implementation PlayerInfoView{


    UIImageView *imageV;
    UIScrollView *scrv;
    UIPageControl *pageControl;
    NSDictionary * _loopData;
    UIButton *followBtn;
    int _isFollow;
    NSString *userId;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;

    }
    return self;
}

-(void)backV{

    [_obj removePlayerInfo];

}

-(void)backV1{
    


}



-(void)createBackGround:(NSDictionary*)looper{

    UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [self addSubview:bk1];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [btn addTarget:self action:@selector(backV) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(111*DEF_Adaptation_Font_x*0.5,370*DEF_Adaptation_Font_x*0.5,418*DEF_Adaptation_Font_x*0.5,  261*DEF_Adaptation_Font_x*0.5)];
    [btn1 addTarget:self action:@selector(backV1) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn1];
    
    
    
    if([[looper objectForKey:@"sex"]intValue]==1){
    
        imageV = [LooperToolClass createImageView:@"bg_looper_man.png" andRect:CGPointMake(111, 370) andTag:100 andSize:CGSizeMake(418*DEF_Adaptation_Font_x*0.5, 261*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
        [self addSubview:imageV];
    
    }else {
        imageV = [LooperToolClass createImageView:@"bg_looper_woman.png" andRect:CGPointMake(111, 370) andTag:100 andSize:CGSizeMake(418*DEF_Adaptation_Font_x*0.5, 261*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
        [self addSubview:imageV];

        }

}


-(void)toSildeToTab:(NSNotification*)notification{
    
  

}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag==603){
    
        [_obj followUser:userId];
        [followBtn setSelected:true];
    
    }
    else if (button.tag==602){
        [self.obj jumpToAddUserInfoVC:[_loopData objectForKey:@"userid"]];
    
    }
    else if(button.tag==601){
        
        if([[LocalDataMangaer sharedManager].uid isEqualToString:[_loopData objectForKey:@"userid"]]==true){
        
            // [[DataHander sharedDataHander] showViewWithStr:@"" andTime:1 andPos:CGPointZero];
        
        }else{
        
             [_obj pushController:_loopData];
        }
    }

}



-(void)onClickImage{

   //  [_obj pushController:_loopData];

}


-(void)initWithlooperData:(NSDictionary*)looperData andisFollow:(int)isFollow{
    
    _isFollow = isFollow;
    _loopData = looperData;
    userId =[looperData objectForKey:@"userid"];
    [self createBackGround:looperData];
    
    UILabel *nameLable = [LooperToolClass createLableView:CGPointMake(147*DEF_Adaptation_Font_x*0.5, 460*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(346*DEF_Adaptation_Font_x*0.5, 51*DEF_Adaptation_Font_x*0.5) andText:[looperData objectForKey:@"nickname"] andFontSize:18 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:nameLable];
    
    
    UIImageView *imageHead = [[UIImageView alloc] initWithFrame:CGRectMake(252*DEF_Adaptation_Font*0.5, 301*DEF_Adaptation_Font*0.5, 135*DEF_Adaptation_Font*0.5, 135*DEF_Adaptation_Font*0.5)];
    imageHead.layer.cornerRadius =135*DEF_Adaptation_Font*0.5*0.5;
    imageHead.layer.masksToBounds = YES;
    
    [imageHead sd_setImageWithURL:[[NSURL alloc] initWithString:[looperData objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self addSubview:imageHead];
    

    UIButton* chatBtn =[LooperToolClass createBtnImageName:@"btn_user_chat.png" andRect:CGPointMake(207, 543) andTag:601 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:chatBtn];
    

    followBtn =[LooperToolClass createBtnImageName:@"followUser.png" andRect:CGPointMake(458,381) andTag:603 andSelectImage:@"followedUser.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:followBtn];
    
    if(_isFollow==1){
        [followBtn setSelected:true];
    }
    UIButton* homeBtn =[LooperToolClass createBtnImageName:@"btn_user_home.png" andRect:CGPointMake(130,390) andTag:602 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:homeBtn];
    
    

    if([[LocalDataMangaer sharedManager].uid isEqualToString:[_loopData objectForKey:@"userid"]]==true){

        [chatBtn setHidden:true];
        [followBtn setHidden:true];
        
    }

    
    

}




@end
