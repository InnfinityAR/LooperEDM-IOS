//
//  CreateLoopController.m
//  Looper
//
//  Created by lujiawei on 18/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "CreateLoopController.h"

@interface CreateLoopController ()

@end

@implementation CreateLoopController

@synthesize CreateLoopVm = _CreateLoopVm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     _CreateLoopVm = [[CreateLoopViewModel alloc] initWithController:self];
    
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
