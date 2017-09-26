//
//  SelectCityView.m
//  Looper
//
//  Created by 工作 on 2017/9/26.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SelectCityView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
@interface SelectCityView()
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation SelectCityView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDetailDic:(NSDictionary*)detailDic{
    if (self=[super initWithFrame:frame]) {
        self.obj=idObject;
        self.dataDic=detailDic;
        [self initView];
        [self initBackView];
    }
    
    return self;
}
-(void)initView{
    self.backgroundColor=ColorRGB(25, 24, 62, 1.0);
    UILabel *currentLB=[[UILabel alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    currentLB.text=@"当前城市";
    currentLB.textColor=[UIColor whiteColor];
    currentLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [self addSubview:currentLB];
}
-(void)initBackView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=  button.tag;
    if (tag==101) {
        [self removeFromSuperview];
    }
    
}
@end
