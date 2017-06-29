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


@implementation DJDetailView{
    
    UIScrollView *scrollV;
    
    
    UIImageView *headImageView;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        [self initView];
        
    }
    return self;
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==101){
        [self removeFromSuperview];
    
    }else if(button.tag==102){
        [_obj shareh5View:nil];
    }
}


-(void)createHudView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];

}

-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    [self createImageView];
    [self createScrollView];
    [self createHudView];
}

-(void)createImageView{
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 200*DEF_Adaptation_Font*0.5)];
    [headImageView setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:headImageView];
}

-(void)createScrollView{
    
    scrollV  =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    scrollV.showsVerticalScrollIndicator = true;
   
    scrollV.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*3);
    
    [self addSubview:scrollV];
    
    [self createHorizontalScroll];
}

-(void)createHorizontalScroll{

    UIScrollView *HorizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  DEF_SCREEN_HEIGHT/2, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2.5)];
    HorizontalScroll.showsHorizontalScrollIndicator = true;
    [HorizontalScroll setBackgroundColor:[UIColor redColor]];
    [HorizontalScroll setPagingEnabled:true];
    HorizontalScroll.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*3, DEF_SCREEN_HEIGHT);
    
    [scrollV addSubview:HorizontalScroll];
}



@end
