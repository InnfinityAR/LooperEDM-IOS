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
        self.obj=(UIView *)obj;
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,75*DEF_Adaptation_Font*0.5,DEF_WIDTH(self),DEF_HEIGHT(self)-90*DEF_Adaptation_Font*0.5)];
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
    }
    return _tableView;
}

-(void)initView{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 10*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 62*DEF_Adaptation_Font*0.5)];
    [self addSubview:headView];
    UILabel *familyLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 292*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    familyLB.text=@"家族";
    familyLB.textColor=[UIColor whiteColor];
    familyLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    familyLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:familyLB];
    UILabel *rankLB=[[UILabel alloc]initWithFrame:CGRectMake(292*DEF_Adaptation_Font*0.5, 0, 58*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    rankLB.text=@"等级";
    rankLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    rankLB.textColor=[UIColor whiteColor];
     rankLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:rankLB];
    UILabel *livenessLB=[[UILabel alloc]initWithFrame:CGRectMake(350*DEF_Adaptation_Font*0.5, 0, 116*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    livenessLB.text=@"家族活跃度";
    if (familyType==0) {
         livenessLB.text=@"位置";
    }
    livenessLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    livenessLB.textColor=[UIColor whiteColor];
     livenessLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:livenessLB];
    UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(466*DEF_Adaptation_Font*0.5, 0, DEF_WIDTH(self)-466*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    personNumLB.text=@"人数\n(500人)";
    personNumLB.numberOfLines=0;
    personNumLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    personNumLB.textColor=[UIColor whiteColor];
     personNumLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:personNumLB];

    
}
-(void)setBackView{
    [self setBackgroundColor:[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0]];
    self.layer.cornerRadius=12.0*DEF_Adaptation_Font;
    self.layer.masksToBounds=YES;
}

#pragma -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    UIImageView *topIV=nil;
    if (familyType==1) {
    if (indexPath.row==0||indexPath.row==1||indexPath.row==2) {
        topIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40*DEF_Adaptation_Font, 40*DEF_Adaptation_Font)];
    }else{
        topIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20*DEF_Adaptation_Font, 20*DEF_Adaptation_Font)];
    }
    }
    topIV.image=[UIImage imageNamed:[NSString stringWithFormat:@"top%ld.png",indexPath.row+1]];
    [cell.contentView addSubview:topIV];
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(11*DEF_Adaptation_Font, 17*DEF_Adaptation_Font, 28*DEF_Adaptation_Font, 28*DEF_Adaptation_Font)];
    headIV.image=[UIImage imageNamed:@"640-2.png"];
    headIV.layer.cornerRadius=14*DEF_Adaptation_Font;
    headIV.layer.masksToBounds=YES;
    [cell.contentView addSubview:headIV];
    UILabel *headLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font, 190*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font)];
    headLB.numberOfLines=0;
    headLB.font=[UIFont systemFontOfSize:14];
    headLB.textColor=[UIColor whiteColor];
    if (indexPath.row==1) {
        headLB.text=@"Welphon------------WCNMLGB";
    }else{
        headLB.text=@"LooperEDM";
    }
    [cell.contentView addSubview:headLB];
    
    UILabel *rankLB=[[UILabel alloc]initWithFrame:CGRectMake(292*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font, 58*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    rankLB.font=[UIFont systemFontOfSize:14];
    rankLB.textColor=[UIColor whiteColor];
    rankLB.textAlignment=NSTextAlignmentCenter;
    rankLB.text=@"II";
    [cell.contentView addSubview:rankLB];
    
    UILabel *livenessLB=[[UILabel alloc]initWithFrame:CGRectMake(350*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font, 116*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    livenessLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    livenessLB.textColor=[UIColor whiteColor];
    livenessLB.textAlignment=NSTextAlignmentCenter;
    if (familyType==1) {
    livenessLB.text=@"6660000";
    }else{
     livenessLB.text=@"上海-黄埔";
    }
    [cell.contentView addSubview:livenessLB];
    
    UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(466*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font, DEF_WIDTH(self)-466*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    personNumLB.text=@"499";
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
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  62*DEF_Adaptation_Font;
}

@end
