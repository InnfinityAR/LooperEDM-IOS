//
//  ActivityView.m
//  Looper
//
//  Created by 工作 on 2017/5/17.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityView.h"
#import "ActivityViewModel.h"
#import "LooperConfig.h"
#import "ActivityCell.h"
#import "ActivityViewController.h"
@implementation ActivityView
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray new];
    }
    return _dataArr;
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (ActivityViewModel*)idObject;
        //加载懒加载
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivityCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
        [self initView];
    }
    return self;
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,640*DEF_Adaptation_Font_x*0.5, 998*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        //禁止上拉
        _tableView.alwaysBounceVertical=NO;
        _tableView.bounces=NO;
        
    }
    return _tableView;
}
-(void)initView{
    
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:50];
    [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0]];
    [self.obj pustDataForSomeString:@""];
}
-(void)reloadTableData:(NSMutableArray*)DataLoop andUserArray:(NSMutableArray*)DataUser{
    self.dataArr=DataLoop;
    [self.tableView reloadData];
}

#pragma-UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    //    return self.activityVM.rowNumber;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //    cell.accessoryType=UITableViewCellStyleDefault;
    //NSURL *url=[self.activityVM mainPhotoUrlForRow:indexPath.row];
    cell.mainPhoto.image=[UIImage imageNamed:@"1.png"];
    cell.themeLB.text=@"Looper星球送票啦  在音乐界或者现场的时候是怎么样的体验";
    cell.headPhoto.image=[UIImage imageNamed:@"1.png"];
    cell.commentLB.text=@"这是评论这是评论";
    cell.numberLB.text=@"我要参与";
    cell.signIV.image=[UIImage imageNamed:@"1.png"];
    return cell;
    
}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    self.vc.shareUrl=[self.storyVM shareUrlForRow:indexPath.section];
    
}


@end
