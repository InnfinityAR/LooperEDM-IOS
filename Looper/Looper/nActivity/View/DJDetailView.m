//
//  DJDetailView.m
//  Looper
//
//  Created by lujiawei on 27/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "DJDetailView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "nActivityViewModel.h"
#import "UIImageView+WebCache.h"



@implementation DJDetailView{
    
    UIScrollView *scrollV;
    
    
    UIImageView *headImageView;
    
    NSDictionary *_djData;
    
    UIView *selectView;
    
    UIButton *activeBtn;
    
    UIButton *detailBtn;

    UIScrollView *HorizontalScroll;
    
    
    float ScrollNum_y;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSDictionary*)djData{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        
        [self initView:djData];
        
    }
    return self;
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==101){
        [self removeFromSuperview];
    
    }else if(button.tag==102){
        [_obj shareh5View:nil];
    }else if(button.tag==104){
        [detailBtn setSelected:false];
        [activeBtn setSelected:true];
        [UIView animateWithDuration:0.3 animations:^{
            [HorizontalScroll setContentOffset:CGPointMake(0, HorizontalScroll.contentOffset.y) animated:true];
        }];
    }else if(button.tag==105){
        [activeBtn setSelected:false];
        [detailBtn setSelected:true];
        [UIView animateWithDuration:0.3 animations:^{
            [HorizontalScroll setContentOffset:CGPointMake(DEF_SCREEN_WIDTH, HorizontalScroll.contentOffset.y) animated:true];
        }];
    }
}


-(void)createHudView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];

}

-(void)initView:(NSDictionary*)data{
    _djData = data;
    [self setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    [self createImageViewHud];
    [self createScrollView];
    [self createHudView];
}

-(void)createImageViewHud{
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 490*DEF_Adaptation_Font*0.5)];
    [headImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[[_djData objectForKey:@"data"]objectForKey:@"avatar"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [self addSubview:headImageView];
    
    UILabel *songer = [[UILabel alloc] initWithFrame:CGRectMake(219*DEF_Adaptation_Font*0.5, 323*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    songer.text=[[_djData objectForKey:@"data"]objectForKey:@"djname"];
    [songer setTextColor:[UIColor whiteColor]];
    [songer setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:songer];
    
    UIImageView *icon_songer = [[UIImageView alloc] initWithFrame:CGRectMake(224*DEF_Adaptation_Font*0.5, 270*DEF_Adaptation_Font*0.5, 101*DEF_Adaptation_Font*0.5, 55*DEF_Adaptation_Font*0.5)];
    [icon_songer setImage:[UIImage imageNamed:@"icon_songer.png"]];
    
    [self addSubview:icon_songer];
    
    
    
}

-(void)createScrollView{
    
    scrollV  =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 113*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-113*DEF_Adaptation_Font*0.5)];
    scrollV.showsVerticalScrollIndicator = true;
    scrollV.delegate=self;
    scrollV.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*3);
    
    [self addSubview:scrollV];
    scrollV.tag=100;
    
    [self createHorizontalScroll];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //做一些滑动完成后的操作
    
    if(scrollView.tag==101){
        
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        if(page==1){
            [detailBtn setSelected:true];
            [activeBtn setSelected:false];
        }else if(page==0){
            [detailBtn setSelected:false];
            [activeBtn setSelected:true];
        }
    }else {
        
        
        
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    NSLog(@"%f",yOffset);
    
    if(scrollView.tag==100){
        CGFloat y= scrollView.contentOffset.y;
        
        CGRect imgViewF =headImageView.frame;
        
        CGPoint offset = scrollView.contentOffset;
        if (offset.y < 0) {
            CGRect rect = headImageView.frame;
            rect.origin.y =offset.y;
            rect.origin.x =offset.y;
            rect.size.height = 490*DEF_Adaptation_Font*0.5 - offset.y*2;
            rect.size.width = DEF_SCREEN_WIDTH - offset.y*2;
            headImageView.frame = rect;
        }
        
        ScrollNum_y =yOffset;
    }
}


-(void)createHorizontalScroll{
    
    
    selectView= [[UIView alloc] initWithFrame:CGRectMake(0, 490*DEF_Adaptation_Font*0.5-113*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 113*DEF_Adaptation_Font*0.5)];
    
    [selectView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    
    activeBtn = [LooperToolClass createBtnImageNameReal:@"btn_unActive1.png" andRect:CGPointMake(202*DEF_Adaptation_Font*0.5,14*DEF_Adaptation_Font*0.5) andTag:104 andSelectImage:@"btn_Active1.png" andClickImage:@"btn_Active1.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5,41*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectView addSubview:activeBtn];
    
    [activeBtn setSelected:true];
    
    detailBtn = [LooperToolClass createBtnImageNameReal:@"btn_unDetail.png" andRect:CGPointMake(390*DEF_Adaptation_Font*0.5, 14*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:@"btn_Detail.png" andClickImage:@"btn_Detail.png" andTextStr:nil andSize:CGSizeMake(71*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectView addSubview:detailBtn];
    
    [scrollV addSubview:selectView];
    
    HorizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,490*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2.5)];
    HorizontalScroll.showsHorizontalScrollIndicator = true;
    [HorizontalScroll setPagingEnabled:true];
    HorizontalScroll.delegate=self;
    HorizontalScroll.tag=101;
    
    [HorizontalScroll setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    HorizontalScroll.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*2, DEF_SCREEN_HEIGHT);
    
    [scrollV addSubview:HorizontalScroll];
    [self createScrollDataView];
    
}


-(void)createScrollDataView{
    
    UILabel *djName =[[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH+33*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 583*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    [djName setTextColor:[UIColor whiteColor]];
    djName.text =   [NSString stringWithFormat:@"%@ 简介",[[_djData objectForKey:@"data"]objectForKey:@"djname"]];
    [HorizontalScroll addSubview:djName];
    
    UILabel *djDetail =[[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH+33*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5, 583*DEF_Adaptation_Font*0.5, 450*DEF_Adaptation_Font*0.5)];
    djDetail.numberOfLines=0;
    [djDetail setTextColor:[UIColor whiteColor]];
    djDetail.text = [[_djData objectForKey:@"data"]objectForKey:@"djdes"];
    [HorizontalScroll addSubview:djDetail];
    [djDetail sizeToFit];

}




@end
