//
//  LooperListViewController.m
//  Looper
//
//  Created by lujiawei on 4/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LooperListViewController.h"
#import "LooperListViewModel.h"

@interface LooperListViewController ()

@end

@implementation LooperListViewController
@synthesize LooperListVm = _LooperListVm;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     _LooperListVm=[[LooperListViewModel alloc] initWithController:self];

}

- (void)viewWillAppear:(BOOL)animated{

   


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
