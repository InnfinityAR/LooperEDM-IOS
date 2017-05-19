//
//  SettingViewController.m
//  Looper
//
//  Created by lujiawei on 23/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize settingVm = _settingVm;


- (void)viewDidLoad {
    [super viewDidLoad];

      _settingVm = [[SettingViewModel alloc] initWithController:self];
    
    
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
