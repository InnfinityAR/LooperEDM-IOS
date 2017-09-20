//
//  CreateFleetNameView.m
//  Looper
//
//  Created by lujiawei on 15/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "CreateFleetNameView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"


@implementation CreateFleetNameView

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







-(void)initView{
    
    UIView* bkV =[[UIView alloc] initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5, 978*DEF_Adaptation_Font*0.5)];
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
    
    
    
    
    
    UIButton *commitBtn = [LooperToolClass createBtnImageName:@"btn_family_commit.png" andRect:CGPointMake(56, 891) andTag:5001 andSelectImage:@"btn_Family_uncommit.png" andClickImage:@"btn_Family_uncommit.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:commitBtn];
    
    


}



@end
