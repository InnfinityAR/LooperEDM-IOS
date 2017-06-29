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
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"
#import "PGIndexBannerSubiew.h"
#import "NewPagedFlowView.h"



@implementation nActivityView {
    
    UIImageView *backImageV;
    
    NSArray *_commendArray;
    
    UIButton * tripBtn;
    UIButton *activityFollowBtn;
    
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


-(int)getContentLength:(NSString*)contentStr{
    
    float num_x =0;
    NSString *perchar;
    int alength = [contentStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [contentStr characterAtIndex:i];
        NSString *temp = [contentStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            num_x = num_x+26*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>64)&&(commitChar<91)){
            num_x = num_x +19*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>96)&&(commitChar<123)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>47)&&(commitChar<58)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else{
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }
    }
    return num_x;
}



- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, 515*DEF_Adaptation_Font*0.5,855*DEF_Adaptation_Font*0.5)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    for (UIView *view in [bannerView subviews]){
        
        [view removeFromSuperview];
    }
    
    
    UIImageView *bannerView1=[LooperToolClass createImageViewReal:@"locaton.png" andRect:CGPointMake(0,45*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(515*DEF_Adaptation_Font*0.5, 804*DEF_Adaptation_Font*0.5) andIsRadius:false];
   
    
    [bannerView1  sd_setImageWithURL:[[NSURL alloc] initWithString:[[_commendArray objectAtIndex:index]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        bannerView1.layer.cornerRadius = 20*DEF_Adaptation_Font*0.5;
        bannerView1.layer.masksToBounds = YES;

        
    }];
    [bannerView addSubview:bannerView1];
    
    
    UIImageView *masking = [[UIImageView alloc] initWithFrame:CGRectMake(-2*DEF_Adaptation_Font*0.5, 45*DEF_Adaptation_Font*0.5, 519*DEF_Adaptation_Font*0.5,804*DEF_Adaptation_Font*0.5)];
    masking.image =[UIImage imageNamed:@"masking.png"];
    masking.layer.cornerRadius = 20*DEF_Adaptation_Font*0.5;
    masking.layer.masksToBounds = YES;
    [bannerView1 addSubview:masking];
    
 
    UILabel* titleStr = [LooperToolClass createLableView:CGPointMake(24*DEF_Adaptation_Font_x*0.5, 552*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(435*DEF_Adaptation_Font_x*0.5, 79*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"activityname"] andFontSize:16 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [bannerView addSubview:titleStr];
    titleStr.numberOfLines=0;
    [titleStr sizeToFit];
    
    UIImageView *location=[LooperToolClass createImageViewReal:@"locaton.png" andRect:CGPointMake(21*DEF_Adaptation_Font_x*0.5,695*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(31*DEF_Adaptation_Font_x*0.5, 31*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
    [bannerView addSubview:location];
    
    UILabel* locationStr = [LooperToolClass createLableView:CGPointMake(62*DEF_Adaptation_Font_x*0.5, 695*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(370*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"location"] andFontSize:12 andColor:[UIColor colorWithRed:223/255.0 green:219/255.0 blue:234/255.0 alpha:1.0]  andType:NSTextAlignmentLeft];
    [bannerView addSubview:locationStr];
    [locationStr sizeToFit];
    
    
    UIImageView *ticket_icon =[LooperToolClass createImageViewReal:@"icon_ticket2.png" andRect:CGPointMake(21*DEF_Adaptation_Font_x*0.5,735 *DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(31*DEF_Adaptation_Font_x*0.5, 31*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
    [bannerView addSubview:ticket_icon];

    UILabel* ticketStr = [LooperToolClass createLableView:CGPointMake(62*DEF_Adaptation_Font_x*0.5, 735*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(370*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"price"] andFontSize:12 andColor:[UIColor colorWithRed:223/255.0 green:219/255.0 blue:234/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [bannerView addSubview:ticketStr];
    [ticketStr sizeToFit];

    UIImageView *time=[LooperToolClass createImageViewReal:@"time.png" andRect:CGPointMake(21*DEF_Adaptation_Font_x*0.5,653*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(31*DEF_Adaptation_Font_x*0.5, 31*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
    
    [bannerView addSubview:time];
    
    UILabel* TimeStr = [LooperToolClass createLableView:CGPointMake(62*DEF_Adaptation_Font_x*0.5, 653*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(370*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"timetag"] andFontSize:12 andColor:[UIColor colorWithRed:223/255.0 green:219/255.0 blue:234/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [bannerView addSubview:TimeStr];
     [TimeStr sizeToFit];
    
    UILabel* tagStr = [LooperToolClass createLableView:CGPointMake(24*DEF_Adaptation_Font_x*0.5, 560*DEF_Adaptation_Font*0.5+30*DEF_Adaptation_Font*0.5) andSize:CGSizeMake([self getContentLength:[[_commendArray objectAtIndex:index]objectForKey:@"tag"]]+15*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_commendArray objectAtIndex:index]objectForKey:@"tag"] andFontSize:9 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [bannerView addSubview:tagStr];
    [tagStr setBackgroundColor:[UIColor colorWithRed:92/255.0 green:118/255.0 blue:148/255.0 alpha:1.0]];
    tagStr.layer.cornerRadius = 28*DEF_Adaptation_Font*0.5/2;
    tagStr.layer.masksToBounds = YES;
    
    UILabel* followStr = [LooperToolClass createLableView:CGPointMake(0*DEF_Adaptation_Font_x*0.5, 114*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(139*DEF_Adaptation_Font_x*0.5, 41*DEF_Adaptation_Font_x*0.5) andText:[NSString stringWithFormat:@"   %@人 参加",[[_commendArray objectAtIndex:index]objectForKey:@"followcount"]] andFontSize:10 andColor:[UIColor colorWithRed:146/255.0 green:177/255.0 blue:178/255.0 alpha:0.9] andType:NSTextAlignmentLeft];
    [bannerView addSubview:followStr];
    [followStr setBackgroundColor:[UIColor blackColor]];
    
    
//    UIView *cirle = [[UIView alloc] initWithFrame:CGRectMake(170*DEF_Adaptation_Font*0.5, 65*DEF_Adaptation_Font_x*0.5, 50*DEF_Adaptation_Font*0.5,  50*DEF_Adaptation_Font*0.5)];
//    [cirle setBackgroundColor:[UIColor colorWithRed:110/255.0 green:212/255.0 blue:187/255.0 alpha:1.0]];
//    cirle.layer.cornerRadius = 50*DEF_Adaptation_Font*0.5/2;
//    cirle.layer.masksToBounds = YES;
//    [bannerView addSubview:cirle];
    
    UILabel* cityStr = [LooperToolClass createLableView:CGPointMake(-18*DEF_Adaptation_Font_x*0.5, 65*DEF_Adaptation_Font_x*0.5+45*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(230*DEF_Adaptation_Font_x*0.5, 50*DEF_Adaptation_Font_x*0.5) andText:[NSString stringWithFormat:@"    %@",[[_commendArray objectAtIndex:index]objectForKey:@"city"]] andFontSize:11 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [bannerView addSubview:cityStr];
    cityStr.shadowColor =[UIColor colorWithRed:25/255.0 green:91/255.0 blue:70/255.0 alpha:0.66];    //设置文本的阴影色彩和透明度。
    cityStr.shadowOffset = CGSizeMake(0.5f, 1.5f);

    [cityStr setBackgroundColor:[UIColor colorWithRed:110/255.0 green:212/255.0 blue:187/255.0 alpha:1.0]];
    cityStr.layer.cornerRadius = 50*DEF_Adaptation_Font*0.5/2;
    cityStr.layer.masksToBounds = YES;
    
    UIImageView *pro_logo=[LooperToolClass createImageViewReal:@"product_logo.png" andRect:CGPointMake(0*DEF_Adaptation_Font_x*0.5,0*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(488*DEF_Adaptation_Font_x*0.5, 90*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
    [bannerView addSubview:pro_logo];
    
    

    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    
    pageIndex = pageNumber;
    
    [self setBtnStatus];
    
    [self updateBackImage:pageNumber];
    
}

-(void)setBtnStatus{
    
    NSDictionary *dic =[_commendArray objectAtIndex:pageIndex];
    

    if([[dic objectForKey:@"isfollow"] intValue]==1){
        [activityFollowBtn setSelected:true];
    }else{
        [activityFollowBtn setSelected:false];
    }
    
    
    if([[dic objectForKey:@"issave"] intValue]==1){
        [tripBtn setSelected:true];
    }else{
        [tripBtn setSelected:false];
    }
}


-(void)updateBackImage:(int)page{
    [backImageV sd_setImageWithURL:[[NSURL alloc] initWithString:[[_commendArray objectAtIndex:page]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}



- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(515*DEF_Adaptation_Font*0.5, 855*DEF_Adaptation_Font*0.5);
}


- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    [_obj addActivityDetailView:[_commendArray objectAtIndex:pageIndex]];
}


- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    NSLog(@"在这里打印:%@",_commendArray);
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
        //[self animation];
        [_obj jumpToCurrentActivity:_commendArray];
    }else if(button.tag==104){
        NSDictionary *dic =[_commendArray objectAtIndex:pageIndex];

        if([[dic objectForKey:@"issave"] intValue]==1){
              [tripBtn setSelected:false];
            [_obj addInformationToFollow:[dic objectForKey:@"activityid"] andisLike:@"0"];
        }else{
            [_obj savaCalendar:[_commendArray objectAtIndex:pageIndex]];
            [_obj addInformationToFollow:[dic objectForKey:@"activityid"] andisLike:@"1"];
            [tripBtn setSelected:true];
        }

    }else if(button.tag==105){
        NSDictionary *dic =[_commendArray objectAtIndex:pageIndex];
        
        if([[dic objectForKey:@"isfollow"] intValue]==1){
            [activityFollowBtn setSelected:false];
            [_obj addInformationToFavorite:[dic objectForKey:@"activityid"] andisLike:@"0"];
        }else{
            [_obj addInformationToFavorite:[dic objectForKey:@"activityid"] andisLike:@"1"];
            [activityFollowBtn setSelected:true];
        }
        
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
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];
    
    UIButton *AllActivityBtn = [LooperToolClass createBtnImageNameReal:@"btn_allActivity.png" andRect:CGPointMake(480*DEF_Adaptation_Font*0.5,1013*DEF_Adaptation_Font*0.5) andTag:103 andSelectImage:@"btn_allActivity.png" andClickImage:@"btn_allActivity.png" andTextStr:nil andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5,123*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:AllActivityBtn];
    
    tripBtn = [LooperToolClass createBtnImageNameReal:@"un_trip.png" andRect:CGPointMake(349*DEF_Adaptation_Font*0.5,991*DEF_Adaptation_Font*0.5) andTag:104 andSelectImage:@"trip.png" andClickImage:@"trip.png" andTextStr:nil andSize:CGSizeMake(78*DEF_Adaptation_Font*0.5,72*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:tripBtn];
    
    activityFollowBtn = [LooperToolClass createBtnImageNameReal:@"activity_unfollow.png" andRect:CGPointMake(195*DEF_Adaptation_Font*0.5,991*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:@"activity_follow.png" andClickImage:@"activity_follow.png" andTextStr:nil andSize:CGSizeMake(78*DEF_Adaptation_Font*0.5,72*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:activityFollowBtn];
    
    
    NSDictionary *dic =[_commendArray objectAtIndex:0];
    
    
    if([[dic objectForKey:@"isfollow"] intValue]==1){
        [activityFollowBtn setSelected:true];
    }else{
        [activityFollowBtn setSelected:false];
    }
    
    
    if([[dic objectForKey:@"issave"] intValue]==1){
        [tripBtn setSelected:true];
    }else{
        [tripBtn setSelected:false];
    }

}


-(void)initView{
    [self createBkView];
    [self createHudView];
    [self createCommendView];
    
  
}


@end
