//
//  MemberSelectView.m
//  Looper
//
//  Created by 工作 on 2017/9/11.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "MemberDeleteView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
@interface MemberDeleteView()
@property(nonatomic,strong)NSString *contenStr;
@property(nonatomic,strong)NSString *btnName;
@property (nonatomic, strong, nullable) ButtonBlock block;  
@end
@implementation MemberDeleteView

-(instancetype)initWithContentStr:(NSString *)contentStr andBtnName:(NSString *)btnName{
    if (self=[super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.contenStr=contentStr;
        self.btnName=btnName;
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor=ColorRGB(0, 0, 0, 0.4);
    UIImageView *backIV=[[UIImageView alloc]initWithFrame:CGRectMake(91*DEF_Adaptation_Font*0.5, 343*DEF_Adaptation_Font*0.5, 460*DEF_Adaptation_Font*0.5, 268*DEF_Adaptation_Font*0.5)];
    backIV.image=[UIImage imageNamed:@"BK_family_bottom.png"];
    backIV.userInteractionEnabled=YES;
    [self addSubview:backIV];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(24*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 412*DEF_Adaptation_Font*0.5, 124*DEF_Adaptation_Font*0.5)];
        contentLB.text=self.contenStr;
    contentLB.textColor=[UIColor whiteColor];
    CGSize lblSize3 = [contentLB.text boundingRectWithSize:CGSizeMake(412*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGRect frame3=contentLB.frame;
    frame3.size=lblSize3;
    contentLB.frame=frame3;
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:16];
    [backIV addSubview:contentLB];
    if (self.btnName==nil) {
        UIButton *sureBtn=[[UIButton alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2-83*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5, 166*DEF_Adaptation_Font*0.5, 46*DEF_Adaptation_Font*0.5)];
        sureBtn.backgroundColor=ColorRGB(110, 192, 225, 1.0);
        [sureBtn setTitle:@"选择" forState:(UIControlStateNormal)];
        sureBtn.layer.cornerRadius=23*DEF_Adaptation_Font*0.5;
        sureBtn.layer.masksToBounds=YES;
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [sureBtn setTintColor:[UIColor whiteColor]];
        [sureBtn addTarget:self action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [backIV addSubview:sureBtn];
    }else{
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(24*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5, 166*DEF_Adaptation_Font*0.5, 46*DEF_Adaptation_Font*0.5)];
    cancelBtn.backgroundColor=ColorRGB(110, 192, 225, 1.0);
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    cancelBtn.layer.cornerRadius=23*DEF_Adaptation_Font*0.5;
    cancelBtn.layer.masksToBounds=YES;
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [cancelBtn setTintColor:[UIColor whiteColor]];
    [cancelBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [backIV addSubview:cancelBtn];
    UIButton *sureBtn=[[UIButton alloc]initWithFrame:CGRectMake(270*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5, 166*DEF_Adaptation_Font*0.5, 46*DEF_Adaptation_Font*0.5)];
    sureBtn.backgroundColor=ColorRGB(110, 192, 225, 1.0);
    [sureBtn setTitle:self.btnName forState:(UIControlStateNormal)];
    sureBtn.layer.cornerRadius=23*DEF_Adaptation_Font*0.5;
    sureBtn.layer.masksToBounds=YES;
    sureBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [sureBtn setTintColor:[UIColor whiteColor]];
    [sureBtn addTarget:self action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [backIV addSubview:sureBtn];
    }
}
-(void)addAction{
       [self removeFromSuperview];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    if (self.block) {
        self.block(self);
    }
}
//实现block回调的方法
- (void)addButtonAction:(ButtonBlock)block {
    self.block = block;
}
@end
