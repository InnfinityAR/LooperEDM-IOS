//
//  HomeViewController.m
//  Looper
//
//  Created by lujiawei on 12/13/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "PhoneViewController.h"
#import "PhoneViewModel.h"

@interface PhoneViewController ()

@end

@implementation PhoneViewController

@synthesize phoneVm = _phoneVm;


-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.multipleTouchEnabled=true;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    _phoneVm=[[PhoneViewModel alloc] initWithController:self];
    

}

-(void)popController{
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    if (! [ [ self.navigationController viewControllers ] containsObject:self ]) {
          [_phoneVm removeAction];
    }
    
    
  
    [super viewWillDisappear:animated];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
