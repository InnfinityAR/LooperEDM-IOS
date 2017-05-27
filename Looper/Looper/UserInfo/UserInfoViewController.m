//
//  UserInfoViewController.m
//  Looper
//
//  Created by 工作 on 2017/5/23.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoViewModel.h"
@interface UserInfoViewController ()
@property(nonatomic,strong)UserInfoViewModel *userInfoVM;
@end

@implementation UserInfoViewController
-(UserInfoViewModel *)userInfoVM{
    if (!_userInfoVM) {
        _userInfoVM=[[UserInfoViewModel alloc]initWithController:self];
    }
    return _userInfoVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.userInfoVM getDataForSomething:self.userID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
