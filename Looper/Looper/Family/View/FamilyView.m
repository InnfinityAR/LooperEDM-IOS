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
#import "LocalDataMangaer.h"
#import "FamilyMemberView.h"
#import "FamilyDetailView.h"
@interface FamilyView()

@end
@implementation FamilyView{
    
    
    FamilyRankView *rankView;
    FamilyRankView *listView;
    FamilyMessageView *messageView;
    FamilyMemberView *memberView;
    FamilyDetailView *detailView;
    
    //用于页面切换
    //    UIView *contentView;
    UIScrollView *_sc;
    int localCurrent;
    
    NSArray *titleArray;
    UILabel *textLB;
    UILabel *textLB1;
    UILabel *textLB2;
    NSInteger titleNum;
}


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self.obj setFamilyView:self];
        if ([LocalDataMangaer sharedManager].raverid ==nil||[[LocalDataMangaer sharedManager].raverid isEqual:[NSNull null]]) {
        titleArray=@[@"家族排行",@"家族列表",@"家族消息"];
        }else{
            titleArray=@[@"家族排行",@"家族详情",@"家族成员"];
        }
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
    titleNum=0;
    textLB=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2-60*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    textLB.textColor=[UIColor whiteColor];
    textLB.textAlignment=NSTextAlignmentCenter;
    textLB.text=titleArray[titleNum];
    [self addSubview:textLB];
    textLB1=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2-240*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    textLB1.textColor=ColorRGB(255, 255, 255, 0.5);
    textLB1.textAlignment=NSTextAlignmentCenter;
    textLB1.text=titleArray[1];
    [self addSubview:textLB1];
    textLB2=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2+120*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    textLB2.textColor=ColorRGB(255, 255, 255, 0.5);
    textLB2.textAlignment=NSTextAlignmentCenter;
    textLB2.text=titleArray[titleArray.count-1];
    [self addSubview:textLB2];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = [scrollView contentOffset];
    int currentPage = offset.x/DEF_SCREEN_WIDTH;
    if (currentPage == 0) {
        
        if(localCurrent ==currentPage){
            
            [_sc setContentOffset:CGPointMake(DEF_SCREEN_WIDTH * (3-1), 0) animated:NO];
        }
    }
    else if(currentPage == 2) {
        if (localCurrent==currentPage) {
            [_sc setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    };
    localCurrent=currentPage;
    textLB.text=titleArray[currentPage];
    if (currentPage==titleArray.count-1) {
        textLB1.text=titleArray[0];
    }else{
        textLB1.text=titleArray[currentPage+1];
    }
    if (currentPage==0) {
        textLB2.text=titleArray[titleArray.count-1];
    }else{
        textLB2.text=titleArray[currentPage-1];
    }
    
}

-(void)initView{
    
    UIImageView *bk_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk_image setImage:[UIImage imageNamed:@"bg_family.png"]];
    [self addSubview:bk_image];
    [self initSCView];
    if ([LocalDataMangaer sharedManager].raverid ==nil||[[LocalDataMangaer sharedManager].raverid isEqual:[NSNull null]]) {
        [self.obj getFamilyRankDataForOrderType:nil andRaverId:nil];
    }else{
        [self.obj getFamilyRankDataForOrderType:nil andRaverId:[LocalDataMangaer sharedManager].raverid];
        [self.obj getFamilyDetailDataForRfId:[LocalDataMangaer sharedManager].raverid andRank:@"1"];
    }
}
//家族排行
-(void)initFamilyRankWithDataArr:(NSArray *)dataArr{
    rankView=[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:1];
    [_sc addSubview:rankView];
    [_sc make3Dscrollview];
}
//家族列表
-(void)initFamilyListWithDataArr:(NSArray *)dataArr{
    listView =[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+640*DEF_Adaptation_Font*0.5, 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:0];
    [_sc addSubview:listView];
    [_sc make3Dscrollview];
}
//消息
-(void)initFamilyMessageWithDataArr:(NSArray *)dataArr{
    messageView=[[FamilyMessageView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+640*2*DEF_Adaptation_Font*0.5, 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr];
    [_sc addSubview:messageView];
    [_sc make3Dscrollview];
}
//家族详情
-(void)initFamilyDetailWithDataDic:(NSDictionary *)dataDic{
    detailView=[[FamilyDetailView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+640*DEF_Adaptation_Font*0.5, 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataDic:dataDic andRankNumber:@"1"];
    [_sc addSubview:detailView];
    [_sc make3Dscrollview];
}
//家族成员
-(void)initFamilyMemberWithDataArr:(NSArray *)dataArr{
    memberView=[[FamilyMemberView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+640*2*DEF_Adaptation_Font*0.5, 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObj:self.obj andDataArr:dataArr];
    [_sc addSubview:memberView];
    [_sc make3Dscrollview];

}
-(void)initSCView{
    _sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5,117*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 976*DEF_Adaptation_Font*0.5)];
//    _sc.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*3, 0);
    _sc.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*titleArray.count, 0);
    _sc.delegate = self;
    _sc.pagingEnabled = YES;
    [self addSubview:_sc];
}

@end
