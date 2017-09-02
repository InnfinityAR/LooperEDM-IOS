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
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+_DScrollView.h"
#import <objc/runtime.h>


@implementation FamilyView{
    
    
    UIView *contentView;
    UIScrollView *_sc;
    int localCurrent;
    
    
}



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self.obj setFamilyView:self];
        [self initView];
    }
    return self;
    
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
        
        if(localCurrent ==currentPage){
            
            [_sc  setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
    
    localCurrent = currentPage;
}



-(void)initView{
    
    UIImageView *bk_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk_image setImage:[UIImage imageNamed:@"bg_family.png"]];
    [self addSubview:bk_image];
    
    [self.obj getRaverData];
    //[self createRecognizer];
}

-(void)initFamilyRankWithDataArr:(NSArray *)dataArr{
    contentView =[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:1];
    [self addSubview:contentView];
    
}
-(void)initFamilyListWithDataArr:(NSArray *)dataArr{
    
    _sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5,117*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 976*DEF_Adaptation_Font*0.5)];
    for (int i=0; i<7; i++) {
        
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+i *582*DEF_Adaptation_Font*0.5+(i*58*DEF_Adaptation_Font*0.5), 0, 582*DEF_Adaptation_Font*0.5,  976*DEF_Adaptation_Font*0.5)];
        view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1];
        [_sc addSubview:view];
        
    }
    _sc.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*7, 0);
    _sc.delegate = self;
    _sc.pagingEnabled = YES;
    
    [_sc make3Dscrollview];
    
    [self addSubview:_sc];
    
}


@end
