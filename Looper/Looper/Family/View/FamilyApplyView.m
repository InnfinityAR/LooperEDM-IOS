//
//  FamilyApplyView.m
//  Looper
//
//  Created by 工作 on 2017/9/2.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyApplyView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
@interface FamilyApplyView()
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation FamilyApplyView

-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary *)dataDic{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataDic=dataDic;
        [self initView];
        [self initBackView];
    }
    return self;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        [self.obj getApplyFamilyDataForRfId:[self.dataDic objectForKey:@"raverid"]];
    }
}
-(void)initBackView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
}
-(void)initView{
    [self setBackgroundColor:ColorRGB(0, 0, 0, 0.4)];
    UIImageView *contentView=[[UIImageView alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 343*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-180*DEF_Adaptation_Font*0.5, 295*DEF_Adaptation_Font*0.5)];
    contentView.userInteractionEnabled=YES;
    contentView.image=[UIImage imageNamed:@"family_apply_back.png"];
    [self addSubview:contentView];
    UIImageView*headView=[[UIImageView alloc]initWithFrame:CGRectMake(234*DEF_Adaptation_Font*0.5, 217*DEF_Adaptation_Font*0.5, 167*DEF_Adaptation_Font*0.5, 167*DEF_Adaptation_Font*0.5)];
    [headView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"images"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    headView.layer.cornerRadius=83*DEF_Adaptation_Font*0.5;
    headView.layer.masksToBounds=YES;
    headView.layer.borderColor=[ColorRGB(193, 158, 252, 1.0)CGColor];
    headView.layer.borderWidth=6*DEF_Adaptation_Font*0.5;
    [self addSubview:headView];
    
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(20, 60*DEF_Adaptation_Font*0.5, DEF_WIDTH(contentView)-40, 40*DEF_Adaptation_Font*0.5)];
    nameLB.textAlignment=NSTextAlignmentCenter;
    nameLB.textColor=[UIColor whiteColor];
    nameLB.font=[UIFont boldSystemFontOfSize:18];
    nameLB.text=[NSString stringWithFormat:@"%@家族",[self.dataDic objectForKey:@"ravername"]];
    [contentView addSubview:nameLB];
    
    UILabel *declarationLB=[[UILabel alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 113*DEF_Adaptation_Font*0.5, DEF_WIDTH(contentView)-40*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    declarationLB.textColor=[UIColor whiteColor];
    declarationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16.f];
    declarationLB.textAlignment=NSTextAlignmentCenter;
    declarationLB.numberOfLines=2;
    declarationLB.text=@"每一个残暴的君主都能懂得怜悯；每一个失落的灵魂中都有创造奇迹的傲骨";
    [contentView addSubview:declarationLB];
    UIButton *saveBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(DEF_WIDTH(contentView)/2-110*DEF_Adaptation_Font*0.5, 220*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(220*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    [saveBtn setTitle:@"申请加入" forState:(UIControlStateNormal)];
    saveBtn.titleLabel.font =  [UIFont boldSystemFontOfSize:14];
    saveBtn.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    saveBtn.layer.borderWidth=1.0;
    saveBtn.layer.borderColor=[[UIColor whiteColor]CGColor];;
    saveBtn.layer.masksToBounds=YES;
    [saveBtn setTintColor:[UIColor whiteColor]];
    [contentView addSubview:saveBtn];

    UIButton *selectBtn=[LooperToolClass createBtnImageNameReal:@"family_apply_select.png" andRect:CGPointMake(DEF_WIDTH(contentView)+(90-25)*DEF_Adaptation_Font*0.5, (343-25)*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"family_apply_select.png" andClickImage:@"family_apply_select.png" andTextStr:nil andSize:CGSizeMake(50*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:selectBtn];

    
}

@end
