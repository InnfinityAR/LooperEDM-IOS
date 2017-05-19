//
//  ActivityViewController.m
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityViewModel.h"
@interface ActivityViewController ()
@property(nonatomic,strong)ActivityViewModel *activityVM;

@end

@implementation ActivityViewController
-(ActivityViewModel *)activityVM{
    if (!_activityVM) {
        _activityVM=[[ActivityViewModel alloc]initWithController:self];
    }
    return _activityVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityVM pustDataForSomeString:NULL];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.title=@"Looper EDM";
//    导航栏字体设为白色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
}



@end
