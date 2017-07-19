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
@interface CurrentActivityView()
{
    UILabel *looperName;
    UILabel *looperName2;
    UIView *lineView;
    //用于判断是否点击了历史活动的按钮
    BOOL isHistory;
}
@end
@implementation CurrentActivityView
//更新tableview
-(void)reloadTableData:(NSMutableArray*)DataLoop{
    self.dataArr=DataLoop;
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
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andMyData:(NSArray*)myDataSource{
#warning-如果这句话不加则没有初始化view不能触发点击事件
    if (self=[super initWithFrame:frame]) {
        self.obj=(nActivityViewModel*)obj;
        self.dataArr=myDataSource;
        isHistory=NO;
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
        isHistory=NO;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame=CGRectMake(240*DEF_Adaptation_Font*0.5, 137*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame;
        }];
        [self.tableView reloadData];
    }
    if (tap.view.tag==2) {
        looperName2.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        looperName.textColor=[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0];
        isHistory=YES;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame=CGRectMake(390*DEF_Adaptation_Font*0.5, 137*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5);
            lineView.frame=frame;
        }];
        [self.tableView reloadData];
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
}


-(void)initView{
    looperName = [LooperToolClass createLableView:CGPointMake(200*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(150*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"全部活动" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    looperName.font=[UIFont boldSystemFontOfSize:15];
    [self addSubview:looperName];
    looperName.tag=1;
    looperName .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ looperName addGestureRecognizer:singleTap];
    lineView=[[UIView alloc]initWithFrame:CGRectMake(240*DEF_Adaptation_Font*0.5, 137*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5)];
    lineView.backgroundColor=[UIColor colorWithRed:109/255.0 green:106/255.0 blue:226/255.0 alpha:1.0];
    [self addSubview:lineView];
    looperName2 = [LooperToolClass createLableView:CGPointMake(350*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(152*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"历史活动" andFontSize:10 andColor:[UIColor colorWithRed:176/255.0 green:174/255.0 blue:187/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:looperName2];
    looperName2.tag=2;
    looperName2 .userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [ looperName2 addGestureRecognizer:singleTap2];
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(-20*DEF_Adaptation_Font*0.5,-10*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(188*DEF_Adaptation_Font*0.5,143*DEF_Adaptation_Font*0.5) andTarget:self];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"hotActivity.png"] forState:UIControlStateNormal];
    [self addSubview:backBtn];

    UIButton *calendarBtn = [LooperToolClass createBtnImageNameReal:@"btn_calendar_s.png" andRect:CGPointMake(508*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTag:119 andSelectImage:@"btn_calendar_s.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(35*DEF_Adaptation_Font*0.5,35*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:calendarBtn];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger day = [dateComponent day];
    
    UILabel* dayLabel = [LooperToolClass createLableView:CGPointMake(514*DEF_Adaptation_Font*0.5, 59*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(25*DEF_Adaptation_Font*0.5, 18*DEF_Adaptation_Font*0.5) andText:[NSString stringWithFormat:@"%ld",day] andFontSize:10  andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [self addSubview:dayLabel];
    [self setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];

}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 142*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT- 140*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
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
    if (isHistory) {
        return self.historyActivityArr.count;
    }
    return self.dataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellStyleDefault;
    //cell不能被选中
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *activity=self.dataArr[indexPath.row];
    if (isHistory) {
        activity=self.historyActivityArr[indexPath.row];
    }
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
    }
    }
    [cell.edmBtn setTitle:[NSString stringWithFormat:@"    %@    " ,activity[@"tag"] ]forState:(UIControlStateNormal)];
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
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.obj addActivityDetailView:self.dataArr[indexPath.row] andPhotoWall:0];

}

@end
