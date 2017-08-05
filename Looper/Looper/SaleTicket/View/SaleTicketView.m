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
@end
@implementation SaleTicketView
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
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDataDic:(NSDictionary *)dataDic{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (SaleTicketViewModel*)idObject;
        payNumber=1;
        self.currentTimeY=0;
        self.dataDic=dataDic;
        [self initView];
    }
    return self;
}
-(void)initView{
     NSDictionary *activityDic=[self.dataDic objectForKey:@"data"];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, 108*DEF_Adaptation_Font*0.5, 170*DEF_Adaptation_Font*0.5, 256*DEF_Adaptation_Font*0.5)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[activityDic objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self addSubview:imageView];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(230*DEF_Adaptation_Font*0.5, 118*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-265*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5)];
    contentLB.text=[activityDic objectForKey:@"activityname"];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:16];
    CGSize lblSize = [contentLB.text boundingRectWithSize:CGSizeMake(DEF_WIDTH(self)-260*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGRect frame=contentLB.frame;
    frame.size.height=lblSize.height;
    contentLB.frame=frame;
    [self addSubview:contentLB];
    UIImageView *locationLV=[[UIImageView alloc]initWithFrame:CGRectMake(230*DEF_Adaptation_Font*0.5, 216*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    locationLV.image=[UIImage imageNamed:@"locaton.png"];
    [self addSubview:locationLV];
    UILabel *locationLB=[[UILabel alloc]initWithFrame:CGRectMake(264*DEF_Adaptation_Font*0.5, 216*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-299*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
      locationLB.font=[UIFont systemFontOfSize:13];
    locationLB.text=[activityDic objectForKey:@"location"];
    CGSize lblSize2 = [locationLB.text boundingRectWithSize:CGSizeMake(DEF_WIDTH(self)-299*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGRect frame2=locationLB.frame;
    frame2.size=lblSize2;
    locationLB.frame=frame2;
    locationLB.numberOfLines=0;
    locationLB.textColor=ColorRGB(223, 219, 234, 1.0);
    [self addSubview:locationLB];
    UIImageView *lineIV=[[UIImageView alloc]initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, 405*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 1)];
    lineIV.image=[UIImage imageNamed:@"cutoffLine.png"];
    [self addSubview:lineIV];
    
    
    
    UIScrollView *contentSelectView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 405*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-491*DEF_Adaptation_Font*0.5)];
    contentSelectView.delegate = self;
    [self addSubview:contentSelectView];
    
    
    UIImageView *timeIV=[[UIImageView alloc]initWithFrame:CGRectMake(37*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 84*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    timeIV.image=[UIImage imageNamed:@"selectTime.png"];
    [contentSelectView addSubview:timeIV];
//使按钮可以平铺。如果右边距离不够自动切换到下一行
    for (int i=0; i<2; i++) {
  UIButton *timeBtn=[self publishButton:@"2017-8月5号" andCGPoint:CGPointMake(35*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5+_currentTimeY) andTag:i];
    [contentSelectView addSubview:timeBtn];
    CGFloat width = [@"2017-8月5号" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:timeBtn.titleLabel.font.fontName size:timeBtn.titleLabel.font.pointSize]}].width+50*DEF_Adaptation_Font;
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
    }
    UIImageView *priceIV=[[UIImageView alloc]initWithFrame:CGRectMake(37*DEF_Adaptation_Font*0.5, 205*DEF_Adaptation_Font*0.5+_currentTimeY, 84*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    priceIV.image=[UIImage imageNamed:@"selectPrice.png"];
    [contentSelectView addSubview:priceIV];
//使按钮可以平铺。如果右边距离不够自动切换到下一行
    for (int i=0; i<2; i++) {
        UIButton *priceBtn=[self publishButton:@"$189普通票" andCGPoint:CGPointMake(35*DEF_Adaptation_Font*0.5, 255*DEF_Adaptation_Font*0.5+_currentTimeY+_currentPriceY) andTag:i+200];
        [contentSelectView addSubview:priceBtn];
        CGFloat width = [@"$189普通票" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:priceBtn.titleLabel.font.fontName size:priceBtn.titleLabel.font.pointSize]}].width+50*DEF_Adaptation_Font;
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
    if (self.priceBtnArr.count==1) {
        UIButton *btn=self.priceBtnArr.firstObject;
        self.currentPriceBtn=btn;
        btn.selected=YES;
        [btn.layer setBorderColor: [ColorRGB(181, 252, 255, 1.0) CGColor]];
        [btn setTitleColor:ColorRGB(181, 252, 255, 1.0) forState:UIControlStateSelected];
    }

    
    UIImageView *numberIV=[[UIImageView alloc]initWithFrame:CGRectMake(37*DEF_Adaptation_Font*0.5, 375*DEF_Adaptation_Font*0.5+_currentTimeY+_currentPriceY, 84*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    numberIV.image=[UIImage imageNamed:@"selectNumber.png"];
    [contentSelectView addSubview:numberIV];
    UIView *selectNumberV=[[UIView alloc]initWithFrame:CGRectMake(35*DEF_Adaptation_Font*0.5, 425*DEF_Adaptation_Font*0.5+_currentTimeY+_currentPriceY, 140*DEF_Adaptation_Font, 80*DEF_Adaptation_Font*0.5)];
    selectNumberV.layer.masksToBounds = YES;
    selectNumberV.layer.borderWidth = 1;
    selectNumberV.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    selectNumberV.layer.cornerRadius = 3;
    [contentSelectView addSubview:selectNumberV];
    UIButton *addBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(0, 0) andTag:103 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake( 80*DEF_Adaptation_Font*0.5,  80*DEF_Adaptation_Font*0.5) andTarget:self];
    [addBtn setTitle:@"+" forState:(UIControlStateNormal)];
    [addBtn setTintColor:[UIColor whiteColor]];
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [selectNumberV addSubview:addBtn];
    UIButton *subBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(DEF_WIDTH(selectNumberV)-80*DEF_Adaptation_Font*0.5, 0) andTag:104 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake( 80*DEF_Adaptation_Font*0.5,  80*DEF_Adaptation_Font*0.5) andTarget:self];
    [subBtn setTitle:@"-" forState:(UIControlStateNormal)];
    [subBtn setTintColor:[UIColor whiteColor]];
    subBtn.layer.borderWidth = 1;
    subBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [selectNumberV addSubview:subBtn];
    self.numberLB=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(selectNumberV)/2-40*DEF_Adaptation_Font*0.5, 0,  80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    self.numberLB.textColor=[UIColor whiteColor];
    self.numberLB.text=[NSString stringWithFormat:@"%ld",payNumber];
    self.numberLB.textAlignment=NSTextAlignmentCenter;
    [selectNumberV addSubview:self.numberLB];
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
    }
    if (tag==104) {
      //  sub
        payNumber--;
        self.numberLB.text=[NSString stringWithFormat:@"%ld",payNumber];
        if (payNumber<=0) {
            self.numberLB.text=@"0";
            payNumber=0;
        }
    }
    if (tag==105) {
        //pay
        if (self.currentTimeBtn.isSelected==YES&&self.currentPriceBtn.isSelected==YES&&payNumber>0) {
        TicketPayView *ticketPayV=[[TicketPayView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self andDataDic:self.dataDic];
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
