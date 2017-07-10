//
//  CarlendarView.m
//  Looper
//
//  Created by 工作 on 2017/7/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "CarlendarView.h"
#import "LooperToolClass.h"
#import "nActivityViewModel.h"
@implementation CarlendarView

-(NSMutableDictionary *)eventsByDate{
    if (!_eventsByDate) {
        _eventsByDate=[NSMutableDictionary new];
    }
    return _eventsByDate;
}
-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArr andObj:(id)obj;{
    if (self=[super initWithFrame:frame]) {
        self.obj=(nActivityViewModel *)obj;
        self.dataArray =dataArr;
        // 获取各时间字段的数值
        [self createRandomEvents];
        [self lts_InitUI];
        self.calendarView.topLabel.text=[NSString stringWithFormat:@"%@月",[self currentMonth]];
    }
    return self;
}
-(NSString*)currentMonth{
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    switch (comp.month) {
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
        case 7:
            return @"七";
            break;
        case 8:
            return @"八";
            break;
        case 9:
            return @"九";
            break;
        case 10:
            return @"十";
            break;
        case 11:
            return @"十一";
            break;
        case 12:
            return @"十二";
            break;
        default:
            break;
    }
    return nil;
}
- (void)createRandomEvents
{
    self.eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < self.dataArray.count; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDictionary *dictionary=self.dataArray[i];
        NSDate *Date =[self timeWithTimeIntervalString:[dictionary objectForKey:@"starttime"]];
        NSString *key = [[self dateFormatter] stringFromDate:Date];
        if(!self.eventsByDate[key]){
            self.eventsByDate[key] = [NSMutableArray new];
        }
        //        [self.eventsByDate[key] addObject:Date];
        [self.eventsByDate[key]addObject:dictionary];
    }
    
}

- (NSDate *)timeWithTimeIntervalString:(NSString *)timeString
{
    NSTimeInterval time=[timeString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    return  detaildate;
}
- (void)lts_InitUI{
    self.calendarView = [[LTSCalendarView alloc]initWithFrame:self.bounds];
    self.calendarView.calendar.calendarAppearance.weekDayFormat = LTSCalendarWeekDayFormatShort;
    [self addSubview:self.calendarView];
    self.calendarView.tableView.delegate = self;
    self.calendarView.tableView.dataSource = self;
    self.calendarView.calendar.eventSource = self;
    self.calendarView.frame = CGRectMake(0, 84, self.frame.size.width, self.frame.size.height-64);
    self.calendarView.calendar.calendarAppearance.weekDayHeight = 55;
    self.calendarView.calendar.calendarAppearance.weekDayTextFont = [UIFont systemFontOfSize:14];
    self.calendarView.calendar.currentDateSelected = [NSDate date];
    [self.calendarView.calendar reloadAppearance];
    self.backgroundColor=[UIColor colorWithRed:47/255.0 green:50/255.0 blue:101/255.0 alpha:1.0];
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 35) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        
        [self removeFromSuperview];
    }
}

#pragma mark -- LTSCalendarEventSource --
- (void)calendarDidLoadPage:(LTSCalendarManager *)calendar{
    self.calendarView.topLabel.text=[NSString stringWithFormat:@"%ld月",calendar.monthForSelectedDay];
}
// 该日期是否有事件
- (BOOL)calendarHaveEvent:(LTSCalendarManager *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    //    NSLog(@"%@,%@",calendar.currentDate,key);
    if(self.eventsByDate[key] && [self.eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}
//当前 选中的日期  执行的方法
- (void)calendarDidDateSelected:(LTSCalendarManager *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    //    self.label.text =  key;
    NSArray *events = self.eventsByDate[key];
    if (events.count>0) {
        self.events=events;
        NSLog(@"打印dic：%@",events.firstObject);
        cellCountIsOne=NO;
    }
    else{
        self.events=[NSArray array];
    }
    [self.calendarView.tableView reloadData];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.events.count==1) {
        cellCountIsOne=YES;
        return 2;
    }
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.calendarView.tableView registerNib:[UINib nibWithNibName:@"CurrentActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    CurrentActivityTableViewCell *cell= [self.calendarView.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.accessoryType=UITableViewCellStyleDefault;
    //cell不能被选中
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row==1&&cellCountIsOne==YES) {
        cell.contentView.hidden=YES;
        cell.backgroundColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0];
        
    }
    else{
        NSDictionary *activity=self.events[indexPath.row];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:activity[@"photo"]]];
        if (activity[@"location"]==[NSNull null]) {
        }
        else{
            cell.addressLB.text=activity[@"location"];
        }
        if (activity[@"activityname"]==[NSNull null]) {
            
        }
        else{
            cell.themeLB.text=activity[@"activityname"];
        }
        NSDate *Date =[self timeWithTimeIntervalString:[activity objectForKey:@"starttime"]];
        NSString *key = [[self dateFormatter] stringFromDate:Date];
        NSDate *Date2 =[self timeWithTimeIntervalString:[activity objectForKey:@"endtime"]];
        NSString *key2 = [[self dateFormatter] stringFromDate:Date2];
        cell.timeLB.text=[NSString stringWithFormat:@"%@~\n%@",key,key2];
        cell.ticketLB.text=[NSString stringWithFormat:@"票价%@",activity[@"price"]];
        if (activity[@"price"]==[NSNull null]) {
            [cell.ticketLB setHidden:YES];
            [cell.saleBtn setHidden:YES];
        }
        else{
            if([activity[@"price"]isEqualToString:@""]){
                [cell.ticketLB setHidden:YES];
                [cell.saleBtn setHidden:YES];
            }
            else{
                [cell.ticketLB setHidden:NO];
                [cell.saleBtn setHidden:NO];
            }
        }
        [cell.edmBtn setTitle:activity[@"tag"] forState:(UIControlStateNormal)];
        //设置空cell的隐藏
        cell.contentView.hidden=NO;
        cell.backgroundColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.obj addActivityDetailView:self.events[indexPath.row]];
    
}



//当tableView 滚动完后  判断位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat startSingleOriginY = self.calendarView.calendar.calendarAppearance.weekDayHeight*5;
    
    self.calendarView.dragEndOffectY  = scrollView.contentOffset.y;
    //<0方向向上 >0 方向向下
    
    //用于判断滑动方向
    CGFloat distance = self.calendarView.dragStartOffectY - self.calendarView.dragEndOffectY;
    
    
    if (self.calendarView.tableView.contentOffset.y > CriticalHeight ) {
        if (self.calendarView.tableView.contentOffset.y < startSingleOriginY) {
            if (self.calendarView.tableView.contentOffset.y > startSingleOriginY-CriticalHeight) {
                [self.calendarView showSingleWeekView:YES];
                return;
            }
            //向下滑动
            if (distance < 0) {
                [self.calendarView showSingleWeekView:YES];
            }
            
            else [self.calendarView showAllView:YES];
        }
        
        
    }
    else if (self.calendarView.tableView.contentOffset.y > 0)
        [self.calendarView showAllView:YES];
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.calendarView.containerView.backgroundColor = self.calendarView.calendar.calendarAppearance.backgroundColor;
    
    CGFloat startSingleOriginY = self.calendarView.calendar.calendarAppearance.weekDayHeight*5;
    
    self.calendarView.dragEndOffectY  = scrollView.contentOffset.y;
    //<0方向向上 >0 方向向下
    CGFloat distance = self.calendarView.dragStartOffectY - self.calendarView.dragEndOffectY;
    
    
    if (self.calendarView.tableView.contentOffset.y>CriticalHeight ) {
        if (self.calendarView.tableView.contentOffset.y<startSingleOriginY) {
            if (self.calendarView.tableView.contentOffset.y>startSingleOriginY - CriticalHeight) {
                [self.calendarView showSingleWeekView:YES];
                return;
            }
            if (distance<0) {
                [self.calendarView showSingleWeekView:YES];
            }
            else [self.calendarView showAllView:YES];
        }
        
        
    }
    else if (self.calendarView.tableView.contentOffset.y > 0)
        [self.calendarView showAllView:YES];
    
    
    
    
}

//当手指 触摸 滚动 就 设置 上一次选择的 跟当前选择的 周 的index 相等
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.calendarView.dragStartOffectY  = scrollView.contentOffset.y;
    self.calendarView.calendar.lastSelectedWeekOfMonth = self.calendarView.calendar.currentSelectedWeekOfMonth;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    CGFloat offectY = scrollView.contentOffset.y;
    
    CGRect contentFrame = self.calendarView.calendar.contentView.frame;
    
    
    //  当 offectY 大于 滚动到要悬浮的位置
    if ( offectY>self.calendarView.calendar.startFrontViewOriginY) {
        
        self.calendarView.containerView.backgroundColor = [UIColor whiteColor];
        contentFrame.origin.y = -self.calendarView.calendar.startFrontViewOriginY;
        
        self.calendarView.calendar.contentView.frame = contentFrame;
        
        //把 selectedView 插入到 containerView 的最上面
        [self.calendarView.containerView insertSubview:self.calendarView.calendar.selectedWeekView atIndex:999];
        // 把tableView 里的 日历视图 插入到 表底部
        [self.calendarView.containerView insertSubview:self.calendarView.calendar.contentView atIndex:0];
        [self.calendarView.calendar setWeekViewHidden:YES toIndex:self.calendarView.calendar.currentSelectedWeekOfMonth-1];
        
    }else{
        self.calendarView.containerView.backgroundColor = self.calendarView.calendar.calendarAppearance.backgroundColor;
        contentFrame.origin.y = 0;
        self.calendarView.calendar.contentView.frame = contentFrame;
        [self.calendarView.calendar setWeekViewHidden:NO toIndex:self.calendarView.calendar.currentSelectedWeekOfMonth-1];
        [self.calendarView.headerView insertSubview:self.calendarView.calendar.selectedWeekView atIndex:1];
        [self.calendarView.headerView insertSubview:self.calendarView.calendar.contentView atIndex:0];
        
    }
    
    
    
}



- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    
    return dateFormatter;
}


@end
