//
//  ActivityViewController.m
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityViewModel.h"
#import "TableViewCell.h"
@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)ActivityViewModel *activityVM;
@end

@implementation ActivityViewController
-(ActivityViewModel *)activityVM{
    if (!_activityVM) {
        _activityVM=[[ActivityViewModel alloc]init];
    }
    return _activityVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    导航栏字体设为白色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //禁止上拉
    _tableView.alwaysBounceVertical=NO;
    _tableView.bounces=NO;
    
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
//    return self.activityVM.rowNumber;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
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
