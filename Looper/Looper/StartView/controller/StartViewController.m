//
//  StartViewController.m
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "StartViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LooperConfig.h"
#import "StartViewModel.h"

#import "MainViewController.h"




@interface StartViewController ()<UINavigationControllerDelegate>



@end

@implementation StartViewController

@synthesize player = _player;
@synthesize startVm = _startVm;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    _startVm = [[StartViewModel alloc] initWithController:self];

}


-(void)toMainHomeView{
    

    MainViewController *start = [MainViewController alloc];

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:start];
    nav.delegate = self;
    nav.navigationBar.hidden = YES;
    

    nav.interactivePopGestureRecognizer.enabled = YES;
  
    
    self.view.window.rootViewController = nav;
    [self.view.window makeKeyAndVisible];
    
}


-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count >1) {
        

    } else {
        if (navigationController.viewControllers.count <= 1) {
                   }
    }
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count >1) {
        
       
    }
}





@end





