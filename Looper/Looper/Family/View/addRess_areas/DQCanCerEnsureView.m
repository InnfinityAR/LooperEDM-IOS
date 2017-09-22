//
//  DQCanCerEnsureView.m
//  YBCommunity
//
//  Created by DQ on 16/9/8.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import "DQCanCerEnsureView.h"

@interface DQCanCerEnsureView ()

@property (nonatomic, strong) UILabel *titleLb;

@end
@implementation DQCanCerEnsureView

- (id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:29/255.0 green:34/255.0 blue:67/255.0 alpha:1.0];
        [self creadtionAllSubView];

    }
    return self;
}

- (void)creadtionAllSubView{
    UIView *Sub = self;
    UIButton *CanCerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CanCerBtn.frame=CGRectMake(20, 5, 60, 35);
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-83, 10, 166, 25)];
    UIButton *EnsureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    EnsureBtn.frame=CGRectMake(self.bounds.size.width-80, 5, 60, 35);
    [Sub addSubview:CanCerBtn];
    [Sub addSubview:_titleLb];
    [Sub addSubview:EnsureBtn];
    CanCerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [CanCerBtn setTitle:@"取消" forState:UIControlStateNormal];
    [CanCerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CanCerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    EnsureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [EnsureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [EnsureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [EnsureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _titleLb.font = [UIFont systemFontOfSize:17];
    _titleLb.textColor = [UIColor whiteColor];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    
    [CanCerBtn addTarget:self action:@selector(ClickCancerAction:) forControlEvents:UIControlEventTouchUpInside];
    [EnsureBtn addTarget:self action:@selector(clickEnsureAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView *bottomV=[[UIView alloc]initWithFrame:CGRectMake(0, 44, self.bounds.size.width, 1)];
    bottomV.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.3];
    [Sub addSubview:bottomV];
}
- (void)setTitleText:(NSString *)title{

    _titleLb.text = title;
}
- (void)ClickCancerAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(ClickCancerDelegateFunction)]) {
        [self.delegate ClickCancerDelegateFunction];
    }

}
- (void)clickEnsureAction:(UIButton *)sender{
   
    if ([self.delegate respondsToSelector:@selector(ClickEnsureDelegateFunction)]) {
        [self.delegate ClickEnsureDelegateFunction];
    }

}
@end
