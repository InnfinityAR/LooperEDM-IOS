//
//  nActivityViewController.m
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nActivityViewController.h"
#import "nActivityViewModel.h"

@interface nActivityViewController ()

@end

@implementation nActivityViewController

@synthesize activityVm = _activityVm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    _activityVm = [[nActivityViewModel alloc] initWithController:self];
    
}

-(void)jumpToActivityId:(NSString*)activityId{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    
    [dic setObject:activityId forKey:@"activityid"];
    
    [_activityVm addActivityDetailView:dic andPhotoWall:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
