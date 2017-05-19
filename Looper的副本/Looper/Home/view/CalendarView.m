//
//  CalendarView.m
//  Looper
//
//  Created by lujiawei on 1/7/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "CalendarView.h"
#import "HomeViewModel.h"
#import "GFCalendar.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"


@implementation CalendarView{

    UITableView *tableView;
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (HomeViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
}

-(void)createBk{

    UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk1  setBackgroundColor:[UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:44.0/255.0 alpha:0.6]];
    [self addSubview:bk1];

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

     [_obj removeCalendar];
    
    
}



-(void)initView{
    
    [self createBk];
    
    CGFloat width = self.bounds.size.width - 20.0;
    CGPoint origin = CGPointMake(17*DEF_Adaptation_Font*0.5,72*DEF_Adaptation_Font*0.5);
    
    GFCalendarView *calendar = [[GFCalendarView alloc] initWithFrameOrigin:origin width:width];
    
    // 点击某一天的回调
    calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        
        [tableView removeFromSuperview];
        
        if(day==7){
            [self createTableView];
            }
    };
    
    [self addSubview:calendar];
   
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"icon_calendar_close.png" andRect:CGPointMake(33, 89) andTag:100 andSelectImage:@"icon_calendar_close.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:closeBtn];
    

    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    [_obj removeCalendar];
    
}



-(void)createTableView{
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(27*0.5*DEF_Adaptation_Font, 640*0.5*DEF_Adaptation_Font,590*DEF_Adaptation_Font_x*0.5, 200*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  118*DEF_Adaptation_Font*0.5;
    
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    UIImageView *IMAGE  = [[UIImageView alloc] initWithFrame:CGRectMake(3*0.5*DEF_Adaptation_Font,20*0.5*DEF_Adaptation_Font, 76*0.5*DEF_Adaptation_Font, 76*0.5*DEF_Adaptation_Font)];
    IMAGE.backgroundColor=[UIColor grayColor];
    IMAGE.layer.cornerRadius = 6*DEF_Adaptation_Font*0.5;
    [cell addSubview:IMAGE];
    
    UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(101*DEF_Adaptation_Font_x*0.5, 20*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(277*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:@"百威风暴电音节" andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [cell addSubview:titleNum];
    
    
    UILabel *timeNum = [LooperToolClass createLableView:CGPointMake(127*DEF_Adaptation_Font_x*0.5, 55*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(116*DEF_Adaptation_Font_x*0.5, 22*DEF_Adaptation_Font_x*0.5) andText:@"14:00-22:00" andFontSize:10 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [cell addSubview:timeNum];
    
    
    UILabel *localNum = [LooperToolClass createLableView:CGPointMake(127*DEF_Adaptation_Font_x*0.5, 76*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(186*DEF_Adaptation_Font_x*0.5, 22*DEF_Adaptation_Font_x*0.5) andText:@"上海市 " andFontSize:10 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [cell addSubview:localNum];
    
    
    UIImageView *clockSp =[LooperToolClass createImageView:@"icon_calendar_clock.png" andRect:CGPointMake(101, 55) andTag:100 andSize:CGSizeZero andIsRadius:false];
    
    [cell addSubview:clockSp];
    
    UIImageView *locationSp =[LooperToolClass createImageView:@"icon_calendar_location.png" andRect:CGPointMake(101, 80) andTag:100 andSize:CGSizeZero andIsRadius:false];
    
    [cell addSubview:locationSp];
    
    
    UIImageView *hotSp =[LooperToolClass createImageView:@"icon_calendar_hot.png" andRect:CGPointMake(477, 59) andTag:100 andSize:CGSizeZero andIsRadius:false];
    
    [cell addSubview:hotSp];

    
    UILabel *hotNum = [LooperToolClass createLableView:CGPointMake(465*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(186*DEF_Adaptation_Font_x*0.5, 22*DEF_Adaptation_Font_x*0.5) andText:@"10万＋" andFontSize:10 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [cell addSubview:hotNum];

    UIImageView *lineSp1 =[LooperToolClass createImageView:@"icon_calendar_line.png" andRect:CGPointMake(0, 116) andTag:100 andSize:CGSizeZero andIsRadius:false];
    
    [cell addSubview:lineSp1];
    
 
    return cell;
}




@end
