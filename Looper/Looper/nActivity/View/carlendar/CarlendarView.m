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
#import "LooperConfig.h"
@interface CarlendarView()
{
    NSInteger _year;
}
@end
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
        firstUpdate=NO;
        // 获取各时间字段的数值
        [self createRandomEvents];
        [self lts_InitUI];
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
//        self.calendarView.topLabel.text=[NSString stringWithFormat:@"👈   %@年%@月   👉",[self currentYear:comp.year],[self currentMonth:comp.month]];
//        self.calendarView.topLabel.text=[NSString stringWithFormat:@"%ld年%ld月",comp.year,comp.month];
        self.topLabel.text=[NSString stringWithFormat:@"%ld年%ld月",comp.year,comp.month];
    }
    return self;
}
-(NSString *)currentYear:(NSInteger)year{
    switch (year) {
        case 2015:
            return @"二零一五";
            break;
        case 2016:
            return @"二零一六";
            break;
        case 2017:
            return @"二零一七";
            break;
        case 2018:
            return @"二零一八";
            break;
        case 2019:
            return @"二零一九";
            break;
        default:
            break;
    }
            return nil;
}
-(NSString*)currentMonth:(NSInteger)month{
    
    switch (month) {
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
        NSDate *startDate =[self timeWithTimeIntervalString:[dictionary objectForKey:@"starttime"]];
        NSDate *endDate=[self timeWithTimeIntervalString:[dictionary objectForKey:@"endtime"]];
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|
        NSDayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
        NSInteger startDay= [[cal components:unitFlags fromDate:startDate] day];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
        NSInteger endDay= [[cal components:unitFlags fromDate:endDate] day];
        NSString *key = [[self dateFormatter] stringFromDate:startDate];
        //日历中活动的所有时间都要加点
        for (NSInteger i=0; i<endDay-startDay+1; i++) {
            NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([startDate timeIntervalSinceReferenceDate] + i*24*3600)];
            key = [[self dateFormatter] stringFromDate:newDate];
        if(!self.eventsByDate[key]){
            self.eventsByDate[key] = [NSMutableArray new];
        }
        //        [self.eventsByDate[key] addObject:Date];
        [self.eventsByDate[key]addObject:dictionary];
    }
    }
}

- (NSDate *)timeWithTimeIntervalString:(NSString *)timeString
{
//    NSTimeInterval time=[timeString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[timeString doubleValue];
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

    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,70*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(100*DEF_Adaptation_Font*0.5,80*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    UIButton *goBackBtn = [LooperToolClass createBtnImageNameReal:@"btn_goBack.png" andRect:CGPointMake(150*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(100*DEF_Adaptation_Font*0.5,100*DEF_Adaptation_Font*0.5) andTarget:self];

//    goBackBtn.backgroundColor=[UIColor redColor];
    [self addSubview:goBackBtn];
    UIButton *goDownBtn = [LooperToolClass createBtnImageNameReal:@"btn_goDown.png" andRect:CGPointMake(DEF_WIDTH(self)-250*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andTag:103 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(100*DEF_Adaptation_Font*0.5,100*DEF_Adaptation_Font*0.5) andTarget:self];
    //    goBackBtn.backgroundColor=[UIColor redColor];
    [self addSubview:goDownBtn];
    self.topLabel=[[UILabel alloc]initWithFrame:CGRectMake(220*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, self.bounds.size.width-440*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    self.topLabel.textAlignment=NSTextAlignmentCenter;
    self.topLabel.backgroundColor=[UIColor colorWithRed:47/255.0 green:50/255.0 blue:101/255.0 alpha:1.0];
    self.topLabel.font= [UIFont fontWithName:@"STHeitiTC-Light" size:18.f];
    self.topLabel.textColor=[UIColor whiteColor];
    [self addSubview:self.topLabel];
    self.topLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickTopLB:)];
    [self.topLabel addGestureRecognizer:singleTap];
    
}
-(void)onClickTopLB:(UITapGestureRecognizer *)tap{
    [self.calendarView backToToday];
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
    self.topLabel.text=[NSString stringWithFormat:@"%ld年%ld月",comp.year,comp.month];

}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        [self removeFromSuperview];
    }
    if(button.tag==102){
        //到上一个月
        [self.calendarView.calendar  loadPreviousPage];
    }
    if(button.tag==103){
        //到下一个月
       [self.calendarView.calendar  loadNextPage];
    }

    
}

#pragma mark -- LTSCalendarEventSource --
- (void)calendarDidLoadPage:(LTSCalendarManager *)calendar{
   
    if (firstUpdate==NO) {
//     self.calendarView.topLabel.text=[NSString stringWithFormat:@"%@年%@月",[self currentYear:_year],[self currentMonth:calendar.monthForSelectedDay]];
        self.topLabel.text=[NSString stringWithFormat:@"%ld年%ld月",_year,calendar.monthForSelectedDay];
         firstUpdate=YES;
    }
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
    _year=[[key substringToIndex:4]integerValue];
    if (firstUpdate==YES) {
        self.topLabel.text=[NSString stringWithFormat:@"%ld年%ld月",_year,calendar.monthForSelectedDay];
    }
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
//加入城市的显示
        cell.cityLB.text=[NSString stringWithFormat:@"  %@",[activity objectForKey:@"cname"]];
        CGSize lblSize3 = [cell.cityLB.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 35*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
        CGRect frame3=cell.cityLB.frame;
        frame3.size.width=lblSize3.width+30*DEF_Adaptation_Font*0.5;
        cell.cityLB.frame=frame3;
        
        CGRect frame1=cell.shadowIV.frame;
        frame1.size.width=lblSize3.width;
        cell.shadowIV.frame=frame1;
        
        if (activity[@"location"]==[NSNull null]) {
            
        }
        else if ([activity[@"location"] isEqualToString:@""]){
        cell.addressLB.text=activity[@"city"];
        }
        else{
            cell.addressLB.text=activity[@"location"];
        }
        if (activity[@"activityname"]==[NSNull null]) {
            
        }
        else{
            cell.themeLB.text=activity[@"activityname"];
        }
        NSString *starttime=[[self timeChange:activity[@"starttime"]]substringToIndex:10];
        NSString *endtime=[[self timeChange:activity[@"endtime"]]substringToIndex:10];
        NSString *dateTime=nil;
        if ([[starttime substringFromIndex:8]integerValue]==[[endtime substringFromIndex:8]integerValue]) {
            dateTime=starttime;
            cell.timeLB.text=dateTime;
        }
        else{
            cell.timeLB.text=[NSString stringWithFormat:@"%@~%@",starttime,[endtime substringFromIndex:5]];
        }
        cell.ticketLB.text=[NSString stringWithFormat:@"%@",activity[@"price"]];
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
                if ([activity objectForKey:@"ticketurl"]==[NSNull null]||[[activity objectForKey:@"ticketurl"]isEqualToString:@""]) {
                    cell.saleBtn.layer.borderColor=[UIColor colorWithRed:170.0/255.0 green:172.0/255.0 blue:194.0/255.0 alpha:1.0].CGColor;
                    [cell.saleBtn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:172.0/255.0 blue:194.0/255.0 alpha:1.0] forState:(UIControlStateNormal)];
                    [cell.saleBtn setTitle:@"票价" forState:(UIControlStateNormal)];
                }else{
                    cell.saleBtn.layer.borderColor=[UIColor colorWithRed:24.0/255.0 green:163.0/255.0 blue:170.0/255.0 alpha:1.0].CGColor;
                    [cell.saleBtn setTitleColor:[UIColor colorWithRed:190.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forState:(UIControlStateNormal)];
                    [cell.saleBtn setTitle:@"售票" forState:(UIControlStateNormal)];
                    cell.saleBtn.tag=indexPath.row;
                }
                [cell.finishLB setHidden:YES];
                
                //如果是历史任务就修改UI
                NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
                NSInteger timeNow =(long)[datenow timeIntervalSince1970];
                if (timeNow>[activity[@"endtime"]integerValue]) {
                    [cell.saleBtn setHidden:YES];
                    [cell.finishLB setHidden:NO];
                    [cell.ticketLB setHidden:YES];
                    
                }else{
//                    NSLog(@"endTime %@ timeNow %ld",activity[@"endtime"],timeNow);
                }

            }
        }
        [cell.edmBtn setTitle:[NSString stringWithFormat:@"    %@    " ,activity[@"tag"] ]forState:(UIControlStateNormal)];
        //设置空cell的隐藏
        cell.contentView.hidden=NO;
        cell.backgroundColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0];
    }
    return cell;
    
}
//时间戳转换
-(NSString *)timeChange:(NSString *)timeDate{
    NSString*str=timeDate;//时间戳
    
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.obj addActivityDetailView:self.events[indexPath.row]andPhotoWall:0];
    
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
