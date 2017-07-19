//
//  SerachViewController.m
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "SerachViewController.h"
#import "SerachViewModel.h"

@interface SerachViewController ()

@end

@implementation SerachViewController
@synthesize SerachVm = _SerachVm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
      _SerachVm=[[SerachViewModel alloc] initWithController:self];
    
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)viewWillAppear:(BOOL)animated{

    
   // [_SerachVm updateData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
