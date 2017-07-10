//
//  PhotoWallViewController.m
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhotoWallViewController.h"
#import "PhotoWallViewModel.h"

@interface PhotoWallViewController ()

@end

@implementation PhotoWallViewController
@synthesize photoWallVm = _photoWallVm;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _photoWallVm = [[PhotoWallViewModel alloc] initWithController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
