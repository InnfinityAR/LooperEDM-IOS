//
//  MallMainView.m
//  Looper
//
//  Created by lujiawei on 07/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MallMainView.h"
#import "MallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@implementation MallMainView{
    
    
    NSDictionary *MallData;
    UIScrollView *mallScrollV;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (MallViewModel*)idObject;
        [self initView];
    }
    return self;
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag ==100){
        [_obj popViewMallController];
    }
}

-(void)updateDataView:(NSDictionary*)sourceData{
    
    MallData = sourceData;
    
    [_obj createPropDetailView:[[sourceData objectForKey:@"data"] objectAtIndex:1]];
    
    [self createHudView];
}

-(void)createScrollView{
  
    mallScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    mallScrollV.showsVerticalScrollIndicator = NO;
    mallScrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:mallScrollV];
    
    
    [self addScrollViewTitle];
    
}

-(void)addScrollViewTitle{

    UILabel *titleName=[[UILabel alloc]initWithFrame:CGRectMake(279*DEF_Adaptation_Font*0.5, 66*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    titleName.font=[UIFont systemFontOfSize:11];
    titleName.textColor=[UIColor whiteColor];
    titleName.text=@"礼品中心";
    [mallScrollV addSubview:titleName];
    
    UIImageView *integrate_icon = [LooperToolClass createImageView:@"icon_integrate_min.png" andRect:CGPointMake(46, 145) andTag:100 andSize:CGSizeMake(24, 27) andIsRadius:false];
    [mallScrollV addSubview:integrate_icon];
    
    
    UILabel *integrateLable=[[UILabel alloc]initWithFrame:CGRectMake(85*DEF_Adaptation_Font*0.5, 144*DEF_Adaptation_Font*0.5, 330*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    integrateLable.font=[UIFont systemFontOfSize:14];
    integrateLable.textColor=[UIColor colorWithRed:138/255.0 green:137/255.0 blue:247/255.0 alpha:1.0];
    integrateLable.text=@"100积分";
    [integrateLable sizeToFit];
    [mallScrollV addSubview:integrateLable];
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"icon_checkDetail.png" andRect:CGPointMake(integrateLable.frame.origin.x+integrateLable.frame.size.width+10*DEF_Adaptation_Font*0.5,150*DEF_Adaptation_Font*0.5) andTag:200 andSelectImage:@"icon_checkDetail.png" andClickImage:@"icon_checkDetail.png" andTextStr:nil andSize:CGSizeMake(10*DEF_Adaptation_Font*0.5,19*DEF_Adaptation_Font*0.5) andTarget:self];
    [mallScrollV addSubview:backBtn];
    
    UIButton *checkInBtn = [LooperToolClass createBtnImageNameReal:@"btn_checkin.png" andRect:CGPointMake(457*DEF_Adaptation_Font*0.5,137*DEF_Adaptation_Font*0.5) andTag:201 andSelectImage:@"btn_checkin.png" andClickImage:@"btn_checkin.png" andTextStr:nil andSize:CGSizeMake(137*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTarget:self];
    [mallScrollV addSubview:checkInBtn];
    
    
}


-(void)createHudView{
    
   
    
    
}


-(void)initView{
    
    [self createScrollView];
    
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    [self setBackgroundColor:[UIColor colorWithRed:39/255.0 green:39/255.0 blue:72/255.0 alpha:1.0]];
    
    
}


@end
