//
//  LoginViewController.m
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "StartViewController.h"
#import "MainViewController.h"
#import "RotateNavigationController.h"
#import "LocalDataMangaer.h"

#import "AppDelegate.h"



@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginVm = _loginVm;


- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.multipleTouchEnabled=true;
    _loginVm=[[LoginViewModel alloc] initWithController:self];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)clickToRotate {
    
    RotateNavigationController *navigationController = (RotateNavigationController *)self.navigationController;
    //切换rootViewController的旋转方向
    
    navigationController.interfaceOrientation = UIInterfaceOrientationPortrait;
    navigationController.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
    //设置屏幕的转向为竖屏
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}

-(void)jumpToLogin{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    LoginViewController *start = [[LoginViewController alloc] init];

    self.view.window.rootViewController = start;
    [self.view.window makeKeyAndVisible];

}


-(void)jumpToMain{
    
    MainViewController *start = [[MainViewController alloc] init];
    
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
