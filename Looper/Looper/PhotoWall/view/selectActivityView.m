//
//  selectActivityView.m
//  Looper
//
//  Created by lujiawei on 17/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "selectActivityView.h"
#import "PhotoWallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@implementation selectActivityView{

    NSDictionary *_dataSource;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDic:(NSDictionary*)dicSource{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (PhotoWallViewModel*)idObject;
        
        
        [self initView:dicSource];
    }
    return self;
}






-(void)initView:(NSDictionary*)dataSource{
    
    _dataSource  = [[NSDictionary alloc] initWithDictionary:dataSource];
    
    [self endEditing:true];
    
    [self setBackgroundColor: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    
    
    [self createHudView];

    

}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag==101){
    
       
         [self removeFromSuperview];
    }



}

-(void)activityBtnClick{
    [_obj setActivityID:[[_dataSource objectForKey:@"data"] objectAtIndex:0]];

     [self removeFromSuperview];
}


-(void)createImage:(CGRect)rect andImageStr:(NSString*)ImageStr{
    UIImageView *line = [[UIImageView alloc] initWithFrame:rect];
    [line setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:line];
}


-(void)createHudView{

    UILabel* titleStr = [LooperToolClass createLableView:CGPointMake(230*DEF_Adaptation_Font*0.5,54*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(180*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:@"选择现场" andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [self addSubview:titleStr];
    
     UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    UIImageView *location = [[UIImageView alloc] initWithFrame:CGRectMake(43*DEF_Adaptation_Font*0.5, 206*DEF_Adaptation_Font*0.5, 18*DEF_Adaptation_Font*0.5, 19*DEF_Adaptation_Font*0.5)];
    location.image=[UIImage imageNamed:@"locaton1.png"];
    [self addSubview:location];
    
    
    UILabel *spaceName = [LooperToolClass createLableView:CGPointMake(90*DEF_Adaptation_Font_x*0.5, 206*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(240*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:[[_dataSource objectForKey:@"ipinfo"] objectForKey:@"city"] andFontSize:11 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [self addSubview:spaceName];
    
    
    
 
    [self createImage:CGRectMake(38*DEF_Adaptation_Font*0.5, 174*DEF_Adaptation_Font*0.5, 610*DEF_Adaptation_Font*0.5, 1*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(38*DEF_Adaptation_Font*0.5, 266*DEF_Adaptation_Font*0.5, 610*DEF_Adaptation_Font*0.5, 1*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    
    
    if([[_dataSource objectForKey:@"data"] count]!=0){
        [self createImage:CGRectMake(38*DEF_Adaptation_Font*0.5, 357*DEF_Adaptation_Font*0.5, 610*DEF_Adaptation_Font*0.5, 1*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
        
        UILabel* activityname = [LooperToolClass createLableView:CGPointMake(45*DEF_Adaptation_Font*0.5,304*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(300*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:[[[_dataSource objectForKey:@"data"] objectAtIndex:0] objectForKey:@"activityname"] andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
        [self addSubview:activityname];


        UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font_x*0.5, 268*DEF_Adaptation_Font_x*0.5, 610*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5)];
        [activityBtn addTarget:self action:@selector(activityBtnClick) forControlEvents:UIControlEventTouchDown];
        [self addSubview:activityBtn];
    
    
    }
    
   


}



@end
