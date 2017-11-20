//
//  TicketDetailView.m
//  Looper
//
//  Created by 工作 on 2017/8/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "TicketDetailView.h"
#import "MainViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "TicketLogisticsView.h"
#import "AliManagerData.h"
@interface TicketDetailView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)NSInteger type;
@property(nonatomic,strong)NSArray *myData;
@property(nonatomic,strong)UITableView *tableView;
@end
@implementation TicketDetailView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 110*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-110*DEF_Adaptation_Font*0.5) style:(UITableViewStylePlain)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        _tableView.alwaysBounceVertical=YES;
        [self addSubview:_tableView];
    }
    return    _tableView;
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andMyData:(NSArray*)myDataSource andType:(NSInteger)type{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
        self.myData = myDataSource;
        self.type=type;
        [self initView];
    }
    return self;
}
-(void)initView{
    [self creatBKView];
    self.tableView.backgroundColor=[UIColor clearColor];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if (button.tag==99) {
        [self removeFromSuperview];
    }
    if (button.tag>=100) {
//去支付的按钮
         [AliManagerData doAlipayPay:_myData[button.tag-100]];
    }
}

-(void)creatBKView{
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:99 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:99 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
  UILabel  *titleLB = [LooperToolClass createLableView:CGPointMake(258*DEF_Adaptation_Font*0.5,64*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andText:@"订单详情" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [self addSubview:titleLB];
}


-(NSString *)setSelecttime:(NSDictionary *)dictionary{
    NSDate *startDate =[self timeWithTimeIntervalString:[dictionary objectForKey:@"starttime"]];
    NSDate *endDate=[self timeWithTimeIntervalString:[dictionary objectForKey:@"endtime"]];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    NSDateComponents *startcomp=[cal components:unitFlags fromDate:startDate];
    NSDateComponents *endcomp=[cal components:unitFlags fromDate:endDate];
    //    NSMutableArray *dateArr=[[NSMutableArray alloc]init];
    //    for (NSInteger i=[startcomp day]; i<=[endcomp day]; i++) {
    //        [dateArr addObject:[NSString stringWithFormat:@"%ld年%ld月%ld号",[startcomp year],[startcomp month],i]];
    //    }
    if ([startcomp day]==[endcomp day]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:startDate];
        return currentDateString;
    }
    NSString *dataStr=[NSString stringWithFormat:@"%ld年%ld月%ld号-%ld月%ld号",[startcomp year],[startcomp month],[startcomp day],[endcomp month],[endcomp day]];
    return dataStr;
}
- (NSDate *)timeWithTimeIntervalString:(NSString *)timeString
{
    //    NSTimeInterval time=[timeString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[timeString doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    return  detaildate;
}

#pragma-UITableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDic=self.myData[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (self.type==1) {
        [self creatTableViewCell:cell andIndex:indexPath andDataDic:dataDic];
    }else{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(41*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 162*DEF_Adaptation_Font*0.5, 162*DEF_Adaptation_Font*0.5)];
            NSString *dataStr=[dataDic objectForKey:@"commodityimageurl"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[dataStr componentsSeparatedByString:@","][0]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
    [cell.contentView addSubview:imageView];
    
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 380*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    contentLB.text=[dataDic objectForKey:@"commodityname"];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:18];
    CGSize lblSize = [contentLB.text boundingRectWithSize:CGSizeMake(380*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    CGRect frame=contentLB.frame;
    frame.size.height=lblSize.height;
    contentLB.frame=frame;
    [cell.contentView addSubview:contentLB];
    
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, 110*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    timeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    timeLB.text=[self setSelecttime:dataDic];
    CGSize lblSize1 = [timeLB.text boundingRectWithSize:CGSizeMake(400*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
    CGRect frame1=timeLB.frame;
    frame1.size=lblSize1;
    timeLB.frame=frame1;
    timeLB.numberOfLines=1;
    timeLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [cell.contentView addSubview:timeLB];
    
    UILabel *priceLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+20*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    priceLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    priceLB.text= [NSString stringWithFormat:@"积分:%d   ×%@    共计%d积分",[[dataDic objectForKey:@"credit"]intValue]/[[dataDic objectForKey:@"number"]intValue],[dataDic objectForKey:@"number"],[[dataDic objectForKey:@"credit"]intValue]];
    CGSize lblSize3 = [priceLB.text boundingRectWithSize:CGSizeMake(400*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
    CGRect frame3=priceLB.frame;
    frame3.size=lblSize3;
    priceLB.frame=frame3;
    priceLB.numberOfLines=0;
    priceLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [cell.contentView addSubview:priceLB];
    
    if ([[dataDic objectForKey:@"orderstatus"]intValue]==0) {
        UILabel *paySuccessLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, DEF_Y(priceLB)+DEF_HEIGHT(priceLB)+20*DEF_Adaptation_Font*0.5, 156*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        paySuccessLB.font=[UIFont systemFontOfSize:14];
        paySuccessLB.text=@"已支付";
        paySuccessLB.textColor=ColorRGB(181, 252, 255, 1.0);
        paySuccessLB.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:paySuccessLB];
    }
    }
    return cell;
    
}
-(void)creatTableViewCell:(UITableViewCell *)cell andIndex:(NSIndexPath *)indexPath andDataDic:(NSDictionary *)dataDic{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(41*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 162*DEF_Adaptation_Font*0.5, 162*DEF_Adaptation_Font*0.5)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"productimage"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [cell.contentView addSubview:imageView];
    
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 380*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    contentLB.text=[dataDic objectForKey:@"productname"];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:18];
    CGSize lblSize = [contentLB.text boundingRectWithSize:CGSizeMake(380*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    CGRect frame=contentLB.frame;
    frame.size.height=lblSize.height;
    contentLB.frame=frame;
    [cell.contentView addSubview:contentLB];
    
    UILabel *locationLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 380*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    locationLB.numberOfLines=1;
    locationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    locationLB.text=[dataDic objectForKey:@"location"];
    locationLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [cell.contentView addSubview:locationLB];
    
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, DEF_Y(locationLB)+DEF_HEIGHT(locationLB)+22*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    timeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    timeLB.text=[self setSelecttime:dataDic];
    CGSize lblSize1 = [timeLB.text boundingRectWithSize:CGSizeMake(400*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
    CGRect frame1=timeLB.frame;
    frame1.size=lblSize1;
    timeLB.frame=frame1;
    timeLB.numberOfLines=1;
    timeLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [cell.contentView addSubview:timeLB];
    
    UILabel *priceLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+20*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    priceLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    priceLB.text= [NSString stringWithFormat:@"票价:%d   ×%@    共计%d元",[[dataDic objectForKey:@"price"]intValue]/[[dataDic objectForKey:@"number"]intValue],[dataDic objectForKey:@"number"],[[dataDic objectForKey:@"price"]intValue]];
    CGSize lblSize3 = [priceLB.text boundingRectWithSize:CGSizeMake(400*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
    CGRect frame3=priceLB.frame;
    frame3.size=lblSize3;
    priceLB.frame=frame3;
    priceLB.numberOfLines=0;
    priceLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [cell.contentView addSubview:priceLB];
    
    if ([[dataDic objectForKey:@"orderstatus"]intValue]==1) {
        UILabel *paySuccessLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, DEF_Y(priceLB)+DEF_HEIGHT(priceLB)+20*DEF_Adaptation_Font*0.5, 156*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        paySuccessLB.font=[UIFont systemFontOfSize:14];
        paySuccessLB.text=[self orderstatusForCount:[[dataDic objectForKey:@"orderstatus"]integerValue]];
        paySuccessLB.textColor=ColorRGB(181, 252, 255, 1.0);
        paySuccessLB.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:paySuccessLB];
    }else if([[dataDic objectForKey:@"orderstatus"]intValue]==0){
        UIButton *payBtn=[self publishButton:[self orderstatusForCount:[[dataDic objectForKey:@"orderstatus"]integerValue]] andCGPoint:CGPointMake(237*DEF_Adaptation_Font*0.5, DEF_Y(priceLB)+DEF_HEIGHT(priceLB)+20*DEF_Adaptation_Font*0.5) andTag:100+indexPath.row];
        [cell.contentView addSubview:payBtn];
    }else{
        UILabel *paySuccessLB=[[UILabel alloc]initWithFrame:CGRectMake(237*DEF_Adaptation_Font*0.5, DEF_Y(priceLB)+DEF_HEIGHT(priceLB)+20*DEF_Adaptation_Font*0.5, 156*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        paySuccessLB.font=[UIFont systemFontOfSize:14];
        paySuccessLB.text=[self orderstatusForCount:[[dataDic objectForKey:@"orderstatus"]integerValue]];
        paySuccessLB.textColor=ColorRGB(255, 106, 148, 1.0);
        paySuccessLB.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:paySuccessLB];
    }

}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type==2) {
        return 300*DEF_Adaptation_Font*0.5;
    }
    return 360*DEF_Adaptation_Font*0.5;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDic=self.myData[indexPath.row];
    if (self.type==1) {
    if ([[dataDic objectForKey:@"orderstatus"]intValue]==2) {
       [AliManagerData doAlipayPay:_myData[indexPath.row]];
    }else{
    TicketLogisticsView *ticketView=[[TicketLogisticsView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self.obj andMyData:self.myData[indexPath.row]andType:1];
    [self addSubview:ticketView];
    }
    }else{
        TicketLogisticsView *ticketView=[[TicketLogisticsView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self.obj andMyData:self.myData[indexPath.row]andType:2];
        [self addSubview:ticketView];
    }
}
-(UIButton *)publishButton:(NSString *)str andCGPoint:(CGPoint)point andTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    //对按钮的外形做了设定，不喜可删~
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [ColorRGB(42, 195, 192, 1.0)CGColor];
    btn.layer.cornerRadius = 3;
    btn.tag=tag;
    [btn setTitleColor:ColorRGB(42, 195, 192, 1.0) forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    //重要的是下面这部分哦！
    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
    
    titleSize.height = 40*DEF_Adaptation_Font*0.5;
    titleSize.width=108*DEF_Adaptation_Font*0.5;
    
    btn.frame = CGRectMake(point.x, point.y, titleSize.width, titleSize.height);
    return btn;
    
}
-(NSString *)orderstatusForCount:(NSInteger)count{
    if (count==0) {
        return @"去支付";
    }
    if (count==1) {
        return @"已支付";
    }
    if (count==2) {
        return @"支付失败";
    }
    return @"删除";
}
@end
