//
//  FamilyRankView.m
//  Looper
//
//  Created by 工作 on 2017/8/24.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyRankView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "FamilyViewModel.h"
#import "UIImageView+WebCache.h"
#import "FamilyDetailView.h"
#import"FamilyApplyView.h"
#import "LocalDataMangaer.h"
@interface FamilyRankView()<UITableViewDelegate,UITableViewDataSource>
{
//type用来传入是家族排行还是家族列表,1为排行，0为列表,默认为1
    int familyType;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@end
@implementation FamilyRankView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataArr:(NSArray *)dataArr andType:(int)type{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        [self.obj setRankView:self];
        self.dataArr=dataArr;
        familyType=1;
        familyType=type;
        [self initView];
        [self setBackView];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,75*DEF_Adaptation_Font*0.5,DEF_WIDTH(self),DEF_HEIGHT(self)-75*DEF_Adaptation_Font*0.5)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
       [_tableView setBackgroundColor:[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=YES;
        _tableView.bounces=NO;
        
        [self addSubview:_tableView];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tap1.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:tap1];
    }
    return _tableView;
}
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    if ([self.obj searchView]!=nil) {
   [ [self.obj searchView] endEditing:YES];
    }
}
-(void)initView{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), 75*DEF_Adaptation_Font*0.5)];
    [self addSubview:headView];
    UILabel *familyLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 292*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    familyLB.text=@"家族";
    familyLB.userInteractionEnabled=YES;
    familyLB.tag=1;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
    [familyLB addGestureRecognizer:singleTap];
    [self addSubview:familyLB];
    familyLB.textColor=[UIColor whiteColor];
    familyLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    familyLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:familyLB];
    UILabel *rankLB=[[UILabel alloc]initWithFrame:CGRectMake(292*DEF_Adaptation_Font*0.5, 0, 58*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    rankLB.text=@"等级";
    rankLB.userInteractionEnabled=YES;
    rankLB.tag=2;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
    [rankLB addGestureRecognizer:singleTap1];
    [self addSubview:rankLB];
    rankLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    rankLB.textColor=[UIColor whiteColor];
     rankLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:rankLB];
    UILabel *livenessLB=[[UILabel alloc]initWithFrame:CGRectMake(350*DEF_Adaptation_Font*0.5, 0, 116*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    livenessLB.text=@"家族活跃度";
    livenessLB.numberOfLines=0;
    livenessLB.textAlignment=NSTextAlignmentCenter;
    livenessLB.userInteractionEnabled=YES;
    livenessLB.tag=3;
    if (familyType==0) {
        livenessLB.text=@"位置";
        livenessLB.tag=5;
    }
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
    [livenessLB addGestureRecognizer:singleTap2];
    [self addSubview:livenessLB];
    livenessLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    livenessLB.textColor=[UIColor whiteColor];
     livenessLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:livenessLB];
    UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(466*DEF_Adaptation_Font*0.5, 0, DEF_WIDTH(self)-466*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    personNumLB.text=@"人数\n(500人)";
    personNumLB.userInteractionEnabled=YES;
    personNumLB.tag=4;
    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
    [personNumLB addGestureRecognizer:singleTap3];
    [self addSubview:personNumLB];
    personNumLB.numberOfLines=0;
    personNumLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    personNumLB.textColor=[UIColor whiteColor];
     personNumLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:personNumLB];
}
-(void)reloadData:(NSArray *)dataArr{
    self.dataArr=dataArr;
    [self.tableView reloadData];
}
-(void)onClickActivityLB:(UITapGestureRecognizer *)tap{
    if (familyType==1) {
    if (tap.view.tag==1) {
        NSLog(@"家族");
        [self.obj getFamilyRankDataForOrderType:@"1"];
    }
    if (tap.view.tag==2) {
        NSLog(@"等级");
        [self.obj getFamilyRankDataForOrderType:@"2"];
    }
    if (tap.view.tag==3) {
        NSLog(@"活跃度");
        [self.obj getFamilyRankDataForOrderType:@"3"];
    }
    if (tap.view.tag==4) {
        NSLog(@"人数");
        [self.obj getFamilyRankDataForOrderType:@"4"];
    }
    }
}
-(void)setBackView{
    [self setBackgroundColor:[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0]];
//    self.layer.cornerRadius=12.0*DEF_Adaptation_Font;
//    self.layer.masksToBounds=YES;
}

#pragma -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
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
    [self setTableViewCellView:cell andIndexPath:indexPath];
        return cell;
}
-(void)setTableViewCellView:(UITableViewCell *)cell andIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *dataDic=self.dataArr[indexPath.row];
    UIImageView *topIV=nil;
    if (familyType==1) {
    if (indexPath.row==0||indexPath.row==1||indexPath.row==2) {
        topIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40*DEF_Adaptation_Font, 40*DEF_Adaptation_Font)];
    }else{
        topIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20*DEF_Adaptation_Font, 20*DEF_Adaptation_Font)];
    }
    }
    topIV.image=[UIImage imageNamed:[NSString stringWithFormat:@"familyRank_top%ld.png",indexPath.row+1]];
    [cell.contentView addSubview:topIV];
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(11*DEF_Adaptation_Font, 17*DEF_Adaptation_Font, 28*DEF_Adaptation_Font, 28*DEF_Adaptation_Font)];
    [headIV sd_setImageWithURL:[NSURL URLWithString:dataDic[@"images"]] placeholderImage:[UIImage imageNamed:@"btn_home.png"]options:SDWebImageRetryFailed];
    headIV.layer.cornerRadius=14*DEF_Adaptation_Font;
    headIV.layer.masksToBounds=YES;
    [cell.contentView addSubview:headIV];
    UILabel *headLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font, 190*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font)];
    headLB.numberOfLines=0;
    headLB.font=[UIFont systemFontOfSize:14];
    headLB.textColor=[UIColor whiteColor];
        headLB.text=dataDic[@"ravername"];
    [cell.contentView addSubview:headLB];
    
    UILabel *rankLB=[[UILabel alloc]initWithFrame:CGRectMake(292*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font, 58*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    rankLB.font=[UIFont systemFontOfSize:14];
    rankLB.textColor=[UIColor whiteColor];
    rankLB.textAlignment=NSTextAlignmentCenter;
    if ([dataDic objectForKey:@"raverlevel"]==[NSNull null]) {
    rankLB.text=@"I";
    }else{
    rankLB.text=[dataDic objectForKey:@"raverlevel"];
    }
    [cell.contentView addSubview:rankLB];
    
    UILabel *livenessLB=[[UILabel alloc]initWithFrame:CGRectMake(350*DEF_Adaptation_Font*0.5, 13*DEF_Adaptation_Font, 116*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font)];
    livenessLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    livenessLB.numberOfLines=0;
    livenessLB.textColor=[UIColor whiteColor];
    livenessLB.textAlignment=NSTextAlignmentCenter;
    if (familyType==1) {
        if ([dataDic objectForKey:@"raveractive"]==[NSNull null]) {
            livenessLB.text=@"0";
        }else{
            livenessLB.text=[dataDic objectForKey:@"raveractive"];
        }
    }else{
//        livenessLB.text=@"上海/黄浦";
     livenessLB.text=[dataDic objectForKey:@"raveraddress"];
    }
    [cell.contentView addSubview:livenessLB];
    
    UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(468*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font, DEF_WIDTH(self)-468*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    personNumLB.text=[dataDic objectForKey:@"membercount"];
    personNumLB.numberOfLines=0;
    personNumLB.font=[UIFont systemFontOfSize:14];
    personNumLB.textColor=[UIColor whiteColor];
    personNumLB.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:personNumLB];
    
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:86/255.0 green:77/255.0 blue:109/255.0 alpha:1.0];
    }else{
        cell.contentView.backgroundColor=[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0];
        
    }
    cell.layer.masksToBounds=YES;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  NSDictionary *dataDic=self.dataArr[indexPath.row];
    if (familyType==1) {
    if ([self.obj familyModel].familyDetailData==nil||[[self.obj familyModel].familyDetailData isEqual:[NSNull null]]) {
    [self.obj getFamilyApplyDataWithDataDic:dataDic];
    }else{
        
    }
    }else{
        [self.obj getFamilyApplyDataWithDataDic:dataDic];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  62*DEF_Adaptation_Font;
}

@end
