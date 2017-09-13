//
//  creatPopWindowV.m
//  Looper
//
//  Created by 工作 on 2017/9/11.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "creatPopWindowV.h"
#import "LooperConfig.h"
@interface creatPopWindowV()

@end
@implementation creatPopWindowV

+(UIView *)initWithContentLB:(NSString *)contentStr andTarget:(id)obj andTag:(int)tag{
    UIView *view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=ColorRGB(0, 0, 0, 0.4);
    UIImageView *bottomIV= [[UIImageView alloc] initWithFrame:CGRectMake(91*DEF_Adaptation_Font*0.5, 343*DEF_Adaptation_Font*0.5, 460*DEF_Adaptation_Font*0.5, 268*DEF_Adaptation_Font*0.5)];
    bottomIV.image=[UIImage imageNamed:@"BK_family_bottom.png"];
    bottomIV.userInteractionEnabled=YES;
    [view addSubview:bottomIV];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(24*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 412*DEF_Adaptation_Font*0.5, 124*DEF_Adaptation_Font*0.5)];
    contentLB.text=contentStr;
    contentLB.textColor=[UIColor whiteColor];
    CGSize lblSize3 = [contentLB.text boundingRectWithSize:CGSizeMake(412*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGRect frame3=contentLB.frame;
    frame3.size=lblSize3;
    contentLB.frame=frame3;
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:16];
    [bottomIV addSubview:contentLB];
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(24*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5, 166*DEF_Adaptation_Font*0.5, 46*DEF_Adaptation_Font*0.5)];
    cancelBtn.backgroundColor=ColorRGB(110, 192, 225, 1.0);
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    cancelBtn.layer.cornerRadius=23*DEF_Adaptation_Font*0.5;
    cancelBtn.layer.masksToBounds=YES;
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [cancelBtn setTintColor:[UIColor whiteColor]];
    [cancelBtn addTarget:obj action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        if([obj respondsToSelector:@selector(btnOnClick:withEvent:)]){
            [view removeFromSuperview];
            NSLog(@"++++++++++++");
        }
    [bottomIV addSubview:cancelBtn];
    UIButton *sureBtn=[[UIButton alloc]initWithFrame:CGRectMake(270*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5, 166*DEF_Adaptation_Font*0.5, 46*DEF_Adaptation_Font*0.5)];
    sureBtn.backgroundColor=ColorRGB(110, 192, 225, 1.0);
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    sureBtn.layer.cornerRadius=23*DEF_Adaptation_Font*0.5;
    sureBtn.layer.masksToBounds=YES;
    sureBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    sureBtn.tag=tag;
    [sureBtn setTintColor:[UIColor whiteColor]];
    [sureBtn addTarget:obj action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        if([obj respondsToSelector:@selector(btnOnClick:withEvent:)]){
            [view removeFromSuperview];
             NSLog(@"______________");
        }
    [bottomIV addSubview:sureBtn];
    return view;
}

@end
