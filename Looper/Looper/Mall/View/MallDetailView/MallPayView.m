//
//  MallPayView.m
//  Looper
//
//  Created by 工作 on 2017/11/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "MallPayView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "MallViewModel.h"
@interface MallPayView()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSString *selectTime;
}
@property(nonatomic,strong)UIButton *payBtn;
@property(nonatomic,strong)UIButton *sendCodeBtn;
@property(nonatomic,strong)UITextField *currentTextField;
@property(nonatomic,strong)UITextView *currentTextView;
@property(nonatomic,strong)UIScrollView *contentScroll;

@property(nonatomic,strong)NSMutableArray *textFieldArr;
@property(nonatomic)BOOL isEnsurePayBtn;

@property(nonatomic,strong)UIButton *paySureBtn;

@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UITextView *addressV;

@property(nonatomic)NSInteger payNumber;
@property(nonatomic,strong)UITextField *nameField;

@property(nonatomic,strong)NSDictionary *orderDic;

@end
@implementation MallPayView
-(NSMutableArray *)textFieldArr{
    if (!_textFieldArr) {
        _textFieldArr=[[NSMutableArray alloc]init];
    }
    return _textFieldArr;
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andPayNumber:(NSInteger)paynumber andOrderDic:(NSDictionary *)orderDic andTime:(NSString*)time{
    if (self = [super initWithFrame:frame]) {
        self.viewModel=(MallViewModel*)idObject;
        self.payNumber=paynumber;
        self.orderDic=orderDic;
        selectTime=time;
        self.isEnsurePayBtn=NO;
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor=[UIColor whiteColor];
    
    UIScrollView *contentScrol=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 105*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-196*DEF_Adaptation_Font*0.5)];
    self.contentScroll=contentScrol;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScrollView)];
    [contentScrol addGestureRecognizer:tap];
    contentScrol.delegate=self;
    [self addSubview:contentScrol];
    
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(40*DEF_Adaptation_Font*0.5, 4*DEF_Adaptation_Font*0.5, 560*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    contentLB.text=[self.orderDic objectForKey:@"productname"];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.font=[UIFont systemFontOfSize:17];
    CGSize lblSize = [contentLB.text boundingRectWithSize:CGSizeMake(560*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGRect frame=contentLB.frame;
    frame.size.height=lblSize.height;
    contentLB.frame=frame;
    [contentScrol addSubview:contentLB];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(41*DEF_Adaptation_Font*0.5, lblSize.height+22*DEF_Adaptation_Font*0.5, 84*DEF_Adaptation_Font*0.5, 84*DEF_Adaptation_Font*0.5)];
    if([self.orderDic objectForKey:@"commodityimageurl"]!=nil) {
        NSString *dataStr=[self.orderDic objectForKey:@"commodityimageurl"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dataStr componentsSeparatedByString:@","][0]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    [contentScrol addSubview:imageView];
    
    UIImageView *timeLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+3*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    timeLV.image=[UIImage imageNamed:@"time.png"];
    [contentScrol addSubview:timeLV];
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+0*DEF_Adaptation_Font*0.5, 422*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    timeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    timeLB.text=[self.orderDic objectForKey:@"creationdate"];
    CGSize lblSize2 = [timeLB.text boundingRectWithSize:CGSizeMake(422*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame2=timeLB.frame;
    frame2.size=lblSize2;
    timeLB.frame=frame2;
    timeLB.numberOfLines=0;
    timeLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:timeLB];
    
    UIImageView *priceLV=[[UIImageView alloc]initWithFrame:CGRectMake(145*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+15*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    priceLV.image=[UIImage imageNamed:@"ticket.png"];
    [contentScrol addSubview:priceLV];
    UILabel *priceLB=[[UILabel alloc]initWithFrame:CGRectMake(177*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+12*DEF_Adaptation_Font*0.5, 271*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    priceLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    priceLB.text=[NSString stringWithFormat:@"%ld积分   ×%ld",[[self.orderDic objectForKey:@"credit" ]intValue]/self.payNumber,self.payNumber];
    CGSize lblSize3 = [priceLB.text boundingRectWithSize:CGSizeMake(271*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame3=priceLB.frame;
    frame3.size=lblSize3;
    priceLB.frame=frame3;
    priceLB.numberOfLines=0;
    priceLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [contentScrol addSubview:priceLB];
    
    UILabel *sumPriceLB=[[UILabel alloc]initWithFrame:CGRectMake(450*DEF_Adaptation_Font*0.5, DEF_Y(timeLB)+DEF_HEIGHT(timeLB)+15*DEF_Adaptation_Font*0.5, 156*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    sumPriceLB.font=[UIFont systemFontOfSize:14];
    sumPriceLB.text=[NSString stringWithFormat:@"共计:%@",[self.orderDic objectForKey:@"credit" ]];
    sumPriceLB.textColor=ColorRGB(245, 244, 247, 1.0);
    sumPriceLB.textAlignment=NSTextAlignmentRight;
    [contentScrol addSubview:sumPriceLB];
    
    UIImageView *lineIV=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+DEF_HEIGHT(imageView)+60*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV.image=[UIImage imageNamed:@"cutoffLine.png"];
    lineIV.alpha=0.8;
    [contentScrol addSubview:lineIV];
    
    UILabel *deliveryLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV)+40*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    deliveryLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    deliveryLB.text=@"商品配送";
    deliveryLB.textColor=ColorRGB(223, 219, 234, 1.0);
    deliveryLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:deliveryLB];
    
    UITextField *nameField=[[UITextField alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV)+100*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    self.currentTextField=nameField;
    self.nameField=nameField;
    nameField.delegate=self;
    nameField.tag=99;
    nameField.text = @"姓名";
    [self.textFieldArr addObject:nameField];
    nameField.font=[UIFont systemFontOfSize:14];
    nameField.textColor=ColorRGB(255, 255, 255, 0.36);
    [contentScrol addSubview:nameField];
    UIImageView *lineIV2=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(nameField)+DEF_HEIGHT(nameField)+10*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV2.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV2];
    
    UITextField *phoneField=[[UITextField alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV2)+30*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    [self.textFieldArr addObject:phoneField];
    self.phoneField=phoneField;
    phoneField.tag=100;
    phoneField.delegate=self;
    phoneField.text = @"手机号";
    phoneField.font=[UIFont systemFontOfSize:14];
    phoneField.textColor=ColorRGB(255, 255, 255, 0.36);
    [contentScrol addSubview:phoneField];
    
    self.sendCodeBtn=[self publishButton:@"发送验证码" andCGPoint:CGPointMake(450*DEF_Adaptation_Font*0.5,DEF_Y(lineIV2)+20*DEF_Adaptation_Font*0.5) andTag:101];
    [contentScrol addSubview:self.sendCodeBtn];
    UIImageView *lineIV3=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(phoneField)+DEF_HEIGHT(phoneField)+20*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV3.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV3];
    
    UITextField *codeField=[[UITextField alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV3)+30*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    [self.textFieldArr addObject:codeField];
    self.codeField=codeField;
    codeField.tag=101;
    codeField.delegate=self;
    codeField.text = @"短信验证码";
    codeField.font=[UIFont systemFontOfSize:14];
    codeField.textColor=ColorRGB(255, 255, 255, 0.36);
    [contentScrol addSubview:codeField];
    UIImageView *lineIV4=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(codeField)+DEF_HEIGHT(codeField)+20*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV4.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV4];
    
    UITextView *addressTextView=[[UITextView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV4)+30*DEF_Adaptation_Font*0.5, 566*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    self.currentTextView=addressTextView;
    self.addressV=addressTextView;
    addressTextView.tag=102;
    addressTextView.backgroundColor=ColorRGB(34, 35, 71, 1.0);
    addressTextView.delegate=self;
    addressTextView.text = @"收货地址";
    addressTextView.font=[UIFont systemFontOfSize:14];
    addressTextView.textColor=ColorRGB(255, 255, 255, 0.36);
    [contentScrol addSubview:addressTextView];
    UIImageView *lineIV5=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(addressTextView)+DEF_HEIGHT(addressTextView)+30*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV5.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV5];
    
    UITextField *postCodeField=[[UITextField alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV5)+30*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    [self.textFieldArr addObject:postCodeField];
    postCodeField.tag=102;
    postCodeField.delegate=self;
    postCodeField.text = @"邮编地址";
    postCodeField.font=[UIFont systemFontOfSize:14];
    postCodeField.textColor=ColorRGB(255, 255, 255, 0.36);
    [contentScrol addSubview:postCodeField];
    UIImageView *lineIV6=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(postCodeField)+DEF_HEIGHT(postCodeField)+20*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV6.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentScrol addSubview:lineIV6];
    
    UILabel *payWayLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(lineIV6)+50*DEF_Adaptation_Font*0.5, 130*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    payWayLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    payWayLB.text=@"支付方式";
    payWayLB.textColor=ColorRGB(223, 219, 234, 1.0);
    payWayLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:payWayLB];
//    UIImageView *payIV=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(payWayLB)+60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
//    payIV.image=[UIImage imageNamed:@"image_pay.png"];
//    payIV.layer.cornerRadius=3.0;
//    payIV.clipsToBounds=YES;
//    [contentScrol addSubview:payIV];
    UILabel *payLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(payWayLB)+80*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    payLB.font=[UIFont systemFontOfSize:14];
    payLB.text=@"积分支付";
    payLB.textColor=[UIColor whiteColor];
    payLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:payLB];
    
    UIButton *payEnsureBtn=[LooperToolClass createBtnImageNameReal:@"btn_inselect_pay.png" andRect:CGPointMake(555*DEF_Adaptation_Font*0.5, DEF_Y(payWayLB)+54*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_select_pay.png" andClickImage:@"btn_select_pay.png" andTextStr:nil andSize:CGSizeMake(72*DEF_Adaptation_Font*0.5, 72*DEF_Adaptation_Font*0.5) andTarget:self];
    [contentScrol addSubview:payEnsureBtn];
    [payEnsureBtn setSelected:YES];
    self.paySureBtn=payEnsureBtn;
    
    UILabel *payTicketLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(payLB)+82*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    payTicketLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    payTicketLB.text=@"积分购买须知";
    payTicketLB.textColor=ColorRGB(223, 219, 234, 1.0);
    payTicketLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:payTicketLB];
    
    UILabel *payTicketDetailLB=[[UILabel alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, DEF_Y(payTicketLB)+42*DEF_Adaptation_Font*0.5, 568*DEF_Adaptation_Font*0.5, 222*DEF_Adaptation_Font*0.5)];
    payTicketDetailLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    payTicketDetailLB.text=@" 1  购买成功后不可退货。\n 2  购买成功后可以在首页下滑“我的订单”查看购买的商品。";
    payTicketDetailLB.numberOfLines=0;
    payTicketDetailLB.textColor=ColorRGB(223, 219, 234, 1.0);
    CGSize lblSize5 = [payTicketDetailLB.text boundingRectWithSize:CGSizeMake(568*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:14.f]} context:nil].size;
    CGRect frame5=payTicketDetailLB.frame;
    frame5.size=lblSize5;
    payTicketDetailLB.frame=frame5;
    payTicketDetailLB.textAlignment=NSTextAlignmentLeft;
    [contentScrol addSubview:payTicketDetailLB];
    contentScrol.contentSize=CGSizeMake(DEF_WIDTH(self), DEF_Y(payTicketDetailLB)+280*DEF_Adaptation_Font*0.5);
    if ([[self.orderDic objectForKey:@"price" ]integerValue]>0) {
        self.payBtn=[self creatButton:[NSString stringWithFormat:@"确认支付"] andCGRect:CGRectMake(0, DEF_HEIGHT(self)-86*DEF_Adaptation_Font*0.5,DEF_WIDTH(self), 86*DEF_Adaptation_Font*0.5) andTag:105];
    }else{
        self.payBtn=[self creatButton:@"确认购票" andCGRect:CGRectMake(0, DEF_HEIGHT(self)-86*DEF_Adaptation_Font*0.5,DEF_WIDTH(self), 86*DEF_Adaptation_Font*0.5) andTag:105];
    }
    if (self.isEnsurePayBtn==NO) {
        self.payBtn.backgroundColor=[UIColor lightGrayColor];
    }
    [self addSubview: self.payBtn];
    [self creatBKView];
}
//-(NSString *)setSelecttime{
//    NSDate *startDate =[self timeWithTimeIntervalString:[self.dataDic objectForKey:@"starttime"]];
//    NSDate *endDate=[self timeWithTimeIntervalString:[self.dataDic objectForKey:@"endtime"]];
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
//    NSDateComponents *startcomp=[cal components:unitFlags fromDate:startDate];
//    NSDateComponents *endcomp=[cal components:unitFlags fromDate:endDate];
//    //    NSMutableArray *dateArr=[[NSMutableArray alloc]init];
//    //    for (NSInteger i=[startcomp day]; i<=[endcomp day]; i++) {
//    //        [dateArr addObject:[NSString stringWithFormat:@"%ld年%ld月%ld号",[startcomp year],[startcomp month],i]];
//    //    }
//    if ([startcomp day]==[endcomp day]) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        //设置格式：zzz表示时区
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        //NSDate转NSString
//        NSString *currentDateString = [dateFormatter stringFromDate:startDate];
//        return currentDateString;
//    }
//    NSString *dataStr=[NSString stringWithFormat:@"%ld年%ld月%ld号-%ld月%ld号",[startcomp year],[startcomp month],[startcomp day],[endcomp month],[endcomp day]];
//    return dataStr;
//}
- (NSDate *)timeWithTimeIntervalString:(NSString *)timeString
{
    //    NSTimeInterval time=[timeString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[timeString doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    return  detaildate;
}
-(void)creatBKView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    if (selectTime==nil) {
        backBtn.tag=99;
    }
    [self addSubview:backBtn];
    self.backgroundColor=ColorRGB(34, 35, 71, 1.0);
}
-(UIButton *)creatButton:(NSString *)str andCGRect:(CGRect)frame andTag:(int)tag{
    UIButton *btn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(frame.origin.x,frame.origin.y) andTag:tag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(frame.size.width, frame.size.height) andTarget:self];
    UILabel *lable3 =[[UILabel alloc] initWithFrame:CGRectMake(0,0,DEF_WIDTH(btn),DEF_HEIGHT(btn))];
    lable3.textColor=[UIColor whiteColor];
    lable3.text=str;
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.font = [UIFont systemFontOfSize:16];
    [btn addSubview:lable3];
    return btn;
}
-(UIButton *)publishButton:(NSString *)str andCGPoint:(CGPoint)point andTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    //对按钮的外形做了设定，不喜可删~
    btn.layer.masksToBounds = YES;
    btn.tag=tag;
    [btn setTitleColor:ColorRGB(255, 255, 255, 0.36) forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    //重要的是下面这部分哦！
    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
    
    titleSize.height = 60*DEF_Adaptation_Font*0.5;
    titleSize.width += 50*DEF_Adaptation_Font*0.5;
    
    btn.frame = CGRectMake(point.x, point.y, titleSize.width, titleSize.height);
    return btn;
    
}
-(BOOL)judgeIsEnsurePayBtn{
    for (UITextField *textField in self.textFieldArr) {
        if (textField.tag==99) {
            if ([textField.text isEqualToString:@""]||[textField.text isEqualToString:@"姓名"]) {
                self.isEnsurePayBtn=NO;
                return NO;
            }else{
                self.isEnsurePayBtn=YES;
            }
        }if (textField.tag==100) {
            if ([textField.text isEqualToString:@""]||[textField.text isEqualToString:@"手机号"]) {
                self.isEnsurePayBtn=NO;
                return NO;
            }else{
                if ([self securityForTelephone:textField.text]) {
                    self.isEnsurePayBtn=YES;
                }else{
                    self.isEnsurePayBtn=NO;
                    return NO;
                }
            }
        }if (textField.tag==101) {
            if ([textField.text isEqualToString:@""]||[textField.text isEqualToString:@"短信验证码"]) {
                self.isEnsurePayBtn=NO;
                return NO;
            }else{
                self.isEnsurePayBtn=YES;
            }
        }if (textField.tag==102) {
            if ([textField.text isEqualToString:@""]||[textField.text isEqualToString:@"邮编地址"]) {
                self.isEnsurePayBtn=NO;
                return NO;
            }else{
                self.isEnsurePayBtn=YES;
            }
        }
    } if ([self.currentTextView.text isEqualToString:@""]||[self.currentTextView.text isEqualToString:@"收货地址"]) {
        self.isEnsurePayBtn=NO;
        return NO;
    }else{
        self.isEnsurePayBtn=YES;
    }
    if (self.paySureBtn.selected==YES) {
        self.isEnsurePayBtn=YES;
    }else{
        self.isEnsurePayBtn=NO;
        return NO;
    }
    return self.isEnsurePayBtn;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
    if (tag==99) {
//        [self.viewModel popViewController];
        [self removeFromSuperview];
    }
    if (tag==100) {
        [self removeFromSuperview];
    }
    if (tag==105) {
        if ([self judgeIsEnsurePayBtn]) {
            //sendPayUserInfo
            [self.viewModel checkVerificationCodeForvCode:self.codeField.text ProductId:[[self.orderDic objectForKey:@"commodityid"]intValue] andresultid:[[self.orderDic objectForKey:@"resultId"]intValue] andClientAddress:self.addressV.text andclientMobile:self.phoneField.text anddelivery:@"" anddeliveryCode:@"" andPayNumber:self.payNumber andclientName:self.nameField.text andPrice: [[self.orderDic objectForKey:@"price"]intValue]];
        }
    }
    if (tag==101) {
        if (button.selected==YES) {
            [button setSelected:NO];
                [self.viewModel requestDataCode:self.phoneField.text];
            [button setTitleColor:ColorRGB(255, 255, 255, 0.36) forState:UIControlStateNormal];
            [self openCountdown];
        }
    }if (tag==102) {
        if (button.selected==YES) {
            [button setSelected:NO];
            self.payBtn.backgroundColor=[UIColor lightGrayColor];
        }else{
            [button setSelected:YES];
            if ([self judgeIsEnsurePayBtn]) {
                self.payBtn.backgroundColor=ColorRGB(42, 195, 192, 1.0);
            }else{
                self.payBtn.backgroundColor=[UIColor lightGrayColor];
            }
        }
    }
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateSelected];
                [self.sendCodeBtn setTitleColor:ColorRGB(55,135, 145, 1.0) forState:UIControlStateSelected];
                [self.sendCodeBtn setSelected:YES];
                self.sendCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.sendCodeBtn setSelected:NO];
                //设置按钮显示读秒效果
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.sendCodeBtn setTitleColor:ColorRGB(255, 255, 255, 0.36) forState:UIControlStateNormal];
                self.sendCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag==100) {
        if ([string isEqualToString:@"" ]&&textField.text.length==11) {
            textField.text= [textField.text substringToIndex:textField.text.length-1];
        }
        if ([self securityForTelephone:[textField.text stringByAppendingString:string]]) {
            [self.sendCodeBtn setSelected:YES];
            [self.sendCodeBtn setTitleColor:ColorRGB(55,135, 145, 1.0) forState:UIControlStateSelected];
        }else{
            [self.sendCodeBtn setSelected:NO];
            [self.sendCodeBtn setTitleColor:ColorRGB(255, 255, 255, 0.36) forState:UIControlStateNormal];
        }
    }
    if ([self judgeIsEnsurePayBtn]) {
        self.payBtn.backgroundColor=ColorRGB(42, 195, 192, 1.0);
    }else{
        self.payBtn.backgroundColor=[UIColor lightGrayColor];
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.returnKeyType=UIReturnKeyNext;
    if (textField.tag==99) {
        if ( [textField.text  isEqualToString:@"姓名"]) {
            textField.text=@"";
        }
    }if (textField.tag==100) {
        if ( [textField.text  isEqualToString:@"手机号"]) {
            textField.text=@"";
        }
    }if (textField.tag==101) {
        if ( [textField.text  isEqualToString:@"短信验证码"]) {
            textField.text=@"";
        }
    }if (textField.tag==102) {
        if ( [textField.text  isEqualToString:@"邮编地址"]) {
            textField.text=@"";
        }
    }
    
    self.currentTextField=textField;
    if (textField.tag==102) {
        CGPoint position = CGPointMake(0, 90*DEF_Adaptation_Font);
        [self.contentScroll setContentOffset:position animated:YES];
    }
    textField.textColor=[UIColor whiteColor];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        if (textField.tag==99) {
            textField.text=@"姓名";
        }if (textField.tag==100) {
            textField.text=@"手机号";
        }if (textField.tag==101) {
            textField.text=@"短信验证码";
        }if (textField.tag==102) {
            textField.text=@"邮编地址";
        }
        textField.textColor=ColorRGB(255, 255, 255, 0.36);
    }
    if (textField.tag==102) {
        CGPoint position = CGPointMake(0, 0);
        [self.contentScroll setContentOffset:position animated:YES];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    CGPoint position = CGPointMake(0, 50*DEF_Adaptation_Font);
    [self.contentScroll setContentOffset:position animated:YES];
    self.currentTextView=textView;
    if ([textView.text isEqualToString:@"收货地址"]) {
        textView.text=@"";
        textView.textColor=[UIColor whiteColor];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    CGPoint position = CGPointMake(0, 0);
    [self.contentScroll setContentOffset:position animated:YES];
    if ([textView.text isEqualToString:@""]) {
        textView.text=@"收货地址";
        textView.textColor=ColorRGB(255, 255, 255, 0.36);
    }
}
//验证 ：验证请求的是手机号
-(NSNumber*)securityForTelephone:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return 0;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(198)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(166)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(199)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return @1;
        }else{
            return 0;
        }
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.currentTextField resignFirstResponder];
    [self.currentTextView resignFirstResponder];
}
-(void)tapScrollView{
    [self.currentTextField resignFirstResponder];
    [self.currentTextView resignFirstResponder];
    if ([self judgeIsEnsurePayBtn]) {
        self.payBtn.backgroundColor=ColorRGB(42, 195, 192, 1.0);
    }else{
        self.payBtn.backgroundColor=[UIColor lightGrayColor];
    }
}

@end
