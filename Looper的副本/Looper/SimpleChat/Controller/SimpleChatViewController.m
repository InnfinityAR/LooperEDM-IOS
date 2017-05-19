//
//  SerachViewController.m
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "SimpleChatViewController.h"
#import "LooperConfig.h"

@interface SimpleChatViewController ()

@end

@implementation SimpleChatViewController

@synthesize SimpleChatVm = _SimpleChatVm;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    
   
}

-(void)chatTargetID:(NSDictionary*)TargetDic{
    
     _SimpleChatVm=[[SimpleChatViewModel alloc] initWithController:self];
    [_SimpleChatVm setTargetIDChat:TargetDic];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    if (! [ [ self.navigationController viewControllers] containsObject:self]) {
        [_SimpleChatVm removeSimpleAction];
    }
    [super viewWillDisappear:animated];
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
