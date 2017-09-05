//
//  FamilyMemberView.m
//  Looper
//
//  Created by 工作 on 2017/9/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyMemberView.h"
#import "FamilyViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
@interface FamilyMemberView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@end
@implementation FamilyMemberView

-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSArray *)dataArr{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataArr=dataArr;
        [self initView];
        [self setBackView];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    }
    return self;
}
-(void)initView{
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), 68*DEF_Adaptation_Font*0.5)];
    headerView.image=[UIImage imageNamed:@"family_header_BG"];
    [self addSubview:headerView];
    headerView.userInteractionEnabled=YES;
    UIButton *inviteBtn=[LooperToolClass createBtnImageNameReal:@"familyMember_invite" andRect:CGPointMake(DEF_WIDTH(self)-72*DEF_Adaptation_Font*0.5, 6*DEF_Adaptation_Font*0.5) andTag:99 andSelectImage:@"familyMember_invite" andClickImage:@"familyMember_invite" andTextStr:nil andSize:CGSizeMake(60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    [headerView addSubview:inviteBtn];
    UILabel *headerLB=[[UILabel alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 0, DEF_WIDTH(self)-180*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerLB.textAlignment=NSTextAlignmentCenter;
    headerLB.text=@"Welphen";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [headerView addSubview:headerLB];
    
    UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 68*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 62*DEF_Adaptation_Font*0.5)];
    contentView.backgroundColor=ColorRGB(84, 71, 104, 1.0);
    [self addSubview:contentView];
    UILabel *jobName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 290*DEF_Adaptation_Font*0.5, 62*DEF_Adaptation_Font*0.5)];
    jobName.text=@"职称/名称";
    jobName.textColor=ColorRGB(225, 255, 255, 0.7);
    jobName.textAlignment=NSTextAlignmentCenter;
    jobName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    jobName.userInteractionEnabled=YES;
    [contentView addSubview:jobName];
    UILabel *levelLB=[[UILabel alloc]initWithFrame:CGRectMake(290*DEF_Adaptation_Font*0.5, 0, 80*DEF_Adaptation_Font*0.5, 62*DEF_Adaptation_Font*0.5)];
    levelLB.text=@"等级";
    levelLB.textColor=ColorRGB(225, 255, 255, 0.7);
    levelLB.textAlignment=NSTextAlignmentCenter;
    levelLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    levelLB.userInteractionEnabled=YES;
    [contentView addSubview:levelLB];
    UILabel *activeLB=[[UILabel alloc]initWithFrame:CGRectMake(370*DEF_Adaptation_Font*0.5, 0, 120*DEF_Adaptation_Font*0.5, 62*DEF_Adaptation_Font*0.5)];
    activeLB.text=@"活跃度";
    activeLB.textColor=ColorRGB(225, 255, 255, 0.7);
    activeLB.textAlignment=NSTextAlignmentCenter;
    activeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    activeLB.userInteractionEnabled=YES;
    [contentView addSubview:activeLB];
    UILabel *sexLB=[[UILabel alloc]initWithFrame:CGRectMake(480*DEF_Adaptation_Font*0.5, 0, 100*DEF_Adaptation_Font*0.5, 62*DEF_Adaptation_Font*0.5)];
    sexLB.text=@"性别";
    sexLB.textColor=ColorRGB(225, 255, 255, 0.7);
    sexLB.textAlignment=NSTextAlignmentCenter;
    sexLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    sexLB.userInteractionEnabled=YES;
    [contentView addSubview:sexLB];

}
-(void)setBackView{
    [self setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
    self.layer.cornerRadius=12.0*DEF_Adaptation_Font;
    self.layer.masksToBounds=YES;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
    if (tag==99) {
//邀请button
        
    }
    if (tag==100) {
        //保存到手机
    }if(tag==101){
        //分享二维码
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,130*DEF_Adaptation_Font*0.5,DEF_WIDTH(self),DEF_HEIGHT(self)-130*DEF_Adaptation_Font*0.5)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=YES;
        _tableView.bounces=NO;
        
        [self addSubview:_tableView];
    }
    return _tableView;
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
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    headIV.image=[UIImage imageNamed:@"640-2.png"];
    headIV.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    headIV.layer.masksToBounds=YES;
    [cell.contentView addSubview:headIV];
    UILabel *headLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5)];
    headLB.textColor=[UIColor whiteColor];
    headLB.font=[UIFont systemFontOfSize:14];
    headLB.text=@"阿波罗一号";
    [cell.contentView addSubview:headLB];
    UILabel *jobLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 51*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    jobLB.textColor=[UIColor whiteColor];
    jobLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    jobLB.text=@"舰长";
    [cell.contentView addSubview:jobLB];
    jobLB.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
    jobLB.layer.masksToBounds=YES;
    jobLB.backgroundColor=[UIColor blueColor];
    jobLB.textAlignment=NSTextAlignmentCenter;
    CGSize lblSize3 = [jobLB.text boundingRectWithSize:CGSizeMake(190*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:12.f]} context:nil].size;
    CGRect frame3=jobLB.frame;
    lblSize3.width+=32*DEF_Adaptation_Font*0.5;
    frame3.size=lblSize3;
    jobLB.frame=frame3;
    
    UILabel *levelLB=[[UILabel alloc]initWithFrame:CGRectMake(290*DEF_Adaptation_Font*0.5, 0, 80*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5)];
    levelLB.textColor=[UIColor whiteColor];
    levelLB.font=[UIFont systemFontOfSize:14];
    levelLB.text=@"99";
    levelLB.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:levelLB];
    UILabel *activeLB=[[UILabel alloc]initWithFrame:CGRectMake(370*DEF_Adaptation_Font*0.5, 0, 120*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5)];
    activeLB.textColor=[UIColor whiteColor];
    activeLB.font=[UIFont systemFontOfSize:14];
    activeLB.text=@"10000";
     activeLB.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:activeLB];

//    UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(510*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
//    sexIV.image=[UIImage imageNamed:@"familyMember_person.png"];
//    UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(520*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
//    sexIV.image=[UIImage imageNamed:@"family_woman.png"];
    UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(520*DEF_Adaptation_Font*0.5, 33*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
    sexIV.image=[UIImage imageNamed:@"family_man.png"];
    [cell.contentView addSubview:sexIV];
    
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0];
    }else{
        cell.contentView.backgroundColor=ColorRGB(84, 71, 104, 1.0);
        
    }
    cell.layer.masksToBounds=YES;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  92*DEF_Adaptation_Font*0.5;
}

@end
