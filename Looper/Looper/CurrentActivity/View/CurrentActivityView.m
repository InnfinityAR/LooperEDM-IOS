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
#import "UIImageView+WebCache.h"
#import "nActivityViewModel.h"
@implementation CurrentActivityView
//更新tableview
-(void)reloadTableData:(NSMutableArray*)DataLoop{
    self.dataArr=DataLoop;
    [self.tableView reloadData];
}
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andMyData:(NSArray*)myDataSource{
#warning-如果这句话不加则没有初始化view不能触发点击事件
    if (self=[super initWithFrame:frame]) {
        self.obj=(nActivityViewModel*)obj;
        self.dataArr=myDataSource;
        UILabel *looperName = [LooperToolClass createLableView:CGPointMake(38*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"全部活动" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
        [self addSubview:looperName];
        UIButton *backBtn = [LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(0, 48/2) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(135*DEF_Adaptation_Font*0.5,110*DEF_Adaptation_Font*0.5) andTarget:self];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"hotActivity.png"] forState:UIControlStateNormal];
        [self addSubview:backBtn];
        //加载懒加载
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CurrentActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
        [self initView];
    }
    return self;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    [self setHidden:YES];
}
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:23/255.0 green:38/255.0 blue:98/255.0 alpha:1.0]];
//动画缩放
//    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    [UIView animateWithDuration:3
//                     animations:^{
//                         self.transform = CGAffineTransformMakeScale(1, 1);
//                     }completion:^(BOOL finish){
//                         
//                        }];

    /*用于进行tableView设置底图
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"pic.jpg"];
    
    [self.tableView addSubview:imgView];
    [self.tableView sendSubviewToBack:imgView];
     */
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 140*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT- 140*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
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
    
    }
    return _tableView;
}
#pragma-UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
//    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellStyleDefault;
    //cell不能被选中
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *activity=self.dataArr[indexPath.row];
    
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:activity[@"photo"]]];
    cell.addressLB.text=activity[@"location"];
    cell.themeLB.text=activity[@"activityname"];
    cell.timeLB.text=[NSString stringWithFormat:@"%@至\n%@",activity[@"starttime"],activity[@"endtime"]];
    cell.ticketLB.text=[NSString stringWithFormat:@"票价%@",activity[@"price"]];
    [cell.edmBtn setTitle:activity[@"tag"] forState:(UIControlStateNormal)];
    return cell;
    
}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.obj addTicket:self.dataArr[indexPath.row]];
   
    
}

@end
