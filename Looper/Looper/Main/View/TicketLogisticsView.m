//
//  TicketLogisticsView.m
//  Looper
//
//  Created by 工作 on 2017/8/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "TicketLogisticsView.h"
#import "MainViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "AttenceTimelineCell.h"
@interface TicketLogisticsView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *contentScroll;

@property(nonatomic,strong)UITableView *logiDetailView;

@end
@implementation TicketLogisticsView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andMyData:(NSDictionary*)myDataSource{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
//从历史订单过来，self.obj才不是空的
        if (self.obj!=nil) {
            [self.obj setTickLoginV:self];
            [self.obj getKuaiDi100FromHttp:@"shunfeng" andNu:@"786655113275"];
        }
        self.myData = myDataSource;
        [self initView];
    }
    return self;
}
-(void)updataTableView :(NSArray *)kuaidiArr{
    self.kuaidiArr=kuaidiArr;
     self.contentScroll.contentSize=CGSizeMake(DEF_WIDTH(self),DEF_Y(self.logiDetailView)+DEF_HEIGHT(self.logiDetailView));
    [self.logiDetailView reloadData];

}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if (button.tag==100) {
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        
    }
}
-(void)initView{
    [self creatBKView];
    UIScrollView *contentScrol=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 130*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-130*DEF_Adaptation_Font*0.5)];
    self.contentScroll=contentScrol;
    contentScrol.delegate=self;
    [self addSubview:contentScrol];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(40*DEF_Adaptation_Font*0.5, 15*DEF_Adaptation_Font*0.5, 560*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    contentLB.text=[self.myData objectForKey:@"productname"];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize: 16];
    CGSize lblSize = [contentLB.text boundingRectWithSize:CGSizeMake(560*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGRect frame=contentLB.frame;
    frame.size.height=lblSize.height;
    contentLB.frame=frame;
    [contentScrol addSubview:contentLB];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(41*DEF_Adaptation_Font*0.5, lblSize.height+35*DEF_Adaptation_Font*0.5, 84*DEF_Adaptation_Font*0.5, 84*DEF_Adaptation_Font*0.5)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.myData objectForKey:@"productimage"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [contentScrol addSubview:imageView];
    
    UIImageView *locationLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+3*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    locationLV.image=[UIImage imageNamed:@"locaton.png"];
    [contentScrol addSubview:locationLV];
    UILabel *locationLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+3*DEF_Adaptation_Font*0.5, 422*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    locationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    locationLB.text=[self.myData objectForKey:@"location"];
    CGSize lblSize2 = [locationLB.text boundingRectWithSize:CGSizeMake(422*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame2=locationLB.frame;
    frame2.size=lblSize2;
    locationLB.frame=frame2;
    locationLB.numberOfLines=0;
    locationLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:locationLB];
    
    UIImageView *timeLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(locationLB)+DEF_HEIGHT(locationLB)+20*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    timeLV.image=[UIImage imageNamed:@"time.png"];
    [contentScrol addSubview:timeLV];
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(locationLB)+DEF_HEIGHT(locationLB)+17*DEF_Adaptation_Font*0.5, 422*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    timeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    timeLB.text=[self.myData objectForKey:@"starttime"];
    CGSize lblSize1 = [timeLB.text boundingRectWithSize:CGSizeMake(422*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame1=timeLB.frame;
    frame1.size=lblSize1;
    timeLB.frame=frame1;
    timeLB.numberOfLines=0;
    timeLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:timeLB];
    
    UIImageView *priceLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+20*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    priceLV.image=[UIImage imageNamed:@"ticket.png"];
    [contentScrol addSubview:priceLV];
    UILabel *priceLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+17*DEF_Adaptation_Font*0.5, 271*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    priceLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    priceLB.text=[NSString stringWithFormat:@"票价:%d   ×%@",[[_myData objectForKey:@"price"]intValue]/[[_myData objectForKey:@"number"]intValue],[_myData objectForKey:@"number"]];
    CGSize lblSize3 = [priceLB.text boundingRectWithSize:CGSizeMake(271*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame3=priceLB.frame;
    frame3.size=lblSize3;
    priceLB.frame=frame3;
    priceLB.numberOfLines=0;
    priceLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:priceLB];
    
    UILabel *sumPriceLB=[[UILabel alloc]initWithFrame:CGRectMake(450*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+20*DEF_Adaptation_Font*0.5, 156*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    sumPriceLB.font=[UIFont systemFontOfSize:14];
    sumPriceLB.text=[NSString stringWithFormat:@"共计%d元",[[_myData objectForKey:@"price"]intValue]];
    sumPriceLB.textColor=ColorRGB(245, 244, 247, 1.0);
    sumPriceLB.textAlignment=NSTextAlignmentRight;
    [contentScrol addSubview:sumPriceLB];
    
    UIImageView *lineIV=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+DEF_HEIGHT(imageView)+60*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV];

    UILabel *deliveryLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV)+40*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    deliveryLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16.f];
    deliveryLB.text=@"个人详情";
    deliveryLB.textColor=ColorRGB(212, 215, 230, 1.0);
    deliveryLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:deliveryLB];
    
    UILabel *tradingCardLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(deliveryLB)+65*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingCardLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    tradingCardLB.text=@"交易单号：2828282828";
    tradingCardLB.textColor=[UIColor whiteColor];
    tradingCardLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tradingCardLB.text];
    [str addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingCardLB.attributedText = str;
    [contentScrol addSubview:tradingCardLB];
    
    UILabel *tradingNameLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingCardLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingNameLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    tradingNameLB.textColor=[UIColor whiteColor];
    tradingNameLB.textAlignment=NSTextAlignmentLeft;
    if ([_myData objectForKey:@"clientname"]!=[NSNull null]) {
    tradingNameLB.text=[NSString stringWithFormat:@"收货人：%@",[_myData objectForKey:@"clientname"]];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:tradingNameLB.text];
    [str2 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingNameLB.attributedText = str2;
    }else{
     tradingNameLB.text=@"收货人：";
    }
    [contentScrol addSubview:tradingNameLB];
    
    UILabel *tradingPhoneLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingNameLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingPhoneLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    tradingPhoneLB.text=[NSString stringWithFormat:@"手机号：%@",[_myData objectForKey:@"clientmobile"]];
    tradingPhoneLB.textColor=[UIColor whiteColor];
    tradingPhoneLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str3= [[NSMutableAttributedString alloc] initWithString:tradingPhoneLB.text];
    [str3 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingPhoneLB.attributedText = str3;
    [contentScrol addSubview:tradingPhoneLB];
    
    UILabel *tradingAddressLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingPhoneLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingAddressLB.font=[UIFont systemFontOfSize:14];
    tradingAddressLB.text=[NSString stringWithFormat:@"收货地址：%@",[_myData objectForKey:@"clientaddress"]];
    tradingAddressLB.numberOfLines=0;
    tradingAddressLB.textColor=[UIColor whiteColor];
    tradingAddressLB.textAlignment=NSTextAlignmentLeft;
    CGSize lblSize5 = [tradingAddressLB.text boundingRectWithSize:CGSizeMake(568*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:14.f]} context:nil].size;
    CGRect frame5=tradingAddressLB.frame;
    frame5.size.height=lblSize5.height+16*DEF_Adaptation_Font*0.5;
    tradingAddressLB.frame=frame5;
//改变字体行间距
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 16*DEF_Adaptation_Font*0.5;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:14.f], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.1f};
//改变部分字体颜色
    NSMutableAttributedString *str4= [[NSMutableAttributedString alloc] initWithString:tradingAddressLB.text attributes:dic];
    [str4 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingAddressLB.attributedText = str4;
    [contentScrol addSubview:tradingAddressLB];
    
    UIImageView *lineIV2=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingAddressLB)+DEF_HEIGHT(tradingAddressLB)+30*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV2.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV2];
    
    UILabel *logisticsLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV2)+40*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logisticsLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16.f];
    logisticsLB.text=@"物流详情";
    logisticsLB.textColor=ColorRGB(212, 215, 230, 1.0);
    logisticsLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:logisticsLB];
    
    UILabel *logiCardLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(logisticsLB)+65*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logiCardLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    logiCardLB.text=[NSString stringWithFormat:@"快递单号：%@",[_myData objectForKey:@"deliverycode"]];
    logiCardLB.textColor=[UIColor whiteColor];
    logiCardLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str5 = [[NSMutableAttributedString alloc] initWithString:logiCardLB.text];
    [str5 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    logiCardLB.attributedText = str5;
    [contentScrol addSubview:logiCardLB];
    
    UILabel *logiCompanyLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(logiCardLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logiCompanyLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    logiCompanyLB.text=[NSString stringWithFormat:@"快递公司：%@",[_myData objectForKey:@"delivery"]];
    logiCompanyLB.textColor=[UIColor whiteColor];
    logiCompanyLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str6 = [[NSMutableAttributedString alloc] initWithString:logiCompanyLB.text];
    [str6 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    logiCompanyLB.attributedText = str6;
    [contentScrol addSubview:logiCompanyLB];
    
    UILabel *logiDetailLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(logiCompanyLB)+55*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logiDetailLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    logiDetailLB.text=@"物流详情";
    logiDetailLB.textColor=ColorRGB(212, 215, 230, 1.0);
    logiDetailLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:logiDetailLB];
    self.logiDetailView=[[UITableView alloc]initWithFrame:CGRectMake(0, DEF_Y(logiDetailLB)+55*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self))];
    self.logiDetailView.backgroundColor=[UIColor clearColor];
    self.logiDetailView.delegate=self;
    self.logiDetailView.dataSource=self;
    self.logiDetailView.showsVerticalScrollIndicator = NO;
    self.logiDetailView.separatorStyle = NO;
    //取消button点击延迟
    self.logiDetailView.delaysContentTouches = NO;
    self.logiDetailView.alwaysBounceVertical=YES;
    [self.logiDetailView registerClass:[AttenceTimelineCell class] forCellReuseIdentifier:@"Cell"];
    [contentScrol addSubview:self.logiDetailView];
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.kuaidiArr.count) {
        return _kuaidiArr.count;
//    }
//     return dataSourceArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttenceTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor=[UIColor clearColor];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    bool isFirst = indexPath.row == 0;
//    bool isLast = indexPath.row == dataSourceArr.count - 1;
  UIView  *verticalLineTopView = [[UIView alloc] initWithFrame:CGRectMake(20*DEF_Adaptation_Font, 0, 1, 16*DEF_Adaptation_Font)];
    verticalLineTopView.backgroundColor = ColorRGB(97, 97, 97, 1.0);
    [cell.contentView addSubview:verticalLineTopView];
    UILabel *showLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font, 10*DEF_Adaptation_Font, DEF_WIDTH(self)-40*DEF_Adaptation_Font, 40)];
//    showLB.text= dataSourceArr[dataSourceArr.count - 1 - indexPath.row];
    if (self.kuaidiArr.count) {
        showLB.text=[self.kuaidiArr[indexPath.row]objectForKey:@"context"];
    }
    showLB.numberOfLines = 0;
    showLB.textColor=[UIColor whiteColor];
    showLB.textAlignment=NSTextAlignmentLeft;
    showLB.font=[UIFont systemFontOfSize:15];
    CGSize lblSize = [showLB.text boundingRectWithSize:CGSizeMake(DEF_WIDTH(self)-40*DEF_Adaptation_Font, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size;
    CGRect frame=showLB.frame;
    frame.size.height=lblSize.height;
    showLB.frame=frame;
    [cell.contentView addSubview:showLB];
    UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(DotViewCentX - VerticalLineWidth/2.0 + 20*DEF_Adaptation_Font, showLB.frame.origin.y+showLB.frame.size.height+5*DEF_Adaptation_Font, ShowLabWidth, 10*DEF_Adaptation_Font)];
    timeLabel.text=@"2017年10月1日";
    if (self.kuaidiArr.count) {
        timeLabel.text=[self.kuaidiArr[indexPath.row]objectForKey:@"time"];
    }
    timeLabel.textColor=[UIColor lightGrayColor];
    timeLabel.font=[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:timeLabel];
    UIView  *verticalLineBottomView = [[UIView alloc] initWithFrame:CGRectMake(20*DEF_Adaptation_Font, 16*DEF_Adaptation_Font, 1,DEF_HEIGHT(showLB)+40*DEF_Adaptation_Font)];
    verticalLineBottomView.backgroundColor =  ColorRGB(97, 97, 97, 1.0);
    [cell.contentView addSubview:verticalLineBottomView];
    UIView  *dotView = [[UIView alloc] initWithFrame:CGRectMake(16*DEF_Adaptation_Font, 12*DEF_Adaptation_Font,  8*DEF_Adaptation_Font,  8*DEF_Adaptation_Font)];
    dotView.backgroundColor = [UIColor greenColor];
    dotView.layer.cornerRadius = 4*DEF_Adaptation_Font;
    [cell.contentView addSubview:dotView];
    //设置最上面和最下面是否隐藏
    if (self.kuaidiArr.count) {
        if (indexPath.row==0) {
            verticalLineTopView.hidden = YES;
        }else{
            verticalLineTopView.hidden = NO;
        }if (indexPath.row==self.kuaidiArr.count-1) {
            verticalLineBottomView.hidden = YES;
        }
    }else{
    if (indexPath.row==0) {
        verticalLineTopView.hidden = YES;
    }else{
    verticalLineTopView.hidden = NO;
    }if (indexPath.row==dataSourceArr.count-1) {
        verticalLineBottomView.hidden = YES;
    }
    }
    //判断是否是第一个（是第一个更改背景色）
    dotView.backgroundColor = isFirst ? [UIColor greenColor] : [UIColor lightGrayColor];
    CGRect frame2=dotView.frame;
    frame2.size.width=6*DEF_Adaptation_Font;
    frame2.size.height=6*DEF_Adaptation_Font;
    frame2.origin.x=17*DEF_Adaptation_Font;
    dotView.frame=isFirst? dotView.frame:frame2;

    return cell;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.kuaidiArr.count) {
        return [AttenceTimelineCell cellHeightWithString:[self.kuaidiArr[indexPath.row]objectForKey:@"context"] isContentHeight:NO]+15*DEF_Adaptation_Font;
    }
   return [AttenceTimelineCell cellHeightWithString:dataSourceArr[dataSourceArr.count - 1 - indexPath.row] isContentHeight:NO]+15*DEF_Adaptation_Font;
    
    
}


-(void)creatBKView{
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    UILabel  *titleLB = [LooperToolClass createLableView:CGPointMake(258*DEF_Adaptation_Font*0.5,64*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andText:@"订单详情" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [self addSubview:titleLB];
}

@end
