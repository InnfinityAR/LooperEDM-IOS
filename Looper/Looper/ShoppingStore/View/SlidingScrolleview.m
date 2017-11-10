//
//  SlidingScrolleview.m
//  scrollView
//
//  Created by 郝高明 on 15-3-2.
//  Copyright (c) 2015年 郝高明. All rights reserved.
//

#import "SlidingScrolleview.h"
#import "LooperConfig.h"
@interface SlidingScrolleview ()<UIScrollViewDelegate>
{
    /**
     *  图片的个数
     */
    NSUInteger imageNumber;
    /**
     *  滑动的图片数
     */
    int currentPageIndex;
    /**
     *  是否启动timer
     */
    BOOL isTimerStart;
}
/**
 *  计时器
 */
@property (nonatomic,retain) NSTimer *timer;
/**
 *  UIPageControl
 */
@property (nonatomic,retain) UIPageControl *pageControl;

/**
 *  图片数组
 */
@property (nonatomic,retain) NSArray *imageArray;

@end

@implementation SlidingScrolleview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageVType=UIViewContentModeScaleAspectFill;
        // Initialization code
    }
    return self;
}

-(void)setImageArr:(NSArray *)arr
{
    self.imageArray = arr;
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
    scrollview.scrollsToTop = NO;
    scrollview.userInteractionEnabled = YES;
    self.scrollview = scrollview;
    [self addSubview:scrollview];
    
    //深拷贝imageview上的控件
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:arr];
    UIImageView *imageview1=[arr objectAtIndex:([arr count]-1)];
    UIImageView *imageview2=[arr objectAtIndex:0];
    NSData *data1=[NSKeyedArchiver archivedDataWithRootObject:imageview1];
    NSData *data2=[NSKeyedArchiver archivedDataWithRootObject:imageview2];
    UIImageView *imageview3=[NSKeyedUnarchiver unarchiveObjectWithData:data1];
    UIImageView *imageview4=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    [tempArray insertObject:imageview3 atIndex:0];
    [tempArray addObject:imageview4];
    imageNumber = tempArray.count;
    
    for (int i=0; i<imageNumber; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        if (_imageVType==UIViewContentModeScaleAspectFill) {
        imageview.contentMode=UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds=YES;
        }else{
         imageview.contentMode=UIViewContentModeScaleAspectFit;
        }
        imageview.userInteractionEnabled = YES;
        imageview.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[tempArray objectAtIndex:i] ofType:@"png"]];
        imageview.tag = 10 + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageviewClick:)];
        [imageview addGestureRecognizer:tap];
        [self.scrollview addSubview:imageview];
    }
    
    float pageControlWidth = (imageNumber-2) * 10.0f + 40.f;
    UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width/2-pageControlWidth/2),self.frame.size.height-27, pageControlWidth, 20)];
    self.pageControl = pageControl;
    pageControl.currentPage = 0;
    pageControl.numberOfPages = imageNumber-2;
    pageControl.currentPageIndicatorTintColor=ColorRGB(104, 185, 185, 1.0);
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    [self addSubview:pageControl];
    
    self.scrollview.contentSize = CGSizeMake(self.frame.size.width * imageNumber, self.frame.size.height);
    [self.scrollview setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    [self startTimer];
}

-(void)startTimer
{
    if(self.timer == nil){
        isTimerStart = YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
    }
}

-(void)colseTimer
{
    if (self.timer) {
        isTimerStart = NO;
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)timerStart
{
    CGPoint pt = self.scrollview.contentOffset;
    if(pt.x == self.frame.size.width * (imageNumber-2)){
        self.pageControl.currentPage = 0;
        [self.scrollview scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }else{
        [self.scrollview scrollRectToVisible:CGRectMake(pt.x + self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self colseTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollview.frame.size.width;
    int page = floor((self.scrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = (page-1);
    currentPageIndex = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    if (0 == currentPageIndex) {
        [self.scrollview setContentOffset:CGPointMake([self.imageArray count]*self.frame.size.width, 0)];
    }
    if (([self.imageArray count]+1) == currentPageIndex) {
        [self.scrollview setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    [self startTimer];
}

-(void)imageviewClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击的图片：%d",tap.view.tag-10);
    if (_delegate && [_delegate respondsToSelector:@selector(slidingClickImage_index:)]) {
        [self.delegate slidingClickImage_index:tap.view.tag-10];
    }
}

@end
