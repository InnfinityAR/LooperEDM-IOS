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
@interface TicketLogisticsView()<UIScrollViewDelegate,UIWebViewDelegate>
@property(nonatomic,strong)UIScrollView *contentScroll;
@end
@implementation TicketLogisticsView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andMyData:(NSDictionary*)myDataSource{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
        self.myData = myDataSource;
        [self initView];
    }
    return self;
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
    contentLB.text=@"Looper发门票Looper发门票门票发门票,大家快来抢门票啦";
    contentLB.textColor=[UIColor whiteColor];
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont boldSystemFontOfSize:16];
    CGSize lblSize = [contentLB.text boundingRectWithSize:CGSizeMake(560*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
    CGRect frame=contentLB.frame;
    frame.size.height=lblSize.height;
    contentLB.frame=frame;
    [contentScrol addSubview:contentLB];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(41*DEF_Adaptation_Font*0.5, lblSize.height+35*DEF_Adaptation_Font*0.5, 84*DEF_Adaptation_Font*0.5, 116*DEF_Adaptation_Font*0.5)];
    imageView.backgroundColor=[UIColor greenColor];
    [contentScrol addSubview:imageView];
    
    UIImageView *locationLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+3*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    locationLV.image=[UIImage imageNamed:@"locaton.png"];
    [contentScrol addSubview:locationLV];
    UILabel *locationLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+3*DEF_Adaptation_Font*0.5, 422*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    locationLB.font=[UIFont systemFontOfSize:13];
    locationLB.text=@"地点:来自二次元的你来自二次元";
    CGSize lblSize2 = [locationLB.text boundingRectWithSize:CGSizeMake(422*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGRect frame2=locationLB.frame;
    frame2.size=lblSize2;
    locationLB.frame=frame2;
    locationLB.numberOfLines=0;
    locationLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:locationLB];
    
    UIImageView *timeLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(locationLB)+DEF_HEIGHT(locationLB)+10*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    timeLV.image=[UIImage imageNamed:@"time.png"];
    [contentScrol addSubview:timeLV];
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(locationLB)+DEF_HEIGHT(locationLB)+10*DEF_Adaptation_Font*0.5, 422*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    timeLB.font=[UIFont systemFontOfSize:13];
    timeLB.text=@"时间:公元20017年5月6号";
    CGSize lblSize1 = [timeLB.text boundingRectWithSize:CGSizeMake(422*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGRect frame1=timeLB.frame;
    frame1.size=lblSize1;
    timeLB.frame=frame1;
    timeLB.numberOfLines=0;
    timeLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:timeLB];
    
    UIImageView *priceLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+10*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    priceLV.image=[UIImage imageNamed:@"ticket.png"];
    [contentScrol addSubview:priceLV];
    UILabel *priceLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+10*DEF_Adaptation_Font*0.5, 271*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    priceLB.font=[UIFont systemFontOfSize:13];
    priceLB.text=@"票价:129普通票  ×1";
    CGSize lblSize3 = [priceLB.text boundingRectWithSize:CGSizeMake(271*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGRect frame3=priceLB.frame;
    frame3.size=lblSize3;
    priceLB.frame=frame3;
    priceLB.numberOfLines=0;
    priceLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:priceLB];
    
    UILabel *sumPriceLB=[[UILabel alloc]initWithFrame:CGRectMake(450*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+10*DEF_Adaptation_Font*0.5, 156*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    sumPriceLB.font=[UIFont systemFontOfSize:14];
    sumPriceLB.text=@"共计:129元";
    sumPriceLB.textColor=ColorRGB(245, 244, 247, 1.0);
    sumPriceLB.textAlignment=NSTextAlignmentRight;
    [contentScrol addSubview:sumPriceLB];
    
    UIImageView *lineIV=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+DEF_HEIGHT(imageView)+30*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV];

    UILabel *deliveryLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV)+40*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    deliveryLB.font=[UIFont systemFontOfSize:16];
    deliveryLB.text=@"个人详情";
    deliveryLB.textColor=ColorRGB(212, 215, 230, 1.0);
    deliveryLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:deliveryLB];
    
    UILabel *tradingCardLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(deliveryLB)+65*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingCardLB.font=[UIFont systemFontOfSize:14];
    tradingCardLB.text=@"交易单号：2828282828";
    tradingCardLB.textColor=[UIColor whiteColor];
    tradingCardLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tradingCardLB.text];
    [str addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingCardLB.attributedText = str;
    [contentScrol addSubview:tradingCardLB];
    
    UILabel *tradingNameLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingCardLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingNameLB.font=[UIFont systemFontOfSize:14];
    tradingNameLB.text=@"收货人： 叶伟达";
    tradingNameLB.textColor=[UIColor whiteColor];
    tradingNameLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:tradingNameLB.text];
    [str2 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingNameLB.attributedText = str2;
    [contentScrol addSubview:tradingNameLB];
    
    UILabel *tradingPhoneLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingNameLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingPhoneLB.font=[UIFont systemFontOfSize:14];
    tradingPhoneLB.text=@"手机号： 15755361985";
    tradingPhoneLB.textColor=[UIColor whiteColor];
    tradingPhoneLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str3= [[NSMutableAttributedString alloc] initWithString:tradingPhoneLB.text];
    [str3 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingPhoneLB.attributedText = str3;
    [contentScrol addSubview:tradingPhoneLB];
    
    UILabel *tradingAddressLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingPhoneLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    tradingAddressLB.font=[UIFont systemFontOfSize:14];
    tradingAddressLB.text=@"收货地址：上海市东方明珠向上走穿过平流层，中间有一个叫做天堂的地方";
    tradingAddressLB.numberOfLines=0;
    tradingAddressLB.textColor=[UIColor whiteColor];
    tradingAddressLB.textAlignment=NSTextAlignmentLeft;
    CGSize lblSize5 = [tradingAddressLB.text boundingRectWithSize:CGSizeMake(568*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CGRect frame5=tradingAddressLB.frame;
    frame5.size.height=lblSize5.height+16*DEF_Adaptation_Font*0.5;
    tradingAddressLB.frame=frame5;
//改变字体行间距
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 16*DEF_Adaptation_Font*0.5;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.1f};
//改变部分字体颜色
    NSMutableAttributedString *str4= [[NSMutableAttributedString alloc] initWithString:tradingAddressLB.text attributes:dic];
    [str4 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingAddressLB.attributedText = str4;
    [contentScrol addSubview:tradingAddressLB];
    
    UIImageView *lineIV2=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(tradingAddressLB)+DEF_HEIGHT(tradingAddressLB)+30*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV2.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV2];
    
    UILabel *logisticsLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV2)+40*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logisticsLB.font=[UIFont systemFontOfSize:16];
    logisticsLB.text=@"物流详情";
    logisticsLB.textColor=ColorRGB(212, 215, 230, 1.0);
    logisticsLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:logisticsLB];
    
    UILabel *logiCardLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(logisticsLB)+65*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logiCardLB.font=[UIFont systemFontOfSize:14];
    logiCardLB.text=@"快递单号：2828282828";
    logiCardLB.textColor=[UIColor whiteColor];
    logiCardLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str5 = [[NSMutableAttributedString alloc] initWithString:logiCardLB.text];
    [str5 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    logiCardLB.attributedText = str5;
    [contentScrol addSubview:logiCardLB];
    
    UILabel *logiCompanyLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(logiCardLB)+55*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logiCompanyLB.font=[UIFont systemFontOfSize:14];
    logiCompanyLB.text=@"快递公司： 顺丰速运";
    logiCompanyLB.textColor=[UIColor whiteColor];
    logiCompanyLB.textAlignment=NSTextAlignmentLeft;
    NSMutableAttributedString *str6 = [[NSMutableAttributedString alloc] initWithString:logiCompanyLB.text];
    [str6 addAttribute:NSForegroundColorAttributeName value:ColorRGB(212, 215, 230, 1.0) range:NSMakeRange(0,5)];
    tradingNameLB.attributedText = str6;
    [contentScrol addSubview:logiCompanyLB];
    
    UILabel *logiDetailLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(logiCompanyLB)+55*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    logiDetailLB.font=[UIFont systemFontOfSize:14];
    logiDetailLB.text=@"物流详情";
    logiDetailLB.textColor=ColorRGB(212, 215, 230, 1.0);
    logiDetailLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:logiDetailLB];
    
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, DEF_Y(logiDetailLB)+55*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_WIDTH(self))];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    webView.delegate=self;
    [contentScrol addSubview: webView];
    [webView loadRequest:request];
    self.contentScroll.contentSize=CGSizeMake(DEF_WIDTH(self),DEF_Y(webView)+DEF_HEIGHT(webView));
}
- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    webView.scrollView.bounces=NO;
    CGRect frame = webView.frame;
    //webView的宽度
    frame.size = CGSizeMake(DEF_WIDTH(self), 0);
    webView.frame = frame;
    float content_height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    frame = webView.frame;
    //webView的宽度和高度
    frame.size = CGSizeMake(DEF_WIDTH(self), content_height);
    webView.frame = frame;
    self.contentScroll.contentSize=CGSizeMake(DEF_WIDTH(self),DEF_Y(webView)+DEF_HEIGHT(webView));
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
