//
//  ActivityView.m
//  Looper
//
//  Created by 工作 on 2017/5/17.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityView.h"
#import "LooperConfig.h"
#import "ActivityCell.h"
#import "ActivityViewController.h"
#import "UIImageView+WebCache.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
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
        UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
        [self addSubview:backBtn];
        UILabel *looperName = [LooperToolClass createLableView:CGPointMake(38*DEF_Adaptation_Font*0.5,24*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:@"Looper EDM" andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
        [self addSubview:looperName];

        //加载懒加载
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivityCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
        [self initView];
    }
    return self;
    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        
        [_obj popController];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 97*DEF_Adaptation_Font*0.5,640*DEF_Adaptation_Font*0.5, DEF_SCREEN_HEIGHT- 93*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        _tableView.delaysContentTouches = NO;
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
-(void)reloadTableData:(NSMutableArray*)DataLoop{
    self.dataArr=DataLoop;
    [self.tableView reloadData];
}

#pragma-UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.objDic=[[NSDictionary alloc]initWithDictionary:self.dataArr[indexPath.row]];
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:self.objDic[@"message"]];
    [cell.mainPhoto sd_setImageWithURL:[NSURL URLWithString:self.objDic[@"activityimage"]]];
    [cell.headPhoto sd_setImageWithURL:[NSURL URLWithString:dic[@"userimage"]]];
    cell.themeLB.text=@"Looper星球送票啦  在音乐界或者现场的时候是怎么样的体验";
    cell.commentLB.text=dic[@"messagecontent"];
//    cell.endTimeLB.text=[self.objDic[@"startdate"]substringToIndex:10];
//    cell.numberLB.text=[self.objDic[@"enddate"]substringToIndex:10];;
    if ([self.objDic[@"followercount"] isEqualToString:@"0"] ){
    if ([self.objDic[@"followercount"]intValue]==0){
        cell.followCountLB.text=@"我要参加";
    }
    else{
        cell.followCountLB.text=[NSString stringWithFormat:@"%@人参加", self.objDic[@"followercount"]];
    }
    }
    return cell;
    
}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.obj dataForH5:self.dataArr[indexPath.row]];

}


@end
