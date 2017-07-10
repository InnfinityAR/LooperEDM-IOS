//
//  ViewController.m
//  scrollTest
//
//  Created by leetangsong_macbk on 16/5/19.
//  Copyright © 2016年 macbook. All rights reserved.


#import "LTSCalendarView.h"
#import "LTSCalendarDayView.h"
#import "LTSCalendarContentView.h"
#import "LooperToolClass.h"
#import "LTSCalendarEventSource.h"
#import "LTSCalendarMonthView.h"
#import "LTSCalendarWeekView.h"

@interface LTSCalendarView ()

@end

@implementation LTSCalendarView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.containerView.frame = CGRectMake(0, WEEK_DAY_VIEW_HEIGHT, self.frame.size.width, self.frame.size.height - WEEK_DAY_VIEW_HEIGHT);
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame));
    
}
- (void)initUI{
    
    self.containerView = [UIView new];
    self.containerView.frame = CGRectMake(0, WEEK_DAY_VIEW_HEIGHT, self.frame.size.width, self.frame.size.height - WEEK_DAY_VIEW_HEIGHT);
    [self addSubview:self.containerView];
    self.backgroundColor = [UIColor whiteColor];
    
    //添加 日历事件 表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame))];
    //设置分割线
    [self.containerView addSubview:self.tableView];
    
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
   self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    LTSCalendarManager *calendar = [LTSCalendarManager new];
   
    self.calendar = calendar;
    
    
    
    
    //初始化weekDayView
    LTSCalendarWeekDayView *weekDayView = [LTSCalendarWeekDayView new];
    weekDayView.frame = CGRectMake(0, 0, self.frame.size.width, WEEK_DAY_VIEW_HEIGHT);
    
    self.calendar.weekDayView = weekDayView;
    
    LTSCalendarSelectedWeekView *weekView = [LTSCalendarSelectedWeekView new];
    
    weekView.pagingEnabled = YES;
    [calendar setSelectedWeekView:weekView];
    weekView.frame = CGRectMake(0, 400, self.frame.size.width, 50);
    
    
    //初始化  contentViw
    LTSCalendarContentView *contentView= [LTSCalendarContentView new];
    self.contentView = contentView;
    [calendar setContentView:contentView];
   
    
    UIView *headerView = [UIView new];
    
    headerView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:contentView];
    [headerView addSubview:weekView];
    
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0];
    
    //    view.backgroundColor = [UIColor grayColor];
    
    [self.calendar.calendarAppearance addObserver:self forKeyPath:@"weekDayHeight" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
   
    //初始化外观
    [self configurOriginalAppearance];
    
    //数据加载完
//    [self.calendar reloadData];
    //初始化 第一项数据  初始数据
    self.calendar.currentDateSelected = [NSDate date];
    
    self.calendar.lastSelectedWeekOfMonth = [self.calendar getWeekFromDate:self.calendar.currentDateSelected];
    [self addSubview:weekDayView];
    [self bringSubviewToFront:weekDayView];
    
    self.calendar.currentDate = [NSDate date];
    
    [self.calendar reloadData];
    self.backgroundColor = self.calendar.calendarAppearance.backgroundColor;
    self.topLabel=[[UILabel alloc]initWithFrame:CGRectMake(65/2, -64, self.bounds.size.width-65, 64)];
    self.topLabel.textAlignment=NSTextAlignmentCenter;
    self.topLabel.backgroundColor=[UIColor colorWithRed:47/255.0 green:50/255.0 blue:101/255.0 alpha:1.0];
    self.topLabel.font= [UIFont fontWithName:@"STHeitiTC-Light" size:18.f];;
    self.topLabel.textColor=[UIColor whiteColor];
    [self addSubview:self.topLabel];
}

- (void)configurOriginalAppearance{
    
    
    self.calendar.calendarAppearance.weekDayTextColor = DarkText;
    self.calendar.calendarAppearance.dayTextFont=[UIFont systemFontOfSize:14];
    self.calendar.calendarAppearance.weekDayFormat = LTSCalendarWeekDayFormatFull;
    self.calendar.calendarAppearance.dayCircleColorSelected=RGBCOLOR(251, 52, 65);
    self.calendar.calendarAppearance.dayTextColor = DarkText;
    self.calendar.calendarAppearance.lunarDayTextColorOtherMonth = PrimaryText;
    self.calendar.calendarAppearance.lunarDayTextColor = PrimaryText;
    self.calendar.calendarAppearance.dayTextColorOtherMonth = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0];
    self.calendar.calendarAppearance.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0];
    self.calendar.calendarAppearance.dayDotColor = PrimaryText;
    self.calendar.calendarAppearance.dayDotColorSelected = PrimaryText;
    self.calendar.calendarAppearance.isShowLunarCalender = YES;
    self.calendar.calendarAppearance.dayDotSize = 6;
    self.calendar.calendarAppearance.dayCircleSize = 45;
//    self.calendar.calendarAppearance.dayBorderColorToday = [UIColor clearColor];
    self.calendar.calendarAppearance.weekDayHeight = 55;
    self.calendar.calendarAppearance.isShowLunarCalender = !self.calendar.calendarAppearance.isShowLunarCalender;
    self.calendar.calendarAppearance.dayCircleColorSelected=[UIColor colorWithRed:25/255.0 green:196/255.0 blue:193/255.0 alpha:1.0];
    
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context

{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.calendar.calendarAppearance.weekDayHeight * WEEKS_TO_DISPLAY);
    self.headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.calendar.calendarAppearance.weekDayHeight * WEEKS_TO_DISPLAY);
//   [self.calendar reloadAppearance];
    self.calendar.currentDateSelected = [NSDate date];
    
}


- (void)backToToday{
    
    [self.calendar setCurrentDate:[NSDate date]];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //初始化插入  第一个WeekView
    [self.calendar sendSubviewToSelectedWeekViewWithIndex:self.calendar.currentSelectedWeekOfMonth];
    self.calendar.currentDate = self.calendar.currentDate;

}

//回到全部显示初始位置
- (void)showAllView:(BOOL)animate{
    
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:animate];
    
  
}
//滚回到 只显示 一周 的 位置
- (void)showSingleWeekView:(BOOL)animate{
    
    [self.tableView setContentOffset:CGPointMake(0, self.calendar.calendarAppearance.weekDayHeight*5-20) animated:animate];
    CGRect frame=self.tableView.frame;
    frame=CGRectMake(0, 20, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame)-20);
    self.tableView .frame=frame;
    
}

-(void)dealloc{
    [self.calendar.calendarAppearance removeObserver:self forKeyPath:@"weekDayHeight"];
}



@end
