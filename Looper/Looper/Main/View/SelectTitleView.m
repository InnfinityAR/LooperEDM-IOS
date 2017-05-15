//
//  SelectTitleView.m
//  Looper
//
//  Created by lujiawei on 1/12/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SelectTitleView.h"
#import "CreateLoopView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"




@implementation SelectTitleView{

    NSMutableArray *listTypes;
    UIButton *backBtn;
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSMutableArray*)data
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (CreateLoopView*)idObject;
        listTypes=data;
        [self initView];
        
        
    }
    return self;
}


-(void)createBackGround{

    UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5,0*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [self addSubview:bk1];
    bk1.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    
    
    UIView *bk2 = [[UIView alloc] initWithFrame:CGRectMake(18*DEF_Adaptation_Font*0.5,259*DEF_Adaptation_Font*0.5,607*DEF_Adaptation_Font*0.5,528*DEF_Adaptation_Font*0.5)];
   // [bk2 setBackgroundColor:[UIColor blackColor]];
    [bk2  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self addSubview:bk2];
    bk2.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    
    UIImageView *bk=[LooperToolClass createImageView:@"createLoopBk.png" andRect:CGPointMake(7, 248) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 548*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bk];
    
    
    UIImageView *line=[LooperToolClass createImageView:@"bg_createloop_line.png" andRect:CGPointMake(18, 259) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 525*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:line];

}




- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag == backTag){
    
        [_obj removeLayer:backTag];
    
    }
}

-(void)onClickImage:(UITapGestureRecognizer *)tap{

    NSLog(@"%d",tap.view.tag);
    
     [_obj removeLayer:tap.view.tag];
}


-(void)createListBtn{
    for (int i=0;i<[listTypes count];i++){
        NSDictionary *dicData = [listTypes objectAtIndex:i];
        int BtnTag=  [[dicData objectForKey:@"TypeID"] intValue];
        UIImageView *btn;
        if(i<4){
            btn = [[UIImageView alloc] initWithFrame:CGRectMake(97*DEF_Adaptation_Font_x*0.5+(i*107*DEF_Adaptation_Font_x*0.5),372*DEF_Adaptation_Font_x*0.5,107*DEF_Adaptation_Font_x*0.5, 45*DEF_Adaptation_Font_x*0.5)];
        }else{
             btn = [[UIImageView alloc] initWithFrame:CGRectMake(97*DEF_Adaptation_Font_x*0.5+((i-4)*107*DEF_Adaptation_Font_x*0.5),422*DEF_Adaptation_Font_x*0.5,107*DEF_Adaptation_Font_x*0.5, 45*DEF_Adaptation_Font_x*0.5)];
        }
        btn.tag =BtnTag;
        [self addSubview:btn];
        btn.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
        [btn addGestureRecognizer:singleTap];
        [btn sd_setImageWithURL:[dicData objectForKey:@"TypeImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
}



-(void)createHudView{

    backBtn = [LooperToolClass createBtnImageName:@"btn_createLoop_select.png" andRect:CGPointMake(48, 286) andTag:backTag andSelectImage:@"btn_createLoop_select.png" andClickImage:@"btn_createLoop_back.png" andTextStr:nil andSize:CGSizeZero andTarget:self] ;
    [self addSubview:backBtn];
}


-(void)initView{
    [self createBackGround];
    [self createHudView];
    
    [self createListBtn];


}

@end
