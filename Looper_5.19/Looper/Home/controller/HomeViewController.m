//
//  HomeViewController.m
//  Looper
//
//  Created by lujiawei on 12/13/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize homeVm =  _homeVm;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.multipleTouchEnabled=true;
    
    
      _homeVm=[[HomeViewModel alloc] initWithController:self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillDisappear:(BOOL)animated{

    
    if (! [ [ self.navigationController viewControllers ] containsObject:self ]) {
       [_homeVm deallocViewAnimation];
    }
    
    [super viewWillDisappear:animated];

}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
