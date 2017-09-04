//
//  FamilyMemberView.m
//  Looper
//
//  Created by 工作 on 2017/9/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyMemberView.h"
#import "FamilyViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
@interface FamilyMemberView()
@property(nonatomic,strong)NSArray *dataArr;
@end
@implementation FamilyMemberView

-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSArray *)dataArr{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataArr=dataArr;
        [self initView];
    }
    return self;
}
-(void)initView{
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), 68*DEF_Adaptation_Font*0.5)];
    headerView.image=[UIImage imageNamed:@"family_header_BG"];
    [self addSubview:headerView];
    headerView.userInteractionEnabled=YES;
    UIButton *inviteBtn=[LooperToolClass createBtnImageNameReal:@"familyMember_invite" andRect:CGPointMake(DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 6*DEF_Adaptation_Font*0.5) andTag:99 andSelectImage:@"familyMember_invite" andClickImage:@"familyMember_invite" andTextStr:nil andSize:CGSizeMake(60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    [headerView addSubview:inviteBtn];
    UILabel *headerLB=[[UILabel alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 0, DEF_WIDTH(self)-180*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerLB.textAlignment=NSTextAlignmentCenter;
    headerLB.text=@"Welphen";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [headerView addSubview:headerLB];
    
    UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 68*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 62*DEF_Adaptation_Font*0.5)];
    contentView.backgroundColor=ColorRGB(84, 71, 104, 1.0);
    [self addSubview:contentView];
    
    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
    if (tag==99) {
//邀请button
        
    }
    if (tag==100) {
        //保存到手机
    }if(tag==101){
        //分享二维码
    }
}
@end
