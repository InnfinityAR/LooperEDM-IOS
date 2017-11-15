//
//  integrateDetailView.m
//  Looper
//
//  Created by lujiawei on 13/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "integrateDetailView.h"
#import "MallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"-

@implementation integrateDetailView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (MallViewModel*)idObject;
        [self initView];
    }
    return self;
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag ==100){
        [self removeFromSuperview];
    }
}


-(void)initView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    [self setBackgroundColor:[UIColor colorWithRed:39/255.0 green:39/255.0 blue:72/255.0 alpha:1.0]];
    
    UILabel *titleName=[[UILabel alloc]initWithFrame:CGRectMake(279*DEF_Adaptation_Font*0.5, 66*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    titleName.font=[UIFont systemFontOfSize:11];
    titleName.textColor=[UIColor whiteColor];
    titleName.text=@"积分明细";
    [self addSubview:titleName];
    
    UILabel *integrateLable=[[UILabel alloc]initWithFrame:CGRectMake(282*DEF_Adaptation_Font*0.5, 128*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    integrateLable.font=[UIFont systemFontOfSize:11];
    integrateLable.textColor=[UIColor whiteColor];
    integrateLable.text=@"当前积分";
    [self addSubview:integrateLable];
    
    UIImageView *integrate_icon = [LooperToolClass createImageView:@"icon_integrate_max.png" andRect:CGPointMake(212, 175) andTag:100 andSize:CGSizeMake(34, 40) andIsRadius:false];
    [self addSubview:integrate_icon];
    
    UILabel *integrateNum=[[UILabel alloc]initWithFrame:CGRectMake(269*DEF_Adaptation_Font*0.5, 173*DEF_Adaptation_Font*0.5, 169*DEF_Adaptation_Font*0.5, 52*DEF_Adaptation_Font*0.5)];
    integrateNum.font=[UIFont systemFontOfSize:16];
    integrateNum.textColor=[UIColor whiteColor];
    integrateNum.text=[NSString stringWithFormat:@"%@积分",[LocalDataMangaer sharedManager].creditNum];

    integrateNum.textColor=[UIColor colorWithRed:136/255.0 green:131/255.0 blue:250/255.0 alpha:1.0];
    [self addSubview:integrateNum];
    
    
    UILabel *integrateLog=[[UILabel alloc]initWithFrame:CGRectMake(283*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 83*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    integrateLog.font=[UIFont systemFontOfSize:11];
    integrateLog.textColor=[UIColor whiteColor];
    integrateLog.text=@"积分记录";
    [self addSubview:integrateLog];
    
    
    
    
}


@end
