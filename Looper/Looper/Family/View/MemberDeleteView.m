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
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation MemberDeleteView

-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary*)dataDic{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataDic=dataDic;
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
        NSString *name=@"暴走萝莉";
        contentLB.text=[NSString stringWithFormat:@"若移除%@,%@的活跃值将从战队总活跃值中扣除。确定将其移除吗",name,name];
    contentLB.textColor=[UIColor whiteColor];
    CGSize lblSize3 = [contentLB.text boundingRectWithSize:CGSizeMake(412*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGRect frame3=contentLB.frame;
    frame3.size=lblSize3;
    contentLB.frame=frame3;
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:16];
    [backIV addSubview:contentLB];
//    UIButton *cancelBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(<#CGFloat x#>, <#CGFloat y#>) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:<#(CGSize)#> andTarget:<#(id)#>]
}
@end
