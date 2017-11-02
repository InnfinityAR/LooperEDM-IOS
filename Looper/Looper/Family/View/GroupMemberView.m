//
//  GroupMemberView.m
//  Looper
//
//  Created by 工作 on 2017/11/2.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "GroupMemberView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
@interface GroupMemberView()<UITableViewDelegate ,UITableViewDataSource>
{
    UIView *bkV;
    NSInteger isSortJob;//sortBtn
    NSInteger isSortActive;//sortBtn
    NSInteger isSortSex;//sortBtn
}
@property(nonatomic,strong)UITableView *tableView;
@end
@implementation GroupMemberView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSMutableArray *)dataArr{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataSource=dataArr;
        [self initView];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return self;
}
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    isSortJob=0;
    isSortActive=0;
    isSortSex=0;
    [self createHudView];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag==5000){
        [self removeFromSuperview];
    }
    if(button.tag==5001){
        if (isSortJob==0) {
            isSortJob=1;
            [self sortReverseArr];
            [self.tableView reloadData];
        }else{
            isSortJob=0;
            [self sortReverseArr];
            [self.tableView reloadData];
        }
    }
}
-(void)createHudView{
    bkV =[[UIView alloc] initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5, 978*DEF_Adaptation_Font*0.5)];
    [bkV setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
    [self addSubview:bkV];
    bkV.layer.cornerRadius=12.0*DEF_Adaptation_Font*0.5;
    bkV.layer.masksToBounds=YES;
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 585*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerView.image=[UIImage imageNamed:@"family_header_BG"];
    [bkV addSubview:headerView];
    
    UILabel *headerLB=[[UILabel alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 0, bkV.frame.size.width-180*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerLB.textAlignment=NSTextAlignmentCenter;
    headerLB.text=@"成员管理";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10*DEF_Adaptation_Font*0.5) andTag:5000 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    UILabel *presentMemberLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 68*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 60*DEF_Adaptation_Font*0.5)];
    presentMemberLB.backgroundColor=ColorRGB(84, 71, 104, 1.0);
    presentMemberLB.textAlignment=NSTextAlignmentCenter;
    presentMemberLB.textColor=ColorRGB(255, 255, 255, 0.7);
    presentMemberLB.text=@"现有成员";
    presentMemberLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [bkV addSubview:presentMemberLB];
    
    [self createBtnLabel:CGRectMake(103*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:101 andStr:@"名称"];
    UIButton *sortBtn=[LooperToolClass createBtnImageNameReal:@"familyMember_sort.png" andRect:CGPointMake(210*DEF_Adaptation_Font*0.5, 155*DEF_Adaptation_Font*0.5) andTag:5001 andSelectImage:@"familyMember_sort.png" andClickImage:@"familyMember_sort.png" andTextStr:nil andSize:CGSizeMake(15*DEF_Adaptation_Font*0.5, 15*DEF_Adaptation_Font*0.5) andTarget:self];
    [bkV addSubview:sortBtn];
    [self createBtnLabel:CGRectMake(303*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:100 andStr:@"活跃值"];
   [self createBtnLabel:CGRectMake(445*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:102 andStr:@"性别"];
}
-(UILabel *)createBtnLabel:(CGRect)rect and:(int)tag andStr:(NSString*)string{
    
    UILabel *btnName=[[UILabel alloc]initWithFrame:rect];
    btnName.text=string;
    btnName.userInteractionEnabled=YES;
    btnName.tag=tag;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBtn:)];
    [btnName addGestureRecognizer:singleTap];
    [self addSubview:btnName];
    btnName.textColor=[UIColor whiteColor];
    btnName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    btnName.textAlignment=NSTextAlignmentCenter;
    [bkV addSubview:btnName];
    return btnName;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,182*DEF_Adaptation_Font*0.5,DEF_WIDTH(self),DEF_HEIGHT(bkV)-182*DEF_Adaptation_Font*0.5)];
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
        
        [bkV addSubview:_tableView];
    }
    return _tableView;
}
#pragma -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
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
        NSDictionary *dataDic=_dataSource[indexPath.row];
        [self setTableViewCellView:cell andIndexPath:indexPath andBtnName:@"移除"andDataDic:dataDic];
    cell.contentView.backgroundColor=[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0];
    return cell;
}
-(void)setTableViewCellView:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath andBtnName:(NSString *)btnName andDataDic:(NSDictionary *)dataDic{
    UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    [headImage sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"headimageurl"]]];
    headImage.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    headImage.layer.masksToBounds=YES;
    [cell.contentView addSubview:headImage];
    
    UILabel *nickName=[[UILabel alloc]initWithFrame:CGRectMake(126*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5)];
    nickName.textColor=[UIColor whiteColor];
    nickName.font=[UIFont systemFontOfSize:14];
    nickName.text=[dataDic objectForKey:@"nickname"];
    [cell.contentView addSubview:nickName];
    
    UILabel *activeLB=[[UILabel alloc]initWithFrame:CGRectMake(303*DEF_Adaptation_Font*0.5, 0, 93*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5)];
    activeLB.textColor=[UIColor whiteColor];
    activeLB.font=[UIFont systemFontOfSize:14];
    
    if ([dataDic objectForKey:@"activepoints"]==[NSNull null]) {
        activeLB.text=@"0";
    }else{
        activeLB.text=[dataDic objectForKey:@"activepoints"];
    }
    activeLB.textAlignment=NSTextAlignmentCenter;
    if ([btnName isEqualToString:@"移除"]) {
        [cell.contentView addSubview:activeLB];
    }
    CGFloat imageViewWidth=425*DEF_Adaptation_Font*0.5;
    if ([dataDic objectForKey:@"role"]==0) {
        //只有水手长或水手长以上级别的人 才能调用获取散人接口 散人里只可能有水手
         NSInteger   BtnTag=indexPath.row;
        UIButton *inviteBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(475*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andTag:(int)BtnTag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5) andTarget:self];
        [inviteBtn setTitle:btnName forState:(UIControlStateNormal)];
        inviteBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [inviteBtn setTintColor:[UIColor whiteColor]];
        inviteBtn.layer.borderWidth=0.5;
        inviteBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
        inviteBtn.layer.cornerRadius=18*DEF_Adaptation_Font*0.5;
        inviteBtn.layer.masksToBounds=YES;
//        [cell.contentView addSubview:inviteBtn];
    }else{
        imageViewWidth=475*DEF_Adaptation_Font*0.5;
    }
    
    if([dataDic objectForKey:@"sex"]==[NSNull null]){
        UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewWidth, 33*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"family_man.png"];
        [cell.contentView addSubview:sexIV];
    }else if ([[dataDic objectForKey:@"sex"]intValue]==1) {
        UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewWidth, 33*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"family_man.png"];
        [cell.contentView addSubview:sexIV];
    }else if([[dataDic objectForKey:@"sex"]intValue]==0){
        UIImageView * sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewWidth, 35*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"familyMember_person.png"];
        [cell.contentView addSubview:sexIV];
    }else if([[dataDic objectForKey:@"sex"]intValue]==2){
        UIImageView * sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewWidth, 28*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"family_Woman.png"];
        [cell.contentView addSubview:sexIV];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  92*DEF_Adaptation_Font*0.5;
}



-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(void)onClickBtn:(UITapGestureRecognizer*)tap{
    
    
    if (tap.view.tag==101) {
        if (isSortJob==0) {
            isSortJob=1;
            [self sortReverseArr];
            [self.tableView reloadData];
        }else{
            isSortJob=0;
            [self sortReverseArr];
            [self.tableView reloadData];
        }
    }
    
    if (tap.view.tag==100) {
        if (isSortActive==1) {
            isSortActive=0;
            [self sortFromLargelToSmall:@"activepoints"];
            [self.tableView reloadData];
        }else{
            isSortActive=1;
            [self sortFromSmallToLarge:@"activepoints"];
            [self.tableView reloadData];
        }
    }
    if (tap.view.tag==102) {
        if (isSortSex==0) {
            isSortSex=1;
            [self sortFromLargelToSmall:@"sex"];
            [self.tableView reloadData];
        }else{
            isSortSex=0;
            [self sortFromSmallToLarge:@"sex"];
            [self.tableView reloadData];
        }
    }
}
-(void)sortReverseArr{
    if (_dataSource.count>1) {
        for (int i=0; i<_dataSource.count/2; i++) {
            NSDictionary *dic=_dataSource[i];
            _dataSource[i]=_dataSource[_dataSource.count-i-1];
            _dataSource[_dataSource.count-i-1]=dic;
        }
    }
    
}
-(void)sortFromSmallToLarge:(NSString *)type{
    if (_dataSource.count>1) {
        for (int i=0; i<_dataSource.count; i++) {
            for (int j=0; j<i; j++) {
                if ([_dataSource[i]objectForKey:type]==nil||[_dataSource[i]objectForKey:type]==[NSNull null]) {
                }else{
                    if ([[_dataSource[i]objectForKey:type]integerValue]<[[_dataSource[j]objectForKey:type]integerValue]) {
                        NSDictionary *dic=_dataSource[i];
                        _dataSource[i]=_dataSource[j];
                        _dataSource[j]=dic;
                    }
                }
            }
        }
    }
}
-(void)sortFromLargelToSmall:(NSString *)type{
    if (_dataSource.count>1) {
        for (int i=0; i<_dataSource.count; i++) {
            for (int j=0; j<i; j++) {
                if ([_dataSource[i]objectForKey:type]==nil||[_dataSource[i]objectForKey:type]==[NSNull null]) {
                }else{
                    if ([[_dataSource[i]objectForKey:type]integerValue]>[[_dataSource[j]objectForKey:type]integerValue]) {
                        NSDictionary *dic=_dataSource[i];
                        _dataSource[i]=_dataSource[j];
                        _dataSource[j]=dic;
                    }
                }
            }
        }
    }
}
@end
