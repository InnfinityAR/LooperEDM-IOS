//
//  CreateFleetGroupView.m
//  Looper
//
//  Created by lujiawei on 18/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "CreateFleetGroupView.h"
#import "FamilyViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"

@implementation CreateFleetGroupView{

    UIView* bkV;



}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self initView];
    }
    return self;
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==5000){
        
        [self removeFromSuperview];
    }else if(button.tag==5001){
        
    }
}


-(void)onClickBtn:(UITapGestureRecognizer*)tap{




}

-(void)createBtnLabel:(CGRect)rect and:(int)tag andStr:(NSString*)string{
    
    UILabel *btnName=[[UILabel alloc]initWithFrame:rect];
    btnName.text=string;
    btnName.userInteractionEnabled=YES;
    btnName.tag=tag;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBtn:)];
    [btnName addGestureRecognizer:singleTap];
    [self addSubview:btnName];
    btnName.textColor=[UIColor whiteColor];
    btnName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    btnName.textAlignment=NSTextAlignmentCenter;
    [bkV addSubview:btnName];
}



-(void)initView{
    bkV =[[UIView alloc] initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5, 978*DEF_Adaptation_Font*0.5)];
    [bkV setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
    [self addSubview:bkV];
    bkV.layer.cornerRadius=12.0*DEF_Adaptation_Font*0.5;
    bkV.layer.masksToBounds=YES;
    
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 585*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerView.image=[UIImage imageNamed:@"family_header_BG"];
    [bkV addSubview:headerView];
    
    UILabel *headerLB=[[UILabel alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 0, bkV.frame.size.width-180*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerLB.textAlignment=NSTextAlignmentCenter;
    headerLB.text=@"新建舰队";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10) andTag:5000 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    
    UILabel *presentMemberLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 68*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 60*DEF_Adaptation_Font*0.5)];
    presentMemberLB.backgroundColor=ColorRGB(84, 71, 104, 1.0);
    presentMemberLB.textAlignment=NSTextAlignmentCenter;
    presentMemberLB.textColor=ColorRGB(255, 255, 255, 0.7);
    presentMemberLB.text=@"选择队长";
    presentMemberLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [bkV addSubview:presentMemberLB];

    [self createBtnLabel:CGRectMake(103*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:101 andStr:@"名称"];
    UIButton *sortBtn=[LooperToolClass createBtnImageNameReal:@"familyMember_sort.png" andRect:CGPointMake(210*DEF_Adaptation_Font*0.5, 155*DEF_Adaptation_Font*0.5) andTag:5001 andSelectImage:@"familyMember_sort.png" andClickImage:@"familyMember_sort.png" andTextStr:nil andSize:CGSizeMake(15*DEF_Adaptation_Font*0.5, 15*DEF_Adaptation_Font*0.5) andTarget:self];
    [bkV addSubview:sortBtn];
    [self createBtnLabel:CGRectMake(303*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:100 andStr:@"活跃值"];
    [self createBtnLabel:CGRectMake(395*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:102 andStr:@"性别"];


    UIView *bottomV=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(bkV)-100*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 100*DEF_Adaptation_Font*0.5)];
    bottomV.backgroundColor=ColorRGB(84, 71, 104, 1.0);
    [bkV addSubview:bottomV];
    
    
    UIButton *createBtn =[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(57*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andTag:5002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(471*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5) andTarget:self];

    [createBtn setTitle:@"创建" forState:(UIControlStateNormal)];
    
    createBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [createBtn setTintColor:[UIColor whiteColor]];
    createBtn.layer.cornerRadius=10*DEF_Adaptation_Font*0.5;
    createBtn.layer.masksToBounds=YES;
    createBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
    [bottomV addSubview:createBtn];
    
    

}






@end
