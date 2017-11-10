//
//  ShoppingPhotoView.m
//  Looper
//
//  Created by 工作 on 2017/11/9.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ShoppingPhotoView.h"
#import "MallViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "SlidingScrolleview.h"
@interface ShoppingPhotoView()
@property(nonatomic,strong)NSArray *photoArr;
@property(nonatomic)NSInteger index;
@end
@implementation ShoppingPhotoView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andPhotoArr:(NSArray *)photoNameArr andIntex:(NSInteger)index{
    if (self=[super initWithFrame:frame]) {
        self.obj=(MallViewModel *)obj;
        self.photoArr=photoNameArr;
        self.index=index;
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor=[UIColor blackColor];
    [self initBackView];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag ==100){
        [self removeFromSuperview];
    }
}
-(void)initBackView{
    SlidingScrolleview *scrollview = [[SlidingScrolleview alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self))];
    scrollview.imageVType=UIViewContentModeScaleAspectFit;
    [scrollview setImageArr:self.photoArr];
    scrollview.scrollview.contentOffset=CGPointMake(DEF_WIDTH(self)*_index, 0);
    [self addSubview:scrollview];
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
}
@end
