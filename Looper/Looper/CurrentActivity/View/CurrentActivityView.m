//
//  CurrentActivityView.m
//  Looper
//
//  Created by 工作 on 2017/5/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "CurrentActivityView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "CurrentActivityTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "nActivityViewModel.h"
#import "CarlendarView.h"
#import "SelectCityView.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerData.h"
@interface CurrentActivityView()<CurrentActivityTableViewCellDelegate>
{
    UILabel *looperName;
    UILabel *looperName3;
    UIView *lineView;
    //用于判断是否点击了历史活动的按钮
    NSInteger isHistory;
    
}
@property (nonatomic, strong) CLGeocoder *geoC;
@property(nonatomic,strong)NSMutableDictionary *detailDic;
@end
@implementation CurrentActivityView
-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}
//更新tableview
-(void)reloadTableData:(NSMutableArray*)DataLoop{
    self.dataArr=DataLoop;
  [_currentActivityArr removeAllObjects];
  [_historyActivityArr removeAllObjects];
    [self.tableView reloadData];
}
-(NSMutableArray *)historyActivityArr{
    if (!_historyActivityArr) {
        _historyActivityArr=[[NSMutableArray alloc]init];
        for (int i=0; i<self.dataArr.count; i++) {
            NSDictionary *activity=self.dataArr[i];
            //当前时间的时间戳
            NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
            NSInteger timeNow =(long)[datenow timeIntervalSince1970];
            if (timeNow>[activity[@"endtime"]integerValue]) {
                [_historyActivityArr addObject:activity];
            }
        }
    }
    return _historyActivityArr;
}

-(NSMutableDictionary *)detailDic{
    if (!_detailDic) {
        _detailDic=[[NSMutableDictionary alloc]init];
      [_detailDic setObject:@"上海" forKey:@"currentCity"];
    }
    return _detailDic;
}

-(NSMutableArray *)currentActivityArr{
  
    if (!_currentActivityArr) {
          NSMutableArray* temp=[[NSMutableArray alloc]init];
        _currentActivityArr=[[NSMutableArray alloc]init];
    
        for (int i=0; i<self.dataArr.count; i++) {
            NSDictionary *activity=self.dataArr[i];
            //当前时间的时间戳
            NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
            NSInteger timeNow =(long)[datenow timeIntervalSince1970];
            if (timeNow<=[activity[@"starttime"]integerValue]) {
                if([activity[@"recommendation"] intValue]==1){
                
                [_currentActivityArr addObject:activity];
            } else{
                [temp addObject:activity];
            }

            }
        }
        NSArray *testArr = [temp sortedArrayWithOptions:NSSortStable usingComparator:
                            ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                                int value1 = [[obj1 objectForKey:@"starttime"] intValue];
                                int value2 = [[obj2 objectForKey:@"starttime"] intValue];
                                if (value1 > value2) {
                                    return NSOrderedDescending;
                                }else if (value1 == value2){
                                    return NSOrderedSame;
                                }else{
                                    return NSOrderedAscending;
                                }
                            }];
        
        
        NSLog(@"%@",testArr);
        
        for(int i=0;i<[testArr count];i++){
            
            [_currentActivityArr addObject:[testArr objectAtIndex:i]];
        }
    }
    return _currentActivityArr;
}

-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andMyData:(NSArray*)myDataSource{
#warning-如果这句话不加则没有初始化view不能触发点击事件
    if (self=[super initWithFrame:frame]) {
        self.obj=(nActivityViewModel*)obj;
        self.dataArr=myDataSource;
        isHistory=1;
        self.frame = CGRectMake( 480*DEF_Adaptation_Font*0.5, 1013*DEF_Adaptation_Font*0.5, 0, 0);
        self.transform = CGAffineTransformMakeScale(0.1,0.1);
               //加载懒加载
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CurrentActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
        [self initView];
        [self creatLocationCity];
        [self animation];
    }
    return self;
}
-(void)onClickView:(UITapGestureRecognizer *)tap{
    if (tap.view.tag==1) {
        _locationLB.tag=2;
        looperName.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _locationLB.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
         looperName3.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        isHistory=1;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame1=lineView.frame;
            frame1=CGRectMake(179*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame1;
        }];
        [self.tableView reloadData];
    }
  else  if (tap.view.tag==2) {
          _locationLB.tag=4;
        _locationLB.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        looperName.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        looperName3.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        isHistory=2;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame2=lineView.frame;
            frame2=CGRectMake(320*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame2;
        }];
        [self.tableView reloadData];
    }
  else  if (tap.view.tag==3) {
          _locationLB.tag=2;
        looperName3.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _locationLB.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        looperName.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        isHistory=0;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame2=lineView.frame;
            frame2=CGRectMake(378*DEF_Adaptation_Font*0.5+DEF_WIDTH(_locationLB), 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame2;
        }];
        [self.tableView reloadData];
    }
 else   if (tap.view.tag==4) {
        SelectCityView *selectV=[[SelectCityView alloc]initWithFrame:self.bounds and:self andDetailDic:self.detailDic andCityArr:self.cityArr];
        [self addSubview:selectV];
    }

}
-(void)animation{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0,1.0);
         self.frame = CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        
        
        
    }];

}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag ==100){
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeScale(0.1,0.1);
            self.frame = CGRectMake( 480*DEF_Adaptation_Font*0.5, 1013*DEF_Adaptation_Font*0.5, 0, 0);
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
        }];
        
    }
    if(button.tag==119){
        CarlendarView *carlendarV=[[CarlendarView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)andData:self.dataArr andObj:self.obj];
        [self addSubview:carlendarV];
    }
    if (button.tag==120) {
    //搜索按钮点击
        
        [self.obj createSerachView];
        
        
        
    }
    else if(button.tag==102){
   //分享按钮
        [_obj shareAllH5View];
    }
}


-(void)initView{
    _locationLB= [LooperToolClass createLableView:CGPointMake(298*DEF_Adaptation_Font*0.5,137*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andText:@"上海" andFontSize:10 andColor:[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    _locationLB.font=[UIFont boldSystemFontOfSize:13];
    _locationLB.textAlignment=NSTextAlignmentRight;
    CGSize lblSize3 = [_locationLB.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGRect frame3=_locationLB.frame;
    frame3.size.width=lblSize3.width+26*DEF_Adaptation_Font*0.5;
    _locationLB.frame=frame3;
    [self addSubview:_locationLB];
    _locationLB.tag=2;
    _locationLB .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap4 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ _locationLB addGestureRecognizer:singleTap4];
    UIImageView *locationIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 6*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    locationIV.image=[UIImage imageNamed:@"icon_calendar_location"];
    [_locationLB addSubview:locationIV];
    
    looperName = [LooperToolClass createLableView:CGPointMake(159*DEF_Adaptation_Font*0.5,137*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andText:@"全部" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    looperName.font=[UIFont boldSystemFontOfSize:13];
    [self addSubview:looperName];
    looperName.tag=1;
    looperName .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ looperName addGestureRecognizer:singleTap];
    lineView=[[UIView alloc]initWithFrame:CGRectMake(179*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5)];
    lineView.backgroundColor=[UIColor colorWithRed:109/255.0 green:106/255.0 blue:226/255.0 alpha:1.0];
    [self addSubview:lineView];
    
    looperName3 = [LooperToolClass createLableView:CGPointMake(358*DEF_Adaptation_Font*0.5+DEF_WIDTH(_locationLB),137*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andText:@"历史" andFontSize:10 andColor:[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    looperName3.font=[UIFont boldSystemFontOfSize:13];
    [self addSubview:looperName3];
    looperName3.tag=3;
    looperName3 .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ looperName3 addGestureRecognizer:singleTap3];
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(-20*DEF_Adaptation_Font*0.5,-10*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(188*DEF_Adaptation_Font*0.5,143*DEF_Adaptation_Font*0.5) andTarget:self];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"hotActivity.png"] forState:UIControlStateNormal];
    [self addSubview:backBtn];

    UIButton *calendarBtn = [LooperToolClass createBtnImageNameReal:@"btn_calendar_s.png" andRect:CGPointMake(508*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andTag:119 andSelectImage:@"btn_calendar_s.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(35*DEF_Adaptation_Font*0.5,35*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:calendarBtn];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger day = [dateComponent day];
    
    UILabel* dayLabel = [LooperToolClass createLableView:CGPointMake(513*DEF_Adaptation_Font*0.5, 63*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(25*DEF_Adaptation_Font*0.5, 18*DEF_Adaptation_Font*0.5) andText:[NSString stringWithFormat:@"%ld",day] andFontSize:9  andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [self addSubview:dayLabel];
    [self setBackgroundColor:[UIColor colorWithRed:25/255.0 green:26/255.0 blue:63/255.0 alpha:1.0]];
    
    UIButton *searchBtn = [LooperToolClass createBtnImageNameReal:@"chatlist_serach" andRect:CGPointMake(156*DEF_Adaptation_Font*0.5,48*DEF_Adaptation_Font*0.5) andTag:120 andSelectImage:@"chatlist_serach" andClickImage:nil andTextStr:nil andSize:CGSizeMake(80*DEF_Adaptation_Font*0.5,56*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:searchBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];

}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 185*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT- 185*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //禁止上拉
        
        [_tableView setBackgroundColor:[UIColor colorWithRed:25/255.0 green:26/255.0 blue:63/255.0 alpha:1.0]];
        _tableView.alwaysBounceVertical=NO;
        _tableView.bounces=NO;
        //设置分割线
        _tableView.separatorColor = [UIColor colorWithRed:64/255.0 green:62/255.0 blue:162/255.0 alpha:0.4];
        _tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);        // 设置端距，这里表示separator离左边和右边均1像素
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    }
    return _tableView;
}
#pragma-UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isHistory==0) {
        if (self.historyActivityArr.count==0) {
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else{
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        return self.historyActivityArr.count;
    }else if (isHistory==2){
        if (self.nearArr.count==0) {
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else{
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        return self.nearArr.count;
    }
    else{
        if (self.currentActivityArr.count==0) {
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else{
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
      return self.currentActivityArr.count;
    }
  
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.accessoryType=UITableViewCellStyleDefault;
    //cell不能被选中
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *activity=[NSDictionary dictionary];
        if (isHistory==0) {
        activity=self.historyActivityArr[indexPath.row];
    }
        else if (isHistory==2){
            
            activity=self.nearArr[indexPath.row];
        }
        else{
       activity=self.currentActivityArr[indexPath.row];
    }
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:activity[@"photo"]]];
   
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
    else if ([activity[@"place"] isEqualToString:@""]){
        cell.addressLB.text=activity[@"city"];
    }
    else{
     cell.addressLB.text=activity[@"place"];
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
//        cell.timeLB.text=dateTime;
        cell.timeLB.text=[activity objectForKey:@"timetag"];
    }
    else{
//    cell.timeLB.text=[NSString stringWithFormat:@"%@~%@",starttime,[endtime substringFromIndex:5]];
         cell.timeLB.text=[activity objectForKey:@"timetag"];
    }
       cell.ticketLB.text=[NSString stringWithFormat:@"%@",activity[@"price"]];
    if (activity[@"price"]==[NSNull null]) {
        [cell.ticketLB setHidden:YES];
        [cell.saleBtn setHidden:YES];
        [cell.finishLB setHidden:YES];
    }
    else{
     if([activity[@"price"]isEqualToString:@""]){
        [cell.ticketLB setHidden:YES];
        [cell.saleBtn setHidden:YES];
       
         if (isHistory==0) {
               [cell.finishLB setHidden:NO];
         }
    }
    else{
        [cell.ticketLB setHidden:NO];
        [cell.saleBtn setHidden:NO];
        if (isHistory==0) {
//            cell.saleBtn.layer.borderColor=[UIColor colorWithRed:170.0/255.0 green:172.0/255.0 blue:194.0/255.0 alpha:1.0].CGColor;
//            [cell.saleBtn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:172.0/255.0 blue:194.0/255.0 alpha:1.0] forState:(UIControlStateNormal)];
//            [cell.saleBtn setTitle:@"票价" forState:(UIControlStateNormal)];
            [cell.saleBtn setHidden:YES];
             [cell.finishLB setHidden:NO];
            [cell.ticketLB setHidden:YES];
        }else{
            [cell.saleBtn setHidden:NO];
            [cell.ticketLB setHidden:NO];
           
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
        }
    }
    }
    [cell.edmBtn setTitle:[NSString stringWithFormat:@"    %@    " ,activity[@"tag"] ]forState:(UIControlStateNormal)];
    cell.activityDelegate = self;
    return cell;
    
}

- (void)testBtn:(UIButton *)btn{
//      NSDictionary *activity=self.currentActivityArr[btn.tag];
//    NSString *ticketURL= [activity objectForKey:@"ticketurl"];
    
}
//时间戳转换
-(NSString *)timeChange:(NSString *)timeDate{
    NSString*str=timeDate;//时间戳
    
//    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[str doubleValue];
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;

}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isHistory==0) {
         [self.obj addActivityDetailView:self.historyActivityArr[indexPath.row] andPhotoWall:0];
    }else if (isHistory==2){
         [self.obj addActivityDetailView:self.nearArr[indexPath.row] andPhotoWall:0];
    }
    else{
          [self.obj addActivityDetailView:self.currentActivityArr[indexPath.row] andPhotoWall:0];
        
    }

//    [self.obj addActivityDetailView:self.dataArr[indexPath.row] andPhotoWall:0];

}

-(void)reloadTableDataWithCity:(NSString *)city{
    CGRect frame2=looperName3.frame;
    frame2.origin.x=358*DEF_Adaptation_Font*0.5+DEF_WIDTH(_locationLB);
    looperName3.frame=frame2;
    [self.obj getOfflineInformationByCity:city];
    
}
-(void)reloadTableDataWithNearArr:(NSArray *)nearArr{
    self.nearArr=nearArr;
      _locationLB.tag=4;
    isHistory=2;
    _locationLB.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    looperName.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
    looperName3.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
    CGRect frame2=lineView.frame;
    frame2=CGRectMake(320*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
    lineView.frame=frame2;
    [self.tableView reloadData];
    
}
-(void)creatLocationCity{
    double latitude = [LocationManagerData sharedManager].LocationPoint_xy.y;
    double longitude = [LocationManagerData sharedManager].LocationPoint_xy.x;

    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray
    *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                             objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults
      standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",
                                       nil] forKey:@"AppleLanguages"];
    // 反地理编码(经纬度---地址)
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            CLPlacemark *pl = [placemarks firstObject];
            _locationLB.text=[NSString stringWithFormat:@"   %@",[pl.locality substringToIndex:pl.locality.length-1]];
            CGSize lblSize3 = [_locationLB.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            CGRect frame3=_locationLB.frame;
            frame3.size.width=lblSize3.width+6*DEF_Adaptation_Font*0.5;
            _locationLB.frame=frame3;
            
            CGRect frame2=looperName3.frame;
            frame2.origin.x=358*DEF_Adaptation_Font*0.5+DEF_WIDTH(_locationLB);
            looperName3.frame=frame2;
            
              [self.detailDic setObject:[pl.locality substringToIndex:pl.locality.length-1] forKey:@"currentCity"];
        }else
        {
            NSLog(@"错误");
        }
        // 还原Device 的语言
        [[NSUserDefaults
          standardUserDefaults] setObject:userDefaultLanguages
         forKey:@"AppleLanguages"];
    }];

}

@end
