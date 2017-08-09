//
//  SaleTicketView.m
//  Looper
//
//  Created by 工作 on 2017/8/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SaleTicketView.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "SaleTicketViewModel.h"
#import "LooperToolClass.h"
#import "TicketPayView.h"
@interface SaleTicketView()<UIScrollViewDelegate>
{
    NSInteger payNumber;
}
@property(nonatomic)UILabel *numberLB;
//用于记录每个timeBtn的width
@property(nonatomic,strong)NSMutableArray *timeBtnWidthArr;
@property(nonatomic)NSInteger currentTimeY;
@property(nonatomic,strong)UIButton *currentTimeBtn;

//用于记录每个priceBtn的width
@property(nonatomic,strong)NSMutableArray *priceBtnWidthArr;
@property(nonatomic)NSInteger currentPriceY;
@property(nonatomic,strong)UIButton *currentPriceBtn;

@property(nonatomic,strong)UIButton *payBtn;

@property(nonatomic,strong)UIButton *subBtn;

@property(nonatomic,strong)NSMutableArray *priceArr;
@end
@implementation SaleTicketView
-(NSMutableArray *)priceArr{
    if (!_priceArr) {
        _priceArr=[[NSMutableArray alloc]init];
        for (NSDictionary *dataDic in [self.orderDic objectForKey:@"roulette"]) {
            if ([[dataDic objectForKey:@"price"]integerValue]>0) {
            [_priceArr addObject:[dataDic objectForKey:@"price"]];
            }
        }
        [_priceArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2]; //升序
        }];
    }
    return _priceArr;
}
-(NSMutableArray *)priceBtnWidthArr{
    if (!_priceBtnWidthArr) {
        _priceBtnWidthArr=[[NSMutableArray alloc]init];
    }
    return _priceBtnWidthArr;
}
-(NSMutableArray *)timeBtnWidthArr{
    if (!_timeBtnWidthArr) {
        _timeBtnWidthArr=[[NSMutableArray alloc]init];
    }
    return _timeBtnWidthArr;
}
-(NSMutableArray *)timeBtnArr{
    if (!_timeBtnArr) {
        _timeBtnArr=[[NSMutableArray alloc]init];
    }
    return _timeBtnArr;
}
-(NSMutableArray *)priceBtnArr{
    if (!_priceBtnArr) {
        _priceBtnArr=[[NSMutableArray alloc]init];
    }
    return _priceBtnArr;
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDataDic:(NSDictionary *)dataDic orderDic:(NSDictionary *)orderDic{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (SaleTicketViewModel*)idObject;
        payNumber=1;
        self.currentTimeY=0;
        self.dataDic=dataDic;
        self.orderDic=orderDic;
        [self initView];
    }
    return self;
}
-(void)initView{
     NSDictionary *activityDic=self.dataDic;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, 108*DEF_Adaptation_Font*0.5, 170*DEF_Adaptation_Font*0.5, 256*DEF_Adaptation_Font*0.5)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[activityDic objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self addSubview:imageView];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(230*DEF_Adaptation_Font*0.5, 118*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-265*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5)];
    contentLB.text=[activityDic objectForKey:@"activityname"];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:18];
    CGSize lblSize = [contentLB.text boundingRectWithSize:CGSizeMake(DEF_WIDTH(self)-260*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    CGRect frame=contentLB.frame;
    frame.size.height=lblSize.height;
    contentLB.frame=frame;
    [self addSubview:contentLB];
    UIImageView *locationLV=[[UIImageView alloc]initWithFrame:CGRectMake(230*DEF_Adaptation_Font*0.5, 222*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    locationLV.image=[UIImage imageNamed:@"locaton.png"];
    [self addSubview:locationLV];
    UILabel *locationLB=[[UILabel alloc]initWithFrame:CGRectMake(264*DEF_Adaptation_Font*0.5, 220*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-299*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
      locationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    locationLB.text=[activityDic objectForKey:@"location"];
    CGSize lblSize2 = [locationLB.text boundingRectWithSize:CGSizeMake(DEF_WIDTH(self)-299*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame2=locationLB.frame;
    frame2.size=lblSize2;
    locationLB.frame=frame2;
    locationLB.numberOfLines=0;
    locationLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [self addSubview:locationLB];
    
    UILabel *moneyLB=[[UILabel alloc]initWithFrame:CGRectMake(240*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-299*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    moneyLB.font=[UIFont boldSystemFontOfSize:16];
    if ([self.priceArr[0]integerValue]<[self.priceArr[self.priceArr.count-1]integerValue]) {
    moneyLB.text=[NSString stringWithFormat:@"￥ %@-%@",self.priceArr[0],self.priceArr[self.priceArr.count-1]];
    }else{
    moneyLB.text=[NSString stringWithFormat:@"￥ %@",self.priceArr[0]];
    }
    moneyLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [self addSubview:moneyLB];
    
    
    UIImageView *lineIV=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, 405*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV.image=[UIImage imageNamed:@"cutoffLine.png"];
    [self addSubview:lineIV];
    
    
    
    UIScrollView *contentSelectView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 405*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-491*DEF_Adaptation_Font*0.5)];
    contentSelectView.delegate = self;
    [self addSubview:contentSelectView];
    
    
    UIImageView *timeIV=[[UIImageView alloc]initWithFrame:CGRectMake(37*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 84*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    timeIV.image=[UIImage imageNamed:@"selectTime.png"];
    [contentSelectView addSubview:timeIV];
//用于计算时间间隔内的每一天
    NSDate *startDate =[self timeWithTimeIntervalString:[activityDic objectForKey:@"starttime"]];
    NSDate *endDate=[self timeWithTimeIntervalString:[activityDic objectForKey:@"endtime"]];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    NSDateComponents *startcomp=[cal components:unitFlags fromDate:startDate];
    NSDateComponents *endcomp=[cal components:unitFlags fromDate:endDate];
//    NSMutableArray *dateArr=[[NSMutableArray alloc]init];
//    for (NSInteger i=[startcomp day]; i<=[endcomp day]; i++) {
//        [dateArr addObject:[NSString stringWithFormat:@"%ld年%ld月%ld号",[startcomp year],[startcomp month],i]];
//    }
    NSString *dataStr=[NSString stringWithFormat:@"%ld年%ld月%ld号-%ld月%ld号",[startcomp year],[startcomp month],[startcomp day],[endcomp month],[endcomp day]];
//使按钮可以平铺。如果右边距离不够自动切换到下一行
    for (int i=0; i<1; i++) {
  UIButton *timeBtn=[self publishButton:dataStr andCGPoint:CGPointMake(35*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5+_currentTimeY) andTag:i];
    [contentSelectView addSubview:timeBtn];
    CGFloat width = [dataStr sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:timeBtn.titleLabel.font.fontName size:timeBtn.titleLabel.font.pointSize]}].width+50*DEF_Adaptation_Font;
        if (i>=1) {
            CGRect frame=timeBtn.frame;
            if ([self.timeBtnWidthArr[i-1]integerValue]+width+70*DEF_Adaptation_Font*0.5<DEF_WIDTH(self)) {
                frame.origin.x=[self.timeBtnWidthArr[i-1]integerValue]+35*DEF_Adaptation_Font*0.5;
                width=frame.origin.x+35*DEF_Adaptation_Font*0.5;
            }else{
                frame.origin.y+=90*DEF_Adaptation_Font*0.5;
                _currentTimeY=  frame.origin.y-85*DEF_Adaptation_Font*0.5;
            }
            timeBtn.frame=frame;
        }
          [self.timeBtnWidthArr addObject:@(width+35*DEF_Adaptation_Font*0.5)];
        [self.timeBtnArr addObject:timeBtn];
    }
//如果只有timeBtn只有一个，则必定选中
    if (self.timeBtnArr.count==1) {
        UIButton *btn=self.timeBtnArr.firstObject;
        self.currentTimeBtn=btn;
        btn.selected=YES;
        [btn.layer setBorderColor: [ColorRGB(181, 252, 255, 1.0) CGColor]];
        [btn setTitleColor:ColorRGB(181, 252, 255, 1.0) forState:UIControlStateSelected];
        btn.userInteractionEnabled=NO;
    }
    UIImageView *priceIV=[[UIImageView alloc]initWithFrame:CGRectMake(37*DEF_Adaptation_Font*0.5, 205*DEF_Adaptation_Font*0.5+_currentTimeY, 84*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    priceIV.image=[UIImage imageNamed:@"selectPrice.png"];
    [contentSelectView addSubview:priceIV];
    NSArray *roulette=[self.orderDic objectForKey:@"roulette"];
//使按钮可以平铺。如果右边距离不够自动切换到下一行
    for (int i=0; i<roulette.count; i++) {
        if ([[roulette[i]objectForKey:@"price"]integerValue]>0) {
        UIButton *priceBtn=[self publishButton:[roulette[i]objectForKey:@"productname"] andCGPoint:CGPointMake(35*DEF_Adaptation_Font*0.5, 255*DEF_Adaptation_Font*0.5+_currentTimeY+_currentPriceY) andTag:i+200];
        [contentSelectView addSubview:priceBtn];
        CGFloat width = [[roulette[i]objectForKey:@"productname"] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:priceBtn.titleLabel.font.fontName size:priceBtn.titleLabel.font.pointSize]}].width+50*DEF_Adaptation_Font;
        if (i>=1) {
            CGRect frame=priceBtn.frame;
            if ([self.priceBtnWidthArr[i-1]integerValue]+width+70*DEF_Adaptation_Font*0.5<DEF_WIDTH(self)) {
                frame.origin.x=[self.priceBtnWidthArr[i-1]integerValue]+35*DEF_Adaptation_Font*0.5;
                width=frame.origin.x+35*DEF_Adaptation_Font*0.5;
            }else{
                frame.origin.y+=90*DEF_Adaptation_Font*0.5;
                _currentPriceY=  frame.origin.y-255*DEF_Adaptation_Font*0.5-_currentTimeY;
            }
            priceBtn.frame=frame;
        }
        [self.priceBtnWidthArr addObject:@(width+35*DEF_Adaptation_Font*0.5)];
        [self.priceBtnArr addObject:priceBtn];
        }
    }
    if (self.priceBtnArr.count==1) {
        UIButton *btn=self.priceBtnArr.firstObject;
        self.currentPriceBtn=btn;
        btn.selected=YES;
        [btn.layer setBorderColor: [ColorRGB(181, 252, 255, 1.0) CGColor]];
        [btn setTitleColor:ColorRGB(181, 252, 255, 1.0) forState:UIControlStateSelected];
        btn.userInteractionEnabled=NO;
    }

    
    UIImageView *numberIV=[[UIImageView alloc]initWithFrame:CGRectMake(37*DEF_Adaptation_Font*0.5, 375*DEF_Adaptation_Font*0.5+_currentTimeY+_currentPriceY, 84*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    numberIV.image=[UIImage imageNamed:@"selectNumber.png"];
    [contentSelectView addSubview:numberIV];
    UIView *selectNumberV=[[UIView alloc]initWithFrame:CGRectMake(35*DEF_Adaptation_Font*0.5, 425*DEF_Adaptation_Font*0.5+_currentTimeY+_currentPriceY, 95*DEF_Adaptation_Font, 56*DEF_Adaptation_Font*0.5)];
    selectNumberV.layer.masksToBounds = YES;
    selectNumberV.layer.borderWidth = 1;
    selectNumberV.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    selectNumberV.layer.cornerRadius = 3;
    [contentSelectView addSubview:selectNumberV];
    UIButton *addBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(0, 0) andTag:104 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake( 56*DEF_Adaptation_Font*0.5,  56*DEF_Adaptation_Font*0.5) andTarget:self];
    self.subBtn=addBtn;
    [addBtn setTitle:@"-" forState:(UIControlStateNormal)];
     [addBtn setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:14.f]];
    [addBtn setTintColor:[UIColor whiteColor]];
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [selectNumberV addSubview:addBtn];
    UIButton *subBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(DEF_WIDTH(selectNumberV)-56*DEF_Adaptation_Font*0.5, 0) andTag:103 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake( 56*DEF_Adaptation_Font*0.5,  56*DEF_Adaptation_Font*0.5) andTarget:self];
    [subBtn setTitle:@"+" forState:(UIControlStateNormal)];
    [subBtn setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:14.f]];
    [subBtn setTintColor:[UIColor whiteColor]];
    subBtn.layer.borderWidth = 1;
    subBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [selectNumberV addSubview:subBtn];
    self.numberLB=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(selectNumberV)/2-28*DEF_Adaptation_Font*0.5, 0,  56*DEF_Adaptation_Font*0.5, 56*DEF_Adaptation_Font*0.5)];
    self.numberLB.textColor=[UIColor whiteColor];
    self.numberLB.text=[NSString stringWithFormat:@"%ld",payNumber];
    self.numberLB.textAlignment=NSTextAlignmentCenter;
    [selectNumberV addSubview:self.numberLB];
    if (payNumber<=1) {
        [addBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    }else{
        [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }
    if (payNumber>=1) {
        [subBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    }else{
        [subBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }
    
//修改scrollV的contentSize
    contentSelectView.contentSize=CGSizeMake( DEF_WIDTH(self), 530*DEF_Adaptation_Font*0.5+_currentTimeY+_currentPriceY);
    self.payBtn=[self creatButton:@"立即购买" andCGRect:CGRectMake(0, DEF_HEIGHT(self)-86*DEF_Adaptation_Font*0.5,DEF_WIDTH(self), 86*DEF_Adaptation_Font*0.5) andTag:105];
     if (self.currentTimeBtn.isSelected==YES&&self.currentPriceBtn.isSelected==YES&&payNumber>0) {
    self.payBtn.backgroundColor=ColorRGB(42, 195, 192, 1.0);
     }else{
         self.payBtn.backgroundColor=[UIColor lightGrayColor];
     }
    [self addSubview: self.payBtn];
    [self creatBKView];
}
- (NSDate *)timeWithTimeIntervalString:(NSString *)timeString
{
    //    NSTimeInterval time=[timeString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[timeString doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    return  detaildate;
}
-(void)creatBKView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:99 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
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
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
    if (tag<self.priceBtnArr.count+200&&tag>=200) {
        self.currentPriceBtn=button;
        if (button.isSelected==YES) {
            [button setSelected:NO];
             [button.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }else{
            [button setSelected:YES];
             [button.layer setBorderColor: [ColorRGB(181, 252, 255, 1.0) CGColor]];
            [button setTitleColor:ColorRGB(181, 252, 255, 1.0) forState:UIControlStateSelected];
            for (UIButton *btn in self.priceBtnArr) {
                if (btn.tag!=tag) {
                [btn setSelected:NO];
                    [btn.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
        }
    }
    if (tag<self.timeBtnArr.count&&tag>=0) {
        self.currentTimeBtn=button;
        if (button.isSelected==YES) {
            [button setSelected:NO];
             [button.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [button setSelected:YES];
            [button.layer setBorderColor: [ColorRGB(181, 252, 255, 1.0) CGColor]];
            [button setTitleColor:ColorRGB(181, 252, 255, 1.0) forState:UIControlStateSelected];
            for (UIButton *btn in self.timeBtnArr) {
                if (btn.tag!=tag) {
                    [btn setSelected:NO];
                     [btn.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
        }
    }

    if (tag==99) {
        [self.obj popViewController];
    }
    if (tag==100) {
        //time
        if (button.isSelected==YES) {
            [button setSelected:NO];
            button.backgroundColor=[UIColor whiteColor];
        }else{
         [button setSelected:YES];
            button.backgroundColor=ColorRGB(227, 245, 235, 1.0);
        }
    }
    if (tag==103) {
        //add
        payNumber++;
        self.numberLB.text=[NSString stringWithFormat:@"%ld",payNumber];
        //如果超过上限
        if (payNumber>1) {
            self.numberLB.text=@"1";
            payNumber=1;
            [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        }
        if (payNumber>1) {
         [self.subBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
    }
    if (tag==104) {
      //  sub
        payNumber--;
        self.numberLB.text=[NSString stringWithFormat:@"%ld",payNumber];
        if (payNumber<=1) {
            self.numberLB.text=@"1";
            payNumber=1;
            [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }

    }
    if (tag==105) {
        //pay
        if (self.currentTimeBtn.isSelected==YES&&self.currentPriceBtn.isSelected==YES&&payNumber>0) {
            
            TicketPayView *ticketPayV=[[TicketPayView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self andDataDic:self.dataDic andPayNumber:payNumber andOrderDic:[self.orderDic objectForKey:@"roulette"][self.currentPriceBtn.tag-200] andTime:self.currentTimeBtn.titleLabel.text];
        [self addSubview:ticketPayV];
        }else{
            button.backgroundColor=[UIColor lightGrayColor];
        }
    }
    if (self.currentTimeBtn.isSelected==YES&&self.currentPriceBtn.isSelected==YES&&payNumber>0) {
        self.payBtn.backgroundColor=ColorRGB(42, 195, 192, 1.0);
    }else{
        self.payBtn.backgroundColor=[UIColor lightGrayColor];
    }
}
-(UIButton *)publishButton:(NSString *)str andCGPoint:(CGPoint)point andTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    //对按钮的外形做了设定，不喜可删~
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    btn.layer.cornerRadius = 3;
    btn.tag=tag;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(btnOnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    //重要的是下面这部分哦！
    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
    
    titleSize.height = 60*DEF_Adaptation_Font*0.5;
    titleSize.width += 50*DEF_Adaptation_Font;
    
    btn.frame = CGRectMake(point.x, point.y, titleSize.width, titleSize.height);
    return btn;

}
@end
