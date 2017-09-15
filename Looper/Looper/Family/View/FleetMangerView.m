//
//  FleetMangerView.m
//  Looper
//
//  Created by lujiawei on 13/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FleetMangerView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@implementation FleetMangerView


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




-(void)createHudView{
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
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
    headerLB.text=@"舰队管理";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10) andTag:5000 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    
    
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(32*DEF_Adaptation_Font*0.5, 889*DEF_Adaptation_Font*0.5,521*DEF_Adaptation_Font*0.5,  1.0*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor grayColor]];
    [bkV addSubview:line];
    
    UIButton *createBtn = [LooperToolClass createBtnImageName:@"btn_createFleet.png" andRect:CGPointMake(221, 920) andTag:5001 andSelectImage:@"btn_createFleet.png" andClickImage:@"btn_createFleet.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:createBtn];
    

}


-(void)initView{

    [self createHudView];

   

}

@end
