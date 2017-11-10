//
//  SlidingScrolleview.h
//  scrollView
//
//  Created by 郝高明 on 15-3-2.
//  Copyright (c) 2015年 郝高明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlidingScrolleviewDelegate <NSObject>

@optional
/**
 *  图片点击事件
 *
 *  @param index 点击的图片
 */
-(void)slidingClickImage_index:(int)index;

@end

@interface SlidingScrolleview : UIView

/**
 *  代理
 */
@property (nonatomic,assign) id delegate;
/**
 *  设置图片的数目
 *
 *  @param arr 数组
 */
-(void)setImageArr:(NSArray *)arr;

/**
 *  开启timer
 */
-(void)startTimer;

/**
 *  关闭timer
 */
-(void)colseTimer;

/**
 *  scrollview
 */
@property (nonatomic,retain) UIScrollView *scrollview;
//设置图片的展示类型
@property(nonatomic)NSInteger imageVType;


@end
