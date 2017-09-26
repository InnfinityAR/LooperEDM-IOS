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
@interface CurrentActivityView()<CurrentActivityTableViewCellDelegate>
{
    UILabel *looperName;
    UILabel *looperName2;
    UILabel *looperName3;
    UIView *lineView;
    //用于判断是否点击了历史活动的按钮
    NSInteger isHistory;
}
@end
@implementation CurrentActivityView
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
-(NSMutableArray *)nearArr{
    if (!_nearArr) {
        NSMutableArray* temp=[[NSMutableArray alloc]init];
        _nearArr=[[NSMutableArray alloc]init];
        for (int i=0; i<self.dataArr.count; i++) {
            NSDictionary *activity=self.dataArr[i];
            //当前时间的时间戳
            NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
            NSInteger timeNow =(long)[datenow timeIntervalSince1970];
            if (timeNow<=[activity[@"starttime"]integerValue]) {
                if([activity[@"recommendation"] intValue]==1){
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
            
            [_nearArr addObject:[testArr objectAtIndex:i]];
        }
    }
    return _nearArr;
}
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andMyData:(NSArray*)myDataSource{
#warning-如果这句话不加则没有初始化view不能触发点击事件
    if (self=[super initWithFrame:frame]) {
        self.obj=(nActivityViewModel*)obj;
        self.dataArr=myDataSource;
        isHistory=0;
        self.frame = CGRectMake( 480*DEF_Adaptation_Font*0.5, 1013*DEF_Adaptation_Font*0.5, 0, 0);
        self.transform = CGAffineTransformMakeScale(0.1,0.1);

               //加载懒加载
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CurrentActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
        [self initView];
        
        [self animation];
    }
    return self;
}
-(void)onClickView:(UITapGestureRecognizer *)tap{
    if (tap.view.tag==1) {
        looperName.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        looperName2.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
         looperName3.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        isHistory=0;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame1=lineView.frame;
            frame1=CGRectMake(179*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame1;
        }];
        [self.tableView reloadData];
    }
    if (tap.view.tag==2) {
        looperName2.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        looperName.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        looperName3.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        isHistory=1;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame2=lineView.frame;
            frame2=CGRectMake(318*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame2;
        }];
        [self.tableView reloadData];
    }
    if (tap.view.tag==3) {
        looperName3.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        looperName2.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        looperName.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        isHistory=2;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame2=lineView.frame;
            frame2=CGRectMake(457*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame2;
        }];
        [self.tableView reloadData];
    }
    if (tap.view.tag==4) {
        SelectCityView *selectV=[[SelectCityView alloc]initWithFrame:self.bounds and:self.obj andDetailDic:nil];
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
    }
    else if(button.tag==102){
   //分享按钮
//        [_obj shareh5View:[_commendArray objectAtIndex:pageIndex]];
    }
}


-(void)initView{
    UILabel *locationLB=[LooperToolClass createLableView:CGPointMake(260*DEF_Adaptation_Font*0.5,48*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andText:@"      上海上海" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    locationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    locationLB.layer.cornerRadius=4*DEF_Adaptation_Font;
    locationLB.layer.masksToBounds=YES;
    locationLB.backgroundColor=ColorRGB(39, 39, 80, 0.8);
    CGSize lblSize3 = [locationLB.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 50*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
    CGRect frame3=locationLB.frame;
    frame3.size.width=lblSize3.width+30*DEF_Adaptation_Font*0.5;
    locationLB.frame=frame3;
    [self addSubview:locationLB];
    locationLB.tag=4;
    locationLB .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap4 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ locationLB addGestureRecognizer:singleTap4];
    
    UIImageView *locationIV=[[UIImageView alloc]initWithFrame:CGRectMake(15*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    locationIV.image=[UIImage imageNamed:@"icon_calendar_location"];
    [locationLB addSubview:locationIV];
    
    looperName = [LooperToolClass createLableView:CGPointMake(159*DEF_Adaptation_Font*0.5,137*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andText:@"全部" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    looperName.font=[UIFont boldSystemFontOfSize:15];
    [self addSubview:looperName];
    looperName.tag=1;
    looperName .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ looperName addGestureRecognizer:singleTap];
    lineView=[[UIView alloc]initWithFrame:CGRectMake(179*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5)];
    lineView.backgroundColor=[UIColor colorWithRed:109/255.0 green:106/255.0 blue:226/255.0 alpha:1.0];
    [self addSubview:lineView];
    looperName2 = [LooperToolClass createLableView:CGPointMake(298*DEF_Adaptation_Font*0.5,137*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andText:@"附近" andFontSize:10 andColor:[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    looperName2.font=[UIFont boldSystemFontOfSize:15];
    [self addSubview:looperName2];
    looperName2.tag=2;
    looperName2 .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ looperName2 addGestureRecognizer:singleTap2];
    
    looperName3 = [LooperToolClass createLableView:CGPointMake(437*DEF_Adaptation_Font*0.5,137*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5) andText:@"历史" andFontSize:10 andColor:[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    looperName3.font=[UIFont boldSystemFontOfSize:15];
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
        
        [_tableView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
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
    if (isHistory==1) {
        return self.historyActivityArr.count;
    }else if (isHistory==2){
        return self.nearArr.count;
    }
    else{
      return self.currentActivityArr.count;
    }
  
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellStyleDefault;
    //cell不能被选中
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *activity=[NSDictionary dictionary];
        if (isHistory==1) {
        activity=self.historyActivityArr[indexPath.row];
    }
        else if (isHistory==2){
            
            activity=self.nearArr[indexPath.row];
        }
        else{
       activity=self.currentActivityArr[indexPath.row];
    }
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:activity[@"photo"]]];
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
        [cell.finishLB setHidden:YES];
    }
    else{
     if([activity[@"price"]isEqualToString:@""]){
        [cell.ticketLB setHidden:YES];
        [cell.saleBtn setHidden:YES];
       
         if (isHistory) {
               [cell.finishLB setHidden:NO];
         }
    }
    else{
        [cell.ticketLB setHidden:NO];
        [cell.saleBtn setHidden:NO];
        if (isHistory) {
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
    if (isHistory) {
         [self.obj addActivityDetailView:self.historyActivityArr[indexPath.row] andPhotoWall:0];
    }else{
          [self.obj addActivityDetailView:self.currentActivityArr[indexPath.row] andPhotoWall:0];
        
    }

//    [self.obj addActivityDetailView:self.dataArr[indexPath.row] andPhotoWall:0];

}

@end
