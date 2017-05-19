//
//  messageViewController.m
//  Looper
//
//  Created by lujiawei on 29/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "messageViewController.h"

@interface messageViewController ()

@end

@implementation messageViewController

@synthesize messageVm = _messageVm;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _messageVm = [[MessageViewModel alloc] initWithController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
