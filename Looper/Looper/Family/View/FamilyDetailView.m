//
//  FamilyDetailView.m
//  Looper
//
//  Created by 工作 on 2017/8/30.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyDetailView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "CycleView.h"
#import "UIImageView+WebCache.h"
#import "FamilyHeaderView.h"
#import "DataHander.h"
@interface FamilyDetailView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    UILabel *logLB;
    UILabel *applyListLB;
    UILabel *noticeLB;
    UIView *lineView;
    //用于界面的轻扫切换
    UIScrollView *scrollV;
    CycleView *cycleView;
}

@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *rankNumber;
@end
@implementation FamilyDetailView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataDic:(NSDictionary *)dataDic andRankNumber:(NSString *)rankNumber{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataDic=dataDic;
        self.rankNumber=rankNumber;
        self.liveshowArr=@[@1,@2,@3,@4];
        [self initView];
        [self setBackView];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}
    return self;
}
-(void)setBackView{
    [self setBackgroundColor:[UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0]];
    self.layer.cornerRadius=12.0*DEF_Adaptation_Font;
    self.layer.masksToBounds=YES;

}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
     if (tag<=self.applyArr.count||tag>=-self.applyArr.count) {
    if (tag>0) {
        NSDictionary *dataDic=self.applyArr[button.tag-1];
        //同意
        [self.obj judgeJoinFamilyWithJoin:@"1" andRaverId:[dataDic objectForKey:@"raverid"] andApplyId:[dataDic objectForKey:@"applyid"] andUserId:[dataDic objectForKey:@"userid"]];
    }else{
        NSDictionary *dataDic=self.applyArr[-tag-1];
        //拒绝
        [self.obj judgeJoinFamilyWithJoin:@"0" andRaverId:[dataDic objectForKey:@"raverid"] andApplyId:[dataDic objectForKey:@"applyid"] andUserId:[dataDic objectForKey:@"userid"]];
    }
    }else{
      [[DataHander sharedDataHander] showViewWithStr:@"不可识别的申请信息" andTime:1 andPos:CGPointZero];
    }
}

-(void)clickLiveShow:(UITapGestureRecognizer *)tap{

    
    
}
-(void)initView{
    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), 96*DEF_Adaptation_Font*0.5)];
    [self addSubview:headView];
    headView.image=[UIImage imageNamed:@"family_header_bottom.png"];
    UIImageView *topIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 92*DEF_Adaptation_Font*0.5, 82*DEF_Adaptation_Font*0.5)];
    [headView addSubview:topIV];
    topIV.image=[UIImage imageNamed:[NSString stringWithFormat:@"familyRank_top%@.png",self.rankNumber]];
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(120*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-240*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    [headView addSubview:nameLB];
    nameLB.textColor=[UIColor whiteColor];
    nameLB.textAlignment=NSTextAlignmentCenter;
    nameLB.text=self.dataDic[@"ravername"];
    UILabel *idLB=[[UILabel alloc]initWithFrame:CGRectMake(110*DEF_Adaptation_Font*0.5, 66*DEF_Adaptation_Font*0.5, 134*DEF_Adaptation_Font*0.5, 22*DEF_Adaptation_Font*0.5)];
    [headView addSubview:idLB];
    idLB.textColor=ColorRGB(255, 255, 255, 0.88);
    idLB.textAlignment=NSTextAlignmentCenter;
    idLB.text=[NSString stringWithFormat:@"ID:%@",[self.dataDic objectForKey:@"raverid"]];
    idLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    UILabel *levelLB=[[UILabel alloc]initWithFrame:CGRectMake(349*DEF_Adaptation_Font*0.5, 66*DEF_Adaptation_Font*0.5, 110*DEF_Adaptation_Font*0.5, 22*DEF_Adaptation_Font*0.5)];
    [headView addSubview:levelLB];
    levelLB.textColor=ColorRGB(255, 255, 255, 0.88);
    levelLB.textAlignment=NSTextAlignmentCenter;
    levelLB.text=[NSString stringWithFormat:@"等级:%@级",[self.dataDic objectForKey:@"raverlevel"]];
    levelLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    UIImageView *SQCodeIV=[[UIImageView alloc]initWithFrame:CGRectMake(520*DEF_Adaptation_Font*0.5, 33*DEF_Adaptation_Font*0.5, 38*DEF_Adaptation_Font*0.5, 38*DEF_Adaptation_Font*0.5)];
    [self addSubview:SQCodeIV];
    if ([self.dataDic objectForKey:@"raverqrcodeurl"]==[NSNull null]) {
    SQCodeIV.image=[UIImage imageNamed:@"familydetail_code.png"];
    }else{
        [SQCodeIV sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"raverqrcodeurl"]]placeholderImage:nil options:SDWebImageRetryFailed];
    }
    cycleView=[[CycleView alloc]initWithFrame:CGRectMake(211*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5, 168*DEF_Adaptation_Font*0.5, 168*DEF_Adaptation_Font*0.5)];
    [cycleView.imageV sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"images"]]placeholderImage:[UIImage imageNamed:@"btn_home.png"]options:SDWebImageRetryFailed];
    cycleView.imageV.userInteractionEnabled=YES;
    cycleView.imageV.tag=5;
    UITapGestureRecognizer *singleTap5 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [cycleView.imageV addGestureRecognizer:singleTap5];
    cycleView.backgroundColor=[UIColor grayColor];
    cycleView.layer.cornerRadius=DEF_WIDTH(cycleView)/2;
    cycleView.layer.masksToBounds=YES;
    [cycleView drawProgress:[[self.dataDic objectForKey:@"raverexp"]floatValue]/16000];
    [self addSubview:cycleView];
    
    UILabel *titleLB=nil;
    UILabel *titleLB2=nil;
    UILabel *integralLB=nil;
    UILabel *integralLB2=nil;
    UILabel *numberLB=nil;
    UILabel *numberLB2=nil;
    UILabel *activeLB=nil;
    UILabel *activeLB2=nil;
    if (self.liveshowArr.count>0) {
        titleLB=[[UILabel alloc]initWithFrame:CGRectMake(64*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
         titleLB2=[[UILabel alloc]initWithFrame:CGRectMake(140*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        integralLB=[[UILabel alloc]initWithFrame:CGRectMake(64*DEF_Adaptation_Font*0.5, 320*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        integralLB2=[[UILabel alloc]initWithFrame:CGRectMake(140*DEF_Adaptation_Font*0.5, 320*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        numberLB=[[UILabel alloc]initWithFrame:CGRectMake(340*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        numberLB2=[[UILabel alloc]initWithFrame:CGRectMake(430*DEF_Adaptation_Font*0.5, 260*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
         activeLB=[[UILabel alloc]initWithFrame:CGRectMake(340*DEF_Adaptation_Font*0.5, 320*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        activeLB2=[[UILabel alloc]initWithFrame:CGRectMake(430*DEF_Adaptation_Font*0.5, 320*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
       
    }else{
        titleLB=[[UILabel alloc]initWithFrame:CGRectMake(64*DEF_Adaptation_Font*0.5, 280*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        titleLB2=[[UILabel alloc]initWithFrame:CGRectMake(140*DEF_Adaptation_Font*0.5, 280*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        integralLB=[[UILabel alloc]initWithFrame:CGRectMake(64*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        integralLB2=[[UILabel alloc]initWithFrame:CGRectMake(140*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        numberLB=[[UILabel alloc]initWithFrame:CGRectMake(340*DEF_Adaptation_Font*0.5, 280*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        numberLB2=[[UILabel alloc]initWithFrame:CGRectMake(430*DEF_Adaptation_Font*0.5, 280*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        activeLB=[[UILabel alloc]initWithFrame:CGRectMake(340*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
        activeLB2=[[UILabel alloc]initWithFrame:CGRectMake(430*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    }
   
    titleLB.text=@"舰长：";
    titleLB.textColor=ColorRGB(255, 255, 255, 0.8);
    titleLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [self addSubview:titleLB];
    titleLB2.text=[_dataDic objectForKey:@"ownername"];
    titleLB2.textColor=ColorRGB(255, 255, 255, 1);
    titleLB2.font=[UIFont systemFontOfSize:13];
    [self addSubview:titleLB2];
    
    integralLB.text=@"积分：";
    integralLB.textColor=ColorRGB(255, 255, 255, 0.8);
    integralLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [self addSubview:integralLB];
    integralLB2.text=[_dataDic objectForKey:@"raverexp"];
    integralLB2.textColor=ColorRGB(255, 255, 255, 1);
    integralLB2.font=[UIFont systemFontOfSize:13];
    [self addSubview:integralLB2];
    
    numberLB.text=@"人数：";
    numberLB.textColor=ColorRGB(255, 255, 255, 0.8);
    numberLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [self addSubview:numberLB];
    numberLB2.text=[NSString stringWithFormat:@"%@/500",[_dataDic objectForKey:@"membercount"]];
    numberLB2.textColor=ColorRGB(255, 255, 255, 1);
    numberLB2.font=[UIFont systemFontOfSize:13];
    [self addSubview:numberLB2];
    
   
    activeLB.text=@"活跃：";
    activeLB.textColor=ColorRGB(255, 255, 255, 0.8);
    activeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [self addSubview:activeLB];
    activeLB2.text=[_dataDic objectForKey:@"raveractive"];
    activeLB2.textColor=ColorRGB(233, 117, 149, 1.0);
    activeLB2.font=[UIFont systemFontOfSize:13];
    [self addSubview:activeLB2];
    
//填写liveshow内容
#warning -LiveShowData

    if (self.liveshowArr.count>0) {
    UIScrollView *liveShowSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 380*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 140*DEF_Adaptation_Font*0.5)];
    liveShowSV.contentSize=CGSizeMake(270*DEF_Adaptation_Font*0.5*self.liveshowArr.count+20*DEF_Adaptation_Font*0.5, 140*DEF_Adaptation_Font*0.5);
    liveShowSV.showsHorizontalScrollIndicator = FALSE;
        liveShowSV.delegate=self;
        liveShowSV.tag=101;
        liveShowSV.bounces=NO;
    [self addSubview:liveShowSV];
    for (int i=0; i<self.liveshowArr.count; i++) {
        UIImageView *liveshowIV=[[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5*(i+1)+250*DEF_Adaptation_Font*0.5*i, 0, 250*DEF_Adaptation_Font*0.5, 140*DEF_Adaptation_Font*0.5)];
        liveshowIV.image=[UIImage imageNamed:@"bk_home1.png"];
        [liveShowSV addSubview:liveshowIV];
        liveshowIV.tag=i;
        liveshowIV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLiveShow:)];
        [liveshowIV addGestureRecognizer:tap];
        liveshowIV.layer.cornerRadius=20.0*DEF_Adaptation_Font*0.5;
        liveshowIV.layer.masksToBounds=YES;
        
        UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, DEF_WIDTH(liveshowIV)-40*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5)];
        contentLB.shadowColor = [UIColor grayColor];
        //阴影偏移  x，y为正表示向右下偏移
        contentLB.shadowOffset = CGSizeMake(0.5, 0.5);
        contentLB.text=@"2017百威风暴电音节广东站";
        contentLB.font=[UIFont systemFontOfSize:12];
        contentLB.textColor=[UIColor whiteColor];
        contentLB.textAlignment=NSTextAlignmentCenter;
        contentLB.numberOfLines=2;
        [liveshowIV addSubview:contentLB];
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        NSInteger timeNow =(long)[datenow timeIntervalSince1970];
//        if (timeNow>[dic[@"endtime"]integerValue]) {
            UIImageView *finishView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 100*DEF_Adaptation_Font*0.5, DEF_WIDTH(liveshowIV), 40*DEF_Adaptation_Font*0.5)];
            finishView.image=[UIImage imageNamed:@"btn_finishEnd.png"];
            [liveshowIV addSubview:finishView];
//        }
    }
    }
    
    UIView *detailV=nil;
    if (self.liveshowArr.count>0) {
    detailV=[[UIView alloc]initWithFrame:CGRectMake(0, 500*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-500*DEF_Adaptation_Font*0.5)];
    }else{
        detailV=[[UIView alloc]initWithFrame:CGRectMake(0, 380*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-350*DEF_Adaptation_Font*0.5)];
    }
    [self addSubview:detailV];
    noticeLB=[LooperToolClass createLableView:CGPointMake(40*DEF_Adaptation_Font*0.5,15*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(100*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"公告" andFontSize:14 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4] andType:NSTextAlignmentCenter];
    [detailV addSubview:noticeLB];
    noticeLB.font=[UIFont systemFontOfSize:12];
    noticeLB.tag=0;
    noticeLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [noticeLB addGestureRecognizer:singleTap1];
    
    logLB = [LooperToolClass createLableView:CGPointMake(220*DEF_Adaptation_Font*0.5,15*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(100*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"日志" andFontSize:14 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    logLB.font=[UIFont systemFontOfSize:12];
    [detailV addSubview:logLB];
    logLB.tag=1;
    logLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [logLB addGestureRecognizer:singleTap];
    applyListLB = [LooperToolClass createLableView:CGPointMake(75*DEF_Adaptation_Font*0.5+500*DEF_Adaptation_Font*0.5/2,15*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5/2,97*DEF_Adaptation_Font*0.5) andText:@"申请列表" andFontSize:14 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    applyListLB.font=[UIFont systemFontOfSize:12];
    [detailV addSubview:applyListLB];
    applyListLB.tag=2;
    applyListLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    applyListLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [applyListLB addGestureRecognizer:singleTap2];
    
    UIView *linesV=[[UIView alloc]initWithFrame:CGRectMake(0, 91*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 1)];
    linesV.backgroundColor=ColorRGB(200, 200, 200, 0.1);
    [detailV addSubview:linesV];
    lineView=[[UIView alloc]initWithFrame:CGRectMake(258*DEF_Adaptation_Font*0.5, 91*DEF_Adaptation_Font*0.5, (480/2-204)*DEF_Adaptation_Font*0.5, 2)];
    
    lineView.backgroundColor=[UIColor colorWithRed:182/255.0 green:169/255.0 blue:255/255.0 alpha:1.0];
    [detailV addSubview:lineView];
    scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 93*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(detailV)-93*DEF_Adaptation_Font*0.5)];
    scrollV.contentSize=CGSizeMake(DEF_WIDTH(self)*3.001, DEF_HEIGHT(self)-593*DEF_Adaptation_Font*0.5);
    scrollV.backgroundColor=[UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0];
    scrollV.pagingEnabled=YES;
    scrollV.bounces=NO;
    scrollV.delegate=self;
     scrollV.contentOffset=CGPointMake(DEF_WIDTH(self), 0);
    [detailV addSubview:scrollV];
    UILabel *noticeDetailLB=[[UILabel alloc]initWithFrame:CGRectMake(54*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 474*DEF_Adaptation_Font*0.5, 456*DEF_Adaptation_Font*0.5)];
    noticeDetailLB.textColor=[UIColor whiteColor];
    if ([self.dataDic objectForKey:@"raverbulletin"]==[NSNull null]) {
        noticeDetailLB.text=@"让我能在毕业前能够圆梦使劲的呐喊，随着音乐挥动着手中的荧光棒，身体跟随着音乐的节奏律动，伴随着DJ的手势发出尖叫，尽情享受电音盛宴，释放自我。";
    }else{
    noticeDetailLB.text=[self.dataDic objectForKey:@"raverbulletin"];
    }
    CGSize lblSize3 = [noticeDetailLB.text boundingRectWithSize:CGSizeMake(474*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*DEF_Adaptation_Font]} context:nil].size;
    CGRect frame3=noticeDetailLB.frame;
    frame3.size=lblSize3;
    noticeDetailLB.frame=frame3;
    noticeDetailLB.font=[UIFont systemFontOfSize:14*DEF_Adaptation_Font];
    noticeDetailLB.numberOfLines=0;
    [scrollV addSubview:noticeDetailLB];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
CGFloat xOffset=scrollView.contentOffset.x;
    CGFloat yOffset=scrollView.contentOffset.y;;
    xOffset=ceilf(xOffset);
 CGFloat  scollX=ceilf(DEF_WIDTH(self));
    NSLog(@"xoffset:%f,scroll: %f ,yoffset:%f",xOffset,scollX,yOffset);
    if (scrollView.tag==101) {
    //判断是否到底
        CGFloat width = scrollView.frame.size.width;
        CGFloat contentXoffset = scrollView.contentOffset.x;
        CGFloat distanceFromBottom = scrollView.contentSize.width - contentXoffset;
        if (distanceFromBottom < width) {
            NSLog(@"end of table");
    scrollView.contentOffset=CGPointMake(270*DEF_Adaptation_Font*0.5*self.liveshowArr.count+19*DEF_Adaptation_Font*0.5-DEF_WIDTH(self), 0);
        }
        
    }else{
    
    if (yOffset==0) {
    if (xOffset<=scollX+20*DEF_Adaptation_Font*0.5&&xOffset>=scollX-20*DEF_Adaptation_Font*0.5) {
        applyListLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        noticeLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        logLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        scrollV.contentOffset=CGPointMake(DEF_WIDTH(self), 0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=253*DEF_Adaptation_Font*0.5;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
    if (xOffset>0&&xOffset<20*DEF_Adaptation_Font*0.5){
        applyListLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        noticeLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        logLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        scrollV.contentOffset=CGPointMake(0, 0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=70*DEF_Adaptation_Font*0.5;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
    if (xOffset<=ceilf(DEF_WIDTH(self)*2)&&xOffset>=ceilf(DEF_WIDTH(self)*2)-20*DEF_Adaptation_Font*0.5) {
        applyListLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        noticeLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        logLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        scrollV.contentOffset=CGPointMake(DEF_WIDTH(self)*2,0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=182*DEF_Adaptation_Font*0.5+530*DEF_Adaptation_Font*0.5/2;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
        if (xOffset>ceilf(DEF_WIDTH(self)*2)+20*DEF_Adaptation_Font*0.5) {
            [[[self.obj familyView]sc]setContentOffset:CGPointMake(DEF_SCREEN_WIDTH , 0) animated:NO];
        }
    }
    }
}
-(void)onClickView:(UITapGestureRecognizer *)tap{
    if (tap.view.tag==0) {
        applyListLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        noticeLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        logLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        scrollV.contentOffset=CGPointMake(0, 0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=70*DEF_Adaptation_Font*0.5;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
    if (tap.view.tag==1) {
        applyListLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        noticeLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        logLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        scrollV.contentOffset=CGPointMake(DEF_WIDTH(self), 0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=253*DEF_Adaptation_Font*0.5;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
    if (tap.view.tag==2) {
        applyListLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        noticeLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        logLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        scrollV.contentOffset=CGPointMake(DEF_WIDTH(self)*2,0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=182*DEF_Adaptation_Font*0.5+530*DEF_Adaptation_Font*0.5/2;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
    if (tap.view.tag==5) {
//点击家族头像
        FamilyHeaderView *headerView=[[FamilyHeaderView alloc]initWithFrame:[UIScreen mainScreen].bounds andObj:self.obj andDataDic:self.dataDic];
        [[[self.obj obj]view] addSubview:headerView];
    }
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self),20*DEF_Adaptation_Font*0.5,DEF_WIDTH(self), DEF_HEIGHT(scrollV)-20*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
        [scrollV addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
//        _tableView.bounces=NO;
        _tableView.alwaysBounceVertical=YES;
    }
    return _tableView;
}
-(UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置每个item的大小，
        flowLayout.itemSize = CGSizeMake(DEF_WIDTH(self), 90*DEF_Adaptation_Font*0.5);
        //    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        // 设置列的最小间距
        flowLayout.minimumInteritemSpacing = 0;
        // 设置最小行间距
        flowLayout.minimumLineSpacing = 0;
        // 设置布局的内边距
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0,0);
        // 滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)*2,0,DEF_WIDTH(self), DEF_HEIGHT(scrollV)) collectionViewLayout:flowLayout];
        _collectView.backgroundColor = [UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0];
        // 设置代理
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [scrollV addSubview:_collectView];
    }
    return _collectView;
}
#pragma -UICollectionView
// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.applyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    // 取出每个item所需要的数据
    NSDictionary *dataDic = [self.applyArr objectAtIndex:indexPath.item];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(33*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, 390*DEF_Adaptation_Font*0.5, 70*DEF_Adaptation_Font*0.5)];
    contentLB.textColor=[UIColor whiteColor];
    NSString *name=[dataDic objectForKey:@"nickname"];
    NSString *applyName=@"暴走大垃圾";
#warning -在这里加入是别人邀请还是自己申请
    if (1) {
        contentLB.text=[NSString stringWithFormat:@"%@申请加入家族",name];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:contentLB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        contentLB.attributedText= aString;
    }else{
    contentLB.text=[NSString stringWithFormat:@"%@邀请%@加入家族",name,applyName];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:contentLB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(2+name.length, applyName.length)];
        contentLB.attributedText= aString;
    }
    contentLB.font=[UIFont systemFontOfSize:14];
    contentLB.numberOfLines=0;
    [cell.contentView addSubview:contentLB];

    NSString *status=[dataDic objectForKey:@"reviewstatus"];
    if ([status intValue]==1) {
        UIButton *sureButton=[LooperToolClass createBtnImageNameReal:@"agreeBtn.png" andRect:CGPointMake(430*DEF_Adaptation_Font*0.5, 23*DEF_Adaptation_Font*0.5) andTag:(int)indexPath.row+1 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(41*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
        [cell.contentView addSubview:sureButton];
        UIButton *refuseButton=[LooperToolClass createBtnImageNameReal:@"refuseBtn.png" andRect:CGPointMake(510*DEF_Adaptation_Font*0.5, 23*DEF_Adaptation_Font*0.5) andTag:(int)-(indexPath.row+1) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(41*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5) andTarget:self];
        [cell.contentView addSubview:refuseButton];
    }else{
        UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(466*DEF_Adaptation_Font*0.5, 23*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-466*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
        personNumLB.text=@"已拒绝";
        personNumLB.numberOfLines=0;
        personNumLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
        personNumLB.textColor=[UIColor lightGrayColor];
        personNumLB.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:personNumLB];
    }

    
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:86/255.0 green:77/255.0 blue:109/255.0 alpha:1.0];
    }else{
        cell.contentView.backgroundColor=[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0];
        
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.applyArr objectAtIndex:indexPath.item];
    
}
#pragma-UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 7;
    return self.logArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    }    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *dataDic=[[NSDictionary alloc]initWithDictionary:self.logArr[indexPath.row]];
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(24*DEF_Adaptation_Font*0.5, 8*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5)];
    timeLB.text=[dataDic objectForKey:@"creationdate"];
    timeLB.numberOfLines=0;
    timeLB.textColor=ColorRGB(255, 255, 255, 0.76);
    timeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    CGSize lblSize2 = [timeLB.text boundingRectWithSize:CGSizeMake(120*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame2=timeLB.frame;
    frame2.size=lblSize2;
    timeLB.frame=frame2;
    [cell.contentView addSubview:timeLB];
    UILabel *subLB=[[UILabel alloc]initWithFrame:CGRectMake(160*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-180*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    subLB.textColor=ColorRGB(255, 255, 255, 1.0);
//    [self modificationColorWithLabel:subLB andStatus:indexPath.row andDataDic:nil];
    [self modificationColorWithLabel:subLB andType:[[dataDic objectForKey:@"messagetype"]intValue] andDataDic:self.logArr[indexPath.row]];
    CGSize lblSize3 = [subLB.text boundingRectWithSize:CGSizeMake(DEF_WIDTH(self)-180*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGRect frame3=subLB.frame;
    frame3.size=lblSize3;
    subLB.frame=frame3;
    subLB.numberOfLines=0;
    subLB.font=[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:subLB];
    cell.contentView.backgroundColor=[UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0];
    
    return cell;
    
}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110*DEF_Adaptation_Font*0.5;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic=self.logArr[indexPath.row];
}
-(void)modificationColorWithLabel:(UILabel *)LB andType:(NSInteger)type andDataDic:(NSDictionary *)dataDic{
    NSString *name=[dataDic objectForKey:@"username"];
    NSString *targetName=[dataDic objectForKey:@"targetname"];
    NSString *message=[dataDic objectForKey:@"messagecontent"];
    if (type==1) {
        LB.text=[NSString stringWithFormat:@"%@ %@",name,message];
        LB.textColor=ColorRGB(219, 23, 115, 1.0);
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        LB.attributedText= aString;
    }else if (type==2){
        LB.text=[NSString stringWithFormat:@"%@ %@",name,message];
        LB.textColor=ColorRGB(219, 23, 115, 1.0);
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        LB.attributedText= aString;
    }else if (type==3){
        LB.text=[NSString stringWithFormat:@"%@ %@",name,message];
        LB.textColor=ColorRGB(219, 23, 115, 1.0);
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        LB.attributedText= aString;
    }else if (type==4){
        LB.text=[NSString stringWithFormat:@"%@ %@",name,message];
        LB.textColor=ColorRGB(219, 23, 115, 1.0);
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        LB.attributedText= aString;
    }else if (type==5){
        LB.text=[NSString stringWithFormat:@"%@ %@",name,message];
        LB.textColor=ColorRGB(219, 23, 115, 1.0);
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        LB.attributedText= aString;
    }


}

-(void)modificationColorWithLabel:(UILabel *)LB andStatus:(NSInteger)Status andDataDic:(NSDictionary *)dataDic{
    NSString *name=@"XXX";
    NSString *club=@"叨逼叨/liveshow";
    NSString *activity=@"发表评论/点赞";
    NSString *experience=@"XX经验值";
    NSString *active=@"XX活跃度";
    NSString *day=@"5";
    NSString *family=@"XX家族";
    NSString *group=@"第一小组";
    NSString *job=@"二副/职务";
    NSString *member=@"成员名字";
    NSString *memberJob=@"成员职务";
    NSString *anotherJob=@"另一成员职务";
    NSInteger status=Status;
    if (status==0) {
            LB.text=[NSString stringWithFormat:@"%@在%@中%@得%@和%@",name,club,activity,experience,active];
            NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
            [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
            [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(1+name.length, club.length)];
            [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(3+activity.length+name.length+club.length, experience.length)];
            [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(4+activity.length+name.length+club.length+experience.length, active.length)];
            LB.attributedText= aString;
    }else if (status==1){
        LB.text=[NSString stringWithFormat:@"%@完成%@得%@和%@",name,activity,experience,active];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(2+name.length, activity.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(3+activity.length+name.length, experience.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(4+activity.length+name.length+experience.length, active.length)];
        LB.attributedText= aString;
    }else if (status==2){
        LB.text=[NSString stringWithFormat:@"%@连续%@天未增加经验值扣除%@ ",name,day,active];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(2+name.length, day.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(11+name.length+day.length, active.length)];
        LB.attributedText= aString;
    }else if (status==3){
        LB.text=[NSString stringWithFormat:@"%@完成%@,家族获得%@",family,activity,active];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, family.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(2+family.length, activity.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(7+activity.length+family.length, active.length)];
        LB.attributedText= aString;
    }else if (status==4){
        LB.text=[NSString stringWithFormat:@"%@在%@满员打卡，家族获得%@",group,club,active];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, group.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(1+group.length, club.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(10+group.length+club.length, active.length)];
        LB.attributedText= aString;
    }else if (status==5){
        LB.text=[NSString stringWithFormat:@"%@(%@)，从%@ 移出%@(%@)，家族扣除%@和%@",name,job,family,member,memberJob,experience,active];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(1+name.length, job.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(4+name.length+job.length, family.length)];
         [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(7+name.length+job.length+family.length, member.length)];
         [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(8+name.length+job.length+family.length+member.length, memberJob.length)];
         [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(14+name.length+job.length+family.length+member.length+memberJob.length, experience.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(15+name.length+job.length+family.length+member.length+memberJob.length+experience.length, active.length)];
        LB.attributedText= aString;
    }else if (status==6){
        LB.text=[NSString stringWithFormat:@"%@(%@)，把%@(%@)变更 为%@(%@)",name,job,member,memberJob,member,anotherJob];
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:LB.text];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(0, name.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(1+name.length, job.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(4+name.length+job.length, member.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(5+name.length+job.length+member.length, memberJob.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(10+name.length+job.length+member.length+memberJob.length, member.length)];
        [aString addAttribute:NSForegroundColorAttributeName value:ColorRGB(95, 242, 255, 1.0)range:NSMakeRange(11+name.length+job.length+member.length+memberJob.length+member.length, anotherJob.length)];
        LB.attributedText= aString;
    }

    
    
}

@end
