//
//  ShoppingArgumentView.m
//  Looper
//
//  Created by 工作 on 2017/11/13.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ShoppingArgumentView.h"
#import "MallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
@interface ShoppingArgumentView()
{
    UIView *contentV;
}
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation ShoppingArgumentView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataDic:(NSDictionary *)dataDic{
    if (self=[super initWithFrame:frame]) {
        self.obj=(MallViewModel *)obj;
        self.dataDic=dataDic;
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    contentV=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH, 300*DEF_Adaptation_Font*0.5)];
    contentV.backgroundColor=ColorRGB(39, 39, 72,1.0);
    [self addAction];
    [self addSubview:contentV];
    
    UILabel *argumentLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    argumentLB.text=@"商品参数";
    argumentLB.textColor=[UIColor whiteColor];
    argumentLB.font=[UIFont boldSystemFontOfSize:20];
    [contentV addSubview:argumentLB];
    
    UIButton *backBtn=[LooperToolClass createBtnImageNameReal:@"allShowBtn.jpg" andRect:CGPointMake(DEF_WIDTH(self)-170*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    [contentV addSubview:backBtn];
    [self createTableViewCellWithTitle:@"商品名称" andContent:[_dataDic objectForKey:@"subhead"] andIndex:0];
    [self createTableViewCellWithTitle:@"品牌" andContent:[_dataDic objectForKey:@"commoditybrand"] andIndex:1];
    [self createTableViewCellWithTitle:@"尺寸" andContent:[_dataDic objectForKey:@"commoditysize"] andIndex:2];
    [self createTableViewCellWithTitle:@"颜色" andContent:[_dataDic objectForKey:@"commoditycolour"] andIndex:3];
    
}
-(void)createTableViewCellWithTitle:(NSString *)title  andContent:(NSString *)content andIndex:(NSInteger)index{
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5+60*index, 150*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    nameLB.text=title;
    nameLB.textColor=[UIColor whiteColor];
    nameLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [contentV addSubview:nameLB];
    UILabel *nameLB2=[[UILabel alloc]initWithFrame:CGRectMake(200*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5+60*index, 400*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    if (content==nil||[content isEqual:[NSNull null]]) {
    }else{
    nameLB2.text=content;
    }
    nameLB2.textColor=[UIColor whiteColor];
    nameLB2.font=[UIFont systemFontOfSize:14];
    [contentV addSubview:nameLB2];
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 228*DEF_Adaptation_Font*0.5+60*index, DEF_WIDTH(self)-60*DEF_Adaptation_Font*0.5, 0.8*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    if (index!=3) {
    [contentV addSubview:lineV];
    }
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if (button.tag==100) {
        [UIView animateWithDuration:0.3 animations:^{
            [contentV setFrame:CGRectMake(0, DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH, 300*DEF_Adaptation_Font*0.5)];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}
-(void)addAction{
    [UIView animateWithDuration:0.3 animations:^{
        [contentV setFrame:CGRectMake(0,300*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - 300*DEF_Adaptation_Font*0.5)];
    } completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        [contentV setFrame:CGRectMake(0, DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH, 300*DEF_Adaptation_Font*0.5)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
@end
