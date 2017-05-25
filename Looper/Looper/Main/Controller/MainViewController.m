//
//  MainViewController.m
//  Looper
//
//  Created by lujiawei on 12/11/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize MainVM = _MainVm;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.multipleTouchEnabled=true;
    _MainVm = [[MainViewModel alloc] initWithController:self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{

    if(_MainVm !=nil){
        [_MainVm requestMainData];
            }

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
