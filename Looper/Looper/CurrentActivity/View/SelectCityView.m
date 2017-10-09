//
//  SelectCityView.m
//  Looper
//
//  Created by 工作 on 2017/9/26.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SelectCityView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "CurrentActivityView.h"
@interface SelectCityView()
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSArray *cityArr;
@end
@implementation SelectCityView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDetailDic:(NSDictionary*)detailDic andCityArr:(NSArray *)cityArr{
    if (self=[super initWithFrame:frame]) {
        self.obj=(CurrentActivityView *)idObject;
        self.dataDic=detailDic;
        self.cityArr=cityArr;
        [self initView];
        [self initBackView];
    }
    
    return self;
}
-(void)initView{
    //self.backgroundColor=ColorRGB(25, 24, 62, 1.0);
    [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0]];
    UILabel *currentLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 110*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    currentLB.text=@"当前城市";
    currentLB.textColor=ColorRGB(255, 255, 255, 0.8);
    currentLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [self addSubview:currentLB];
    
    CGFloat width=(DEF_WIDTH(self)-75*DEF_Adaptation_Font*0.5)/2;
    UIButton *currentBtn=[self creatSelectButtonWithTag:102 andPoint:CGPointMake(25*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5)andTitle:[self.dataDic objectForKey:@"currentCity"]];
    [self addSubview:currentBtn];
    
    UILabel *cityLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 270*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    cityLB.text=@"活动城市";
    cityLB.textColor=ColorRGB(255, 255, 255, 0.8);
    cityLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [self addSubview:cityLB];
    
    UIScrollView *scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 320*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-320*DEF_Adaptation_Font*0.5)];
    [self addSubview:scrollV];
    for (int i=0; i<self.cityArr.count; i++) {
        if (i%2==0) {
            UIButton *btn=[self creatSelectButtonWithTag:i andPoint:CGPointMake(25*DEF_Adaptation_Font*0.5, 80*(i/2)*DEF_Adaptation_Font*0.5)andTitle:self.cityArr[i]];
            [scrollV addSubview:btn];
        }else{
            UIButton *btn=[self creatSelectButtonWithTag:i andPoint:CGPointMake(width+50*DEF_Adaptation_Font*0.5, 80*(i/2)*DEF_Adaptation_Font*0.5)andTitle:self.cityArr[i]];
            [scrollV addSubview:btn];
        }
    }
    scrollV.contentSize=CGSizeMake(DEF_WIDTH(self), 90*DEF_Adaptation_Font*0.5+80*((self.cityArr.count-1)/2)*DEF_Adaptation_Font*0.5);
}
-(UIButton *)creatSelectButtonWithTag:(int)tag andPoint:(CGPoint )point andTitle:(NSString *)title{
    CGFloat width=(DEF_WIDTH(self)-75*DEF_Adaptation_Font*0.5)/2;
    UIButton *currentBtn=[LooperToolClass createBtnImageNameReal:nil andRect:point andTag:tag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(width, 50*DEF_Adaptation_Font*0.5) andTarget:self];
    [currentBtn setTitle:title forState:(UIControlStateNormal)];
    [currentBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    currentBtn.layer.cornerRadius=25*DEF_Adaptation_Font*0.5;
    currentBtn.layer.masksToBounds=YES;
    currentBtn.layer.borderWidth=0.5;
    currentBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    currentBtn.layer.borderColor=[ColorRGB(255, 255, 255, 0.6) CGColor];
    return currentBtn;
}
-(void)initBackView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=  button.tag;
    if (tag==101) {
        [self removeFromSuperview];
    }
    if ((tag>=0&&tag<self.cityArr.count)||tag==102) {
        [[self.obj locationLB]setText:[NSString stringWithFormat:@"%@",button.titleLabel.text]];
        CGSize lblSize3 = [[self.obj locationLB].text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        CGRect frame3=[self.obj locationLB].frame;
        frame3.size.width=lblSize3.width+26*DEF_Adaptation_Font*0.5;
        [self.obj locationLB].frame=frame3;
        [self.obj reloadTableDataWithCity:button.titleLabel.text];
        [self removeFromSuperview];
    }
}
@end
