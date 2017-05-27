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
#import "UIImageView+WebCache.h"
#import "PGIndexBannerSubiew.h"
#import "NewPagedFlowView.h"





@implementation nActivityView {
    
    UIImageView *backImageV;
    
    NSArray *_commendArray;
    
    int pageIndex;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSArray*)commendArray{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        _commendArray =commendArray;
        
        
        [self initView];
    }
    return self;
    
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, 515*DEF_Adaptation_Font*0.5,804*DEF_Adaptation_Font*0.5)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    for (UIView *view in [bannerView subviews]){
        
        [view removeFromSuperview];
    }
    
    
    UIImageView *bannerView1=[LooperToolClass createImageViewReal:@"locaton.png" andRect:CGPointMake(0,0) andTag:100 andSize:CGSizeMake(515*DEF_Adaptation_Font*0.5, 804*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [bannerView addSubview:bannerView1];
    
    
    [bannerView1  sd_setImageWithURL:[[NSURL alloc] initWithString:[[_commendArray objectAtIndex:index]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

    UILabel* titleStr = [LooperToolClass createLableView:CGPointMake(24*DEF_Adaptation_Font_x*0.5, 552*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(435*DEF_Adaptation_Font_x*0.5, 77*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"activityname"] andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [bannerView addSubview:titleStr];
    [titleStr setBackgroundColor:[UIColor blackColor]];
    titleStr.numberOfLines = 0;
    [titleStr sizeToFit];
    
    
    UIImageView *location=[LooperToolClass createImageViewReal:@"locaton.png" andRect:CGPointMake(21*DEF_Adaptation_Font_x*0.5,705*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(31*DEF_Adaptation_Font_x*0.5, 31*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
    [bannerView addSubview:location];
    
    UILabel* locationStr = [LooperToolClass createLableView:CGPointMake(62*DEF_Adaptation_Font_x*0.5, 705*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(370*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"location"] andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [bannerView addSubview:locationStr];
     [locationStr setBackgroundColor:[UIColor blackColor]];
    [locationStr sizeToFit];
    
    
    UIImageView *time=[LooperToolClass createImageViewReal:@"time.png" andRect:CGPointMake(21*DEF_Adaptation_Font_x*0.5,653*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(31*DEF_Adaptation_Font_x*0.5, 31*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
    [bannerView addSubview:time];
    
    UILabel* TimeStr = [LooperToolClass createLableView:CGPointMake(62*DEF_Adaptation_Font_x*0.5, 653*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(370*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"starttime"] andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [bannerView addSubview:TimeStr];
     [TimeStr setBackgroundColor:[UIColor blackColor]];
     [TimeStr sizeToFit];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    
    pageIndex = pageNumber;
    [self updateBackImage:pageNumber];
    
}

-(void)updateBackImage:(int)page{
    [backImageV sd_setImageWithURL:[[NSURL alloc] initWithString:[[_commendArray objectAtIndex:page]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}



- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(515*DEF_Adaptation_Font*0.5, 804*DEF_Adaptation_Font*0.5);
}


- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
    [_obj addActivityDetailView:[_commendArray objectAtIndex:pageIndex]];
    
    
}


- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return _commendArray.count;
}



-(void)createCommendView{
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0,DEF_SCREEN_WIDTH, 834*DEF_Adaptation_Font*0.5)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = NO;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 88*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, 834*DEF_Adaptation_Font*0.5)];
    [bottomScrollView addSubview:pageFlowView];
    
    [pageFlowView reloadData];
    
    [self addSubview:bottomScrollView];
    
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        
        [_obj popController];
    }else if(button.tag==102){
        
         [_obj shareh5View:[_commendArray objectAtIndex:pageIndex]];
    }else if(button.tag==103){
        
        
    }else if(button.tag==104){
        
        
    }else if(button.tag==105){
        
        
    }
}


-(void)createBkView{
    backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [backImageV sd_setImageWithURL:[[NSURL alloc] initWithString:[[_commendArray objectAtIndex:0]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self addSubview:backImageV];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT);
    effectView.alpha=1.2f;
    [self addSubview:effectView];
}



-(void)createHudView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,32*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];
    
    UIButton *AllActivityBtn = [LooperToolClass createBtnImageNameReal:@"btn_allActivity.png" andRect:CGPointMake(480*DEF_Adaptation_Font*0.5,1013*DEF_Adaptation_Font*0.5) andTag:103 andSelectImage:@"btn_allActivity.png" andClickImage:@"btn_allActivity.png" andTextStr:nil andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5,123*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:AllActivityBtn];
    
    UIButton * tripBtn = [LooperToolClass createBtnImageNameReal:@"un_trip.png" andRect:CGPointMake(349*DEF_Adaptation_Font*0.5,991*DEF_Adaptation_Font*0.5) andTag:104 andSelectImage:@"trip.png" andClickImage:@"trip.png" andTextStr:nil andSize:CGSizeMake(78*DEF_Adaptation_Font*0.5,72*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:tripBtn];
    
    UIButton *activityFollowBtn = [LooperToolClass createBtnImageNameReal:@"activity_unfollow.png" andRect:CGPointMake(195*DEF_Adaptation_Font*0.5,991*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:@"activity_follow.png" andClickImage:@"activity_follow.png" andTextStr:nil andSize:CGSizeMake(78*DEF_Adaptation_Font*0.5,72*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:activityFollowBtn];
    
}


-(void)initView{
    [self createBkView];
    [self createHudView];
    [self createCommendView];
  
}


@end
