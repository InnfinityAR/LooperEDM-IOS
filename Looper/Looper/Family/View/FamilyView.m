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
        
        
        [self initView];
    }
    return self;
}




-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前UIScrollView的位置
    CGPoint offset = [scrollView contentOffset];
    //算出滚动到第几页
    int currentPage = offset.x/DEF_SCREEN_WIDTH;
    //设置UIPageControl
   // self.pageIndicator.currentPage = currentPage - 1;
    //对最后一张和第一张要进行特殊处理
    //1、如果是第一张
    NSLog(@"%f",offset.x);
    NSLog(@"%d",currentPage);
    if (currentPage == 0) {
        
        if(localCurrent ==currentPage){
        
            [_sc setContentOffset:CGPointMake(DEF_SCREEN_WIDTH * (7-1), 0) animated:NO];
        }
    }
    
    //2、如果是最后一张
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
    
    
    
    
    
    
    
    
    
//    _sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5,117*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 976*DEF_Adaptation_Font*0.5)];
//   // [_sc setBackgroundColor:[UIColor colorWithRed:86/255.0 green:79/255.0 blue:109/255.0 alpha:1.0]];
//    
//    for (int i=0; i<7; i++) {
//        
//        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+i *582*DEF_Adaptation_Font*0.5+(i*58*DEF_Adaptation_Font*0.5), 0, 582*DEF_Adaptation_Font*0.5,  976*DEF_Adaptation_Font*0.5)];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
//        label.text = [@(i) stringValue];
//        [view addSubview:label];
//        view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1];
//        [_sc addSubview:view];
//        
//    }
//    _sc.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*7, 0);
//    _sc.delegate = self;
//    _sc.pagingEnabled = YES;
    
    /**
     *  添加 3d 效果
     */
    
   // [_sc make3Dscrollview];
        
}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"page = %lu",(unsigned long)scrollView.pageNum);
//}



@end
