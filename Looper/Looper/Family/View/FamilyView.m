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
@implementation FamilyView{


    FamilyRankView *contentView;


}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self.obj setFamilyView:self];
        
        [self initView];
    }
    return self;
    
    
}

- (void)swipeGestureOfLeftClicked:(UISwipeGestureRecognizer *)swipeGesture
{
    [self transitionAnimation:YES];
}
#pragma mark --向右滑动浏览上一张图片--
- (void)swipeGestureOfRightClicked:(UISwipeGestureRecognizer *)swipeGesture
{
    [self transitionAnimation:NO];
}

-(void)createRecognizer{
    /**轻扫手势--左手势*/
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureOfLeftClicked:)];
    
    /**手势方向*/
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    /**轻扫手势--右手势*/
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureOfRightClicked:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:swipeLeft];
    [self addGestureRecognizer:swipeRight];
}


- (void)transitionAnimation:(BOOL)isNext
{
    //创建转场动画对象
    CATransition *transition = [[CATransition alloc]init];
    if (isNext == YES) {
        transition.type     =   @"cube";
        transition.subtype  =   kCATransitionFromRight;
    } else {
        transition.type     =   @"cube";
        transition.subtype  =   kCATransitionFromLeft;
    }
    
    
    
    
    //设置动画时长，默认为0
    transition.duration=1.0;

    
    [contentView.layer addAnimation:transition forKey:@"Animation"];
}



-(void)initView{
    
    UIImageView *bk_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk_image setImage:[UIImage imageNamed:@"bg_family.png"]];
    [self addSubview:bk_image];
    [self createRecognizer];
    [self.obj getFamilyRankDataForOrderType:nil];
    
}

-(void)initContentViewWithDataArr:(NSArray *)dataArr{
    contentView =[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:1];
    [self addSubview:contentView];

}

@end
