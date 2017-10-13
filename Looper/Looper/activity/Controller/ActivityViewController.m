//
//  ActivityViewController.m
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityViewModel.h"
#import "SDImageCache.h"
@interface ActivityViewController ()
@property(nonatomic,strong)ActivityViewModel *activityVM;

@end

@implementation ActivityViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     _activityVM=[[ActivityViewModel alloc]initWithController:self];
    
  //  [self.activityVM pustDataForSomeString:NULL];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.title=@"Looper EDM";
//    导航栏字体设为白色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout =UIRectEdgeNone;
    }
    self.automaticallyAdjustsScrollViewInsets = NO; 
}

- (void)viewWillDisappear:(BOOL)animated{
    
    if (! [ [ self.navigationController viewControllers] containsObject:self]) {
        [_activityVM removeActivityAction];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    }
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
//    [[SDImageCache sharedImageCache] clearDisk];
    
}


@end
