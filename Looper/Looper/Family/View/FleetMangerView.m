//
//  FleetMangerView.m
//  Looper
//
//  Created by lujiawei on 13/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FleetMangerView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
@interface FleetMangerView()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *bkV;
     NSInteger isSortJob;//sortBtn
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end
@implementation FleetMangerView


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDataArr:(NSMutableArray *)dataArr{
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        self.dataSource=dataArr;
        [self initView];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return self;
    
}
-(void)ReloadTableViewWithDataArr:(NSMutableArray *)dataArr{
    self.dataSource=dataArr;
    [self.tableView reloadData];
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag==5000){
    
        [self removeFromSuperview];
    }else if(button.tag==5001){
        [_obj createFleetViewName];
        
    }else if (button.tag>=0&&button.tag<=50){
//查看按钮
        NSDictionary *dataDic=self.dataSource[button.tag];
        [self.obj createGroupMemberWithUserId:[dataDic objectForKey:@"userid"] andGroupId:[dataDic objectForKey:@"groupid"]];
    }

}


-(void)createHudView{
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
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
    headerLB.text=@"舰队管理";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10) andTag:5000 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    
    
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(32*DEF_Adaptation_Font*0.5, 889*DEF_Adaptation_Font*0.5,521*DEF_Adaptation_Font*0.5,  1.0*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor grayColor]];
    [bkV addSubview:line];
    
    UIButton *createBtn = [LooperToolClass createBtnImageName:@"btn_createFleet.png" andRect:CGPointMake(221, 920) andTag:5001 andSelectImage:@"btn_createFleet.png" andClickImage:@"btn_createFleet.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:createBtn];
    

}


-(void)initView{

    [self createHudView];
    UIView *headerV=[[UIView alloc]initWithFrame:CGRectMake(0, 68*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 50*DEF_Adaptation_Font*0.5)];
     headerV.backgroundColor=ColorRGB(82, 73, 103, 1.0);
    [bkV addSubview:headerV];
    [self createBtnLabel:CGRectMake(0*DEF_Adaptation_Font*0.5,78*DEF_Adaptation_Font*0.5,210*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:101 andStr:@"序列名称"];
    UIButton *sortBtn=[LooperToolClass createBtnImageNameReal:@"familyMember_sort.png" andRect:CGPointMake(160*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5) andTag:5001 andSelectImage:@"familyMember_sort.png" andClickImage:@"familyMember_sort.png" andTextStr:nil andSize:CGSizeMake(15*DEF_Adaptation_Font*0.5, 15*DEF_Adaptation_Font*0.5) andTarget:self];
    [bkV addSubview:sortBtn];
    [self createBtnLabel:CGRectMake(210*DEF_Adaptation_Font*0.5,78*DEF_Adaptation_Font*0.5,150*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:100 andStr:@"队长"];
    [self createBtnLabel:CGRectMake(360*DEF_Adaptation_Font*0.5,78*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:102 andStr:@"人数"];

}
#pragma -UITableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,118*DEF_Adaptation_Font*0.5,DEF_WIDTH(bkV),770*DEF_Adaptation_Font*0.5)];
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
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
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
    cell.backgroundColor=[UIColor clearColor];
    [self setTableViewCellView:cell andIndexPath:indexPath];
    return cell;
}
-(void)setTableViewCellView:(UITableViewCell *)cell andIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *dataDic=self.dataSource[indexPath.row];
    UILabel *headLB=[[UILabel alloc]initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5, 210*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    headLB.textColor=[UIColor whiteColor];
    headLB.textAlignment=NSTextAlignmentCenter;
    headLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    headLB.text=[dataDic objectForKey:@"groupname"];
    [cell.contentView addSubview:headLB];
    
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(210*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    nameLB.textColor=[UIColor whiteColor];
    nameLB.textAlignment=NSTextAlignmentCenter;
    nameLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    nameLB.text=[dataDic objectForKey:@"nickname"];
    [cell.contentView addSubview:nameLB];
    
    UILabel *numberLB=[[UILabel alloc]initWithFrame:CGRectMake(360*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    numberLB.textColor=[UIColor whiteColor];
    numberLB.textAlignment=NSTextAlignmentCenter;
    numberLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    numberLB.text=[dataDic objectForKey:@"membercount"];
    [cell.contentView addSubview:numberLB];
    
    UIButton *selectBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(DEF_WIDTH(bkV)-120*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5) andTag:(int)indexPath.row andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
    [selectBtn setTitle:@"查看" forState:(UIControlStateNormal)];
    [selectBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    selectBtn.titleLabel.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    selectBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
    selectBtn.layer.borderWidth=1.0*DEF_Adaptation_Font*0.5;
    selectBtn.layer.cornerRadius=20*DEF_Adaptation_Font*0.5;
    selectBtn.layer.masksToBounds=YES;
    [cell.contentView addSubview:selectBtn];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  92*DEF_Adaptation_Font*0.5;
}


-(void)createBtnLabel:(CGRect)rect and:(int)tag andStr:(NSString*)string{
    UILabel *btnName=[[UILabel alloc]initWithFrame:rect];
    btnName.text=string;
    btnName.userInteractionEnabled=YES;
    btnName.tag=tag;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBtn:)];
    [btnName addGestureRecognizer:singleTap];
    [self addSubview:btnName];
    btnName.textColor=ColorRGB(255, 255, 255, 0.7);
    btnName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:11.f];
    btnName.textAlignment=NSTextAlignmentCenter;
    [bkV addSubview:btnName];
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
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
@end
