//
//  ShoppingDetailView.m
//  Looper
//
//  Created by 工作 on 2017/11/7.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ShoppingDetailView.h"
#import "MallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "SlidingScrolleview.h"
#import "ShoppingPhotoView.h"
#import "MallPayView.h"
#define ScrollY 0
@interface ShoppingDetailView()<UIScrollViewDelegate,SlidingScrolleviewDelegate>
{
    UIScrollView *scrollV;
    NSArray *photoArr;
}
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation ShoppingDetailView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataDic:(NSDictionary*)dataDic{
    if (self=[super initWithFrame:frame]) {
        self.obj=(MallViewModel *)obj;
        self.dataDic=dataDic;
        NSString *dataStr=[dataDic objectForKey:@"commodityimageurl"];
        photoArr = [dataStr componentsSeparatedByString:@","];
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor=ColorRGB(39, 39, 72, 1.0);
    [self initBackView];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag ==100){
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        if (1) {
            [self.obj createMallPayViewWithDataDic:self.dataDic];
        }
    }
}

-(void)initBackView{
    scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ScrollY, DEF_WIDTH(self), DEF_HEIGHT(self)-ScrollY-84*DEF_Adaptation_Font*0.5)];
    scrollV.delegate=self;
    scrollV.backgroundColor=[UIColor clearColor];
//去除惯性滑动
    scrollV.decelerationRate = 0; 
    [self addSubview:scrollV];
    SlidingScrolleview *scrollview = [[SlidingScrolleview alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_WIDTH(self))];
    [scrollview setImageArr:photoArr];
    scrollview.delegate=self;
    [scrollV addSubview:scrollview];
    
    [self creatScrollView];
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    UIButton *buyBtn = [LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(0,DEF_HEIGHT(self)- 84*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(DEF_WIDTH(self),84*DEF_Adaptation_Font*0.5) andTarget:self];
    [buyBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    buyBtn.backgroundColor=ColorRGB(138, 141, 251, 1.0);
    [self addSubview:buyBtn];
}
-(void)creatScrollView{
    UIView *detailV=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_WIDTH(self)- ScrollY, DEF_WIDTH(self), 400*DEF_Adaptation_Font*0.5)];
    detailV.backgroundColor=ColorRGB(39, 39, 72, 1.0);
    [scrollV addSubview:detailV];
    UILabel *titleLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 22*DEF_Adaptation_Font*0.5, 575*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    titleLB.text=[NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"commodityname"]];
    titleLB.font=[UIFont boldSystemFontOfSize:18];
    titleLB.textColor=[UIColor whiteColor];
    [detailV addSubview:titleLB];
    UILabel *integralLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5, 575*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    integralLB.text=[NSString stringWithFormat:@"我的积分：%@积分",[self.dataDic objectForKey:@"credit"]];
    integralLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    integralLB.textColor=[UIColor whiteColor];
    [detailV addSubview:integralLB];
//积分按钮
//    [self creatIntergralBtn:detailV];
    [self creatIntergralBtnIfEnough:detailV];

    UIView *titleV1=[self createTitleViewWithPoint:CGPointMake(0, 237*DEF_Adaptation_Font*0.5) andTitle:@"商品详情"];
    [detailV addSubview:titleV1];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(32*DEF_Adaptation_Font*0.5, 292*DEF_Adaptation_Font*0.5, 576*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5)];
    contentLB.text=[self.dataDic objectForKey:@"subhead"];
    contentLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.numberOfLines=0;
    CGSize lblSize2 = [contentLB.text boundingRectWithSize:CGSizeMake(576*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame2=contentLB.frame;
    frame2.size=lblSize2;
    contentLB.frame=frame2;
    [detailV addSubview:contentLB];
//加入图片
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, DEF_Y(contentLB)+lblSize2.height+40*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self))];
    imageView.image=[UIImage imageNamed:@"640-2.png"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    [detailV addSubview:imageView];
    
    UIView *argumentBtn=[[UIView alloc]initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5, DEF_Y(imageView)+DEF_HEIGHT(imageView)+10*DEF_Adaptation_Font*0.5, 640*DEF_Adaptation_Font*0.5, 110*DEF_Adaptation_Font*0.5)];
    argumentBtn.tag=101;
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIntergralBtn:)];
    [argumentBtn addGestureRecognizer:tap1];
    [detailV addSubview:argumentBtn];
    UIView *titleV2=[self createTitleViewWithPoint:CGPointMake(0,42*DEF_Adaptation_Font*0.5) andTitle:@"商品参数"];
    [argumentBtn addSubview:titleV2];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 109*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-62*DEF_Adaptation_Font*0.5, 1.0*DEF_Adaptation_Font*0.5)];
    lineView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    [argumentBtn addSubview:lineView];
    
    UIView *locationBtn=[[UIView alloc]initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5, DEF_Y(argumentBtn)+DEF_HEIGHT(argumentBtn)+10*DEF_Adaptation_Font*0.5, 640*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5)];
    locationBtn.tag=102;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIntergralBtn:)];
    [locationBtn addGestureRecognizer:tap2];
    [detailV addSubview:locationBtn];
    UIView *titleV3=[self createTitleViewWithPoint:CGPointMake(0,32*DEF_Adaptation_Font*0.5) andTitle:@"配送范围"];
    [locationBtn addSubview:titleV3];
    UILabel *locationLB=[[UILabel alloc]initWithFrame:CGRectMake(53*DEF_Adaptation_Font*0.5, 77*DEF_Adaptation_Font*0.5, 580*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5)];
    locationLB.text=@"中国大陆地区";
    locationLB.font=[UIFont boldSystemFontOfSize:16];
    locationLB.textColor=ColorRGB(179, 188, 215, 1.0);
    [locationBtn addSubview:locationLB];
    
    
    CGRect detailFrame=detailV.frame;
    detailFrame.size.height=DEF_Y(locationBtn)+DEF_HEIGHT(locationBtn);
    detailV.frame=detailFrame;
    scrollV.contentSize=CGSizeMake(DEF_WIDTH(self), DEF_HEIGHT(detailV)+DEF_WIDTH(self)- ScrollY);
}


-(UIView *)createTitleViewWithPoint:(CGPoint)point andTitle:(NSString *)title{
    UIView *titleV=[[UIView alloc]initWithFrame:CGRectMake(point.x, point.y, DEF_WIDTH(self), 25*DEF_Adaptation_Font*0.5)];
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 4*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=ColorRGB(136, 131, 252, 1.0);
    [titleV addSubview:lineV];
    UILabel *titleLB=[[UILabel alloc]initWithFrame:CGRectMake(53*DEF_Adaptation_Font*0.5, 0, 580*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    titleLB.text=title;
    titleLB.font=[UIFont boldSystemFontOfSize:14];
    titleLB.textColor=[UIColor whiteColor];
    [titleV addSubview:titleLB];
    return titleV;
}
-(void)creatIntergralBtn:(UIView *)superV{
    UIView *intergralBtn=[[UIView alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 118*DEF_Adaptation_Font*0.5, 185*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    intergralBtn.layer.borderWidth=1.0*DEF_Adaptation_Font*0.5;
    intergralBtn.layer.borderColor=[ColorRGB(255, 255, 255, 0.8)CGColor];
    intergralBtn.tag=100;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIntergralBtn:)];
    [intergralBtn addGestureRecognizer:tap];
    [superV addSubview:intergralBtn];
    UIImageView *intergralIV=[[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    intergralIV.image=[UIImage imageNamed:@"store_intergral"];
    [intergralBtn addSubview:intergralIV];
    UILabel *LB=[[UILabel alloc]initWithFrame:CGRectMake(60*DEF_Adaptation_Font*0.5, 8*DEF_Adaptation_Font*0.5, 125*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5)];
    LB.text=[NSString stringWithFormat:@"%@积分",[_dataDic objectForKey:@"credit"]];
    CGSize lblSize2 = [LB.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 26*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
    CGRect frame2=LB.frame;
    frame2.size=lblSize2;
    LB.frame=frame2;
    LB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    LB.textColor=ColorRGB(170, 170, 178, 1.0);
    [intergralBtn addSubview:LB];
    CGRect frame=intergralBtn.frame;
    frame.size.width=DEF_X(LB)+DEF_WIDTH(LB)+10*DEF_Adaptation_Font*0.5;
    intergralBtn.frame=frame;
    UILabel *LB2=[[UILabel alloc]initWithFrame:CGRectMake(10*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font*0.5, DEF_WIDTH(intergralIV)-20*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font*0.5)];
    LB2.text=@"积分不足";
    LB2.textAlignment=NSTextAlignmentCenter;
    LB2.font=[UIFont fontWithName:@"STHeitiTC-Light" size:10.f];
    LB2.textColor=[UIColor whiteColor];
    [intergralBtn addSubview:LB2];
}
-(void)creatIntergralBtnIfEnough:(UIView *)superV{
    UIView *intergralBtn=[[UIView alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 118*DEF_Adaptation_Font*0.5, 185*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    intergralBtn.layer.borderWidth=1.0*DEF_Adaptation_Font*0.5;
    intergralBtn.layer.borderColor=[ColorRGB(136,130,248, 1.0)CGColor];
    intergralBtn.tag=100;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIntergralBtn:)];
    [intergralBtn addGestureRecognizer:tap];
    [superV addSubview:intergralBtn];
    UIImageView *intergralIV=[[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 19*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    intergralIV.image=[UIImage imageNamed:@"store_intergral"];
    [intergralBtn addSubview:intergralIV];
    UILabel *LB=[[UILabel alloc]initWithFrame:CGRectMake(65*DEF_Adaptation_Font*0.5, 15*DEF_Adaptation_Font*0.5, 125*DEF_Adaptation_Font*0.5, 38*DEF_Adaptation_Font*0.5)];
    LB.text=[NSString stringWithFormat:@"%@积分",[_dataDic objectForKey:@"credit"]];
    CGSize lblSize2 = [LB.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 26*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:15.f]} context:nil].size;
    CGRect frame2=LB.frame;
    frame2.size=lblSize2;
    LB.frame=frame2;
    LB.textColor=ColorRGB(136,130,248, 1.0);
    LB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    [intergralBtn addSubview:LB];
    CGRect frame=intergralBtn.frame;
    frame.size.width=DEF_X(LB)+DEF_WIDTH(LB)+10*DEF_Adaptation_Font*0.5;
    if (frame.size.width<185*DEF_Adaptation_Font*0.5) {
        frame.size.width=185*DEF_Adaptation_Font*0.5;
    }
    intergralBtn.frame=frame;
}
-(void)clickIntergralBtn:(UITapGestureRecognizer *)tap{
    NSInteger tag=tap.view.tag;
    if (tag==100) {
//点击积分按钮
        [self.obj createMallPayViewWithDataDic:self.dataDic];
    }if (tag==101) {
//商品参数
        [self.obj createShoppingArgumentVWithDataDic:self.dataDic];
    }if (tag==102) {
//配送范围
    }
}

-(void)slidingClickImage_index:(int)index{
    ShoppingPhotoView *shopV=[[ShoppingPhotoView alloc]initWithFrame:self.bounds andObject:self.obj andPhotoArr:photoArr andIntex:index];
    [self addSubview:shopV];
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat yOffset  = scrollView.contentOffset.y;
//    UIPanGestureRecognizer *pan=scrollView.panGestureRecognizer;
//    CGFloat moveY=[pan translationInView:self].y;
////往上移，yoffset是正的，moveY是负的
//    NSLog(@"originY:%f,scrollY:%lf ---- moveY:%f,Yoffset:%f",DEF_WIDTH(self),DEF_Y(scrollView),moveY,yOffset);
//    if (DEF_Y(scrollView)>=0*DEF_Adaptation_Font*0.5&&DEF_Y(scrollView)<=DEF_WIDTH(self)) {
//        CGRect frame=scrollV.frame;
//           frame.origin.y+=moveY;
//
////        frame.size.height+=yOffset;
//        scrollV.frame=frame;
//    }
//    else if (moveY>0&&DEF_Y(scrollView)==-1){
//        CGRect frame=scrollV.frame;
//            frame.origin.y+=moveY;
//        //        frame.size.height+=yOffset;
//        scrollV.frame=frame;
//    }
//    else if (DEF_Y(scrollView)<0){
//        CGRect frame=scrollV.frame;
//        frame.origin.y=-1;
////        frame.size.height=DEF_HEIGHT(self)-84*DEF_Adaptation_Font*0.5;
//        scrollV.frame=frame;
//    }
//   else  if(DEF_Y(scrollView)>DEF_WIDTH(self)){
//        CGRect frame=scrollV.frame;
//        frame.origin.y=DEF_WIDTH(self);
////        frame.size.height=DEF_HEIGHT(self)-ScrollY-84*DEF_Adaptation_Font*0.5;
//        scrollV.frame=frame;
//    }
//}

@end
