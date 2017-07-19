//
//  ActivityCollectionViewCell.m
//  Looper
//
//  Created by 工作 on 2017/7/7.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityCollectionViewCell.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
@implementation ActivityCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius=4.0;
        self.layer.masksToBounds=YES;
        //                    self.shareBtn= [LooperToolClass createBtnImageNameReal:@"btn_looper_share.png" andRect:CGPointMake(self.frame.size.width-5-30*DEF_Adaptation_Font*0.5, self.frame.size.height-5-30*DEF_Adaptation_Font*0.5) andTag:2 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(30*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) andTarget:self];
        //                    [self addSubview:self.shareBtn];
        self.commendBtn= [LooperToolClass createBtnImageNameReal:@"commendNO.png" andRect:CGPointMake(5*DEF_Adaptation_Font*0.5, self.frame.size.height-75*DEF_Adaptation_Font*0.5) andTag:1 andSelectImage:@"commendYES.png" andClickImage:@"commendYES.png" andTextStr:nil andSize:CGSizeMake(65*DEF_Adaptation_Font*0.5, 65*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:self.commendBtn];
        self.commendLB=[[UILabel alloc]initWithFrame:CGRectMake(8+35*DEF_Adaptation_Font*0.5,self.frame.size.height-5-30*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
        self.commendLB.font=[UIFont boldSystemFontOfSize:13];
        self.commendLB.textColor=[UIColor whiteColor];
        [self addSubview:self.commendLB];
        
        self.userImageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
        self.userImageView.layer.cornerRadius =20*DEF_Adaptation_Font*0.5;
        self.userImageView.layer.masksToBounds=YES;
        //加入点击事件
        self.userImageView.userInteractionEnabled=YES;
        [self addSubview:self.userImageView];
        self.userNameLB=[[UILabel alloc]initWithFrame:CGRectMake(70*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-90*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
        self.userNameLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
        self.userNameLB.textColor=[UIColor whiteColor];
        [self addSubview:self.userNameLB];
        
        self.contentLB=[[UILabel alloc]initWithFrame:CGRectMake(5, 50*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)-10), DEF_WIDTH(self) -100*DEF_Adaptation_Font*0.5)];
        self.contentLB.textAlignment=NSTextAlignmentCenter;
         self.contentLB.textColor=[UIColor whiteColor];
        [self addSubview:self.contentLB];
}
    return self;
}
-(void)updateCell{
    CGRect frame1=self.commendBtn.frame;
    frame1=CGRectMake(5*DEF_Adaptation_Font*0.5, self.frame.size.height-75*DEF_Adaptation_Font*0.5,65*DEF_Adaptation_Font*0.5, 65*DEF_Adaptation_Font*0.5);
    self.commendBtn.frame=frame1;
    CGRect frame2=self.commendLB.frame;
    frame2=CGRectMake(8+35*DEF_Adaptation_Font*0.5,self.frame.size.height-5-30*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5);
    self.commendLB.frame=frame2;
    CGRect frame3=self.contentLB.frame;
    frame3=CGRectMake(5, 50*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)-10), DEF_WIDTH(self) -100*DEF_Adaptation_Font*0.5);
    self.contentLB.frame=frame3;
}
-(void)updateContentLBHeight{
    CGRect frame1=self.contentLB.frame;
    frame1=CGRectMake(5, 135*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)-10), DEF_WIDTH(self)-185*DEF_Adaptation_Font*0.5);
    self.contentLB.frame=frame1;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if (button.tag==1) {
        if (self.commendBtnClick) {
            self.commendBtnClick();
        }
    }
    if (button.tag==2) {
        if (self.shareBtnClick) {
            self.shareBtnClick();
        }
    }
}
@end
