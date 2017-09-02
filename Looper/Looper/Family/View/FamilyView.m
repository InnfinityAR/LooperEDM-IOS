//
//  FamilyView.m
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FamilyView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "FamilyRankView.h"
#import "FamilyMessageView.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+_DScrollView.h"
#import <objc/runtime.h>
#import "FamilySearchView.h"
@interface FamilyView()

@end
@implementation FamilyView{
    
    
    FamilyRankView *rankView;
    FamilyRankView *listView;
    FamilyMessageView *messageView;
    
//用于页面切换
//    UIView *contentView;
    UIScrollView *_sc;
    int localCurrent;
    
    
}


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self.obj setFamilyView:self];
        [self initView];
        [self initBackView];
    }
    return self;
    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        [self removeFromSuperview];
        [_obj popController];
    }
    if (button.tag==101) {
        //家族搜索
        // 是否自动隐藏导航
        FamilySearchView *searchView=[[FamilySearchView alloc]initWithFrame:self.bounds and:self.obj];
        [self.obj setSearchView:searchView];
        [self addSubview:searchView];
        
    }
}


#pragma-添加BackView
-(void)initBackView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    UIButton *searchBtn = [LooperToolClass createBtnImageNameReal:@"btn_serach_select.png" andRect:CGPointMake(DEF_WIDTH(self)-84*DEF_Adaptation_Font*0.5,10*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_serach_select.png" andClickImage:@"btn_serach_select.png" andTextStr:nil andSize:CGSizeMake(54*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:searchBtn];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = [scrollView contentOffset];
    int currentPage = offset.x/DEF_SCREEN_WIDTH;
    if (currentPage == 0) {
        
        if(localCurrent ==currentPage){
            
            [_sc setContentOffset:CGPointMake(DEF_SCREEN_WIDTH * (7-1), 0) animated:NO];
        }
    }
    else if(currentPage == 6) {
        if (localCurrent==currentPage) {
            [_sc setContentOffset:CGPointMake(0, 9) animated:NO];
        }
    };
    localCurrent=currentPage;
}

-(void)initView{
    
    UIImageView *bk_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk_image setImage:[UIImage imageNamed:@"bg_family.png"]];
    [self addSubview:bk_image];
    [self initSCView];
    [self.obj getFamilyRankDataForOrderType:nil andRaverId:nil];
    [self.obj getRaverData];
}

-(void)initFamilyRankWithDataArr:(NSArray *)dataArr{
     rankView=[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:1];
    [_sc addSubview:rankView];
    
}
-(void)initFamilyListWithDataArr:(NSArray *)dataArr{
    rankView =[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+DEF_WIDTH(self), 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:0];
    [_sc addSubview:rankView];
}
-(void)initSCView{
    _sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5,117*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 976*DEF_Adaptation_Font*0.5)];
    for (int i=0; i<7; i++) {
        
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+i *582*DEF_Adaptation_Font*0.5+(i*58*DEF_Adaptation_Font*0.5), 0, 582*DEF_Adaptation_Font*0.5,  976*DEF_Adaptation_Font*0.5)];
        if (i>1) {
        view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1];
        }
        [_sc addSubview:view];
        
    }
    _sc.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*7, 0);
    _sc.delegate = self;
    _sc.pagingEnabled = YES;
    
    [_sc make3Dscrollview];
    
    [self addSubview:_sc];
}

@end
