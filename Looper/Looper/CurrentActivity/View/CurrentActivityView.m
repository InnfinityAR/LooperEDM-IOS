//
//  CurrentActivityView.m
//  Looper
//
//  Created by 工作 on 2017/5/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "CurrentActivityView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "CurrentActivityTableViewCell.h"
@implementation CurrentActivityView
//更新tableview
-(void)reloadTableData:(NSMutableArray*)DataLoop{
    self.dataArr=DataLoop;
    [self.tableView reloadData];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray new];
    }
    return _dataArr;
}
-(instancetype)initWithFrame:(CGRect)frame andFromView:(UIView *)view andMyData:(NSMutableArray*)myDataSource{
#warning-如果这句话不加则没有初始化view不能触发点击事件
    if (self=[super initWithFrame:frame]) {
        self.obj=view;
        self.dataArr=myDataSource;
        UILabel *looperName = [LooperToolClass createLableView:CGPointMake(38*DEF_Adaptation_Font*0.5,24*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"全部活动" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
        [self addSubview:looperName];
        UIButton *backBtn = [LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(5, 48/2) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(85, 55) andTarget:self];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_allActivity.png"] forState:UIControlStateNormal];
        [self addSubview:backBtn];
        
        //加载懒加载
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CurrentActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
        [view addSubview:self];
        [self initView];
    }
    return self;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
#warning -用于返回活动界面
}
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0]];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 140*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT- 110*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //禁止上拉
        _tableView.alwaysBounceVertical=NO;
        _tableView.bounces=NO;
        //设置分割线
        _tableView.separatorColor = [UIColor colorWithRed:64/255.0 green:62/255.0 blue:162/255.0 alpha:1.0];
        _tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);        // 设置端距，这里表示separator离左边和右边均1像素
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.backgroundColor=[UIColor colorWithRed:15/255.0 green:23/255.0 blue:58/255.0 alpha:1.0];
    }
    return _tableView;
}
#pragma-UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArr.count;
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellStyleDefault;
    //cell不能被选中
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
}

@end
