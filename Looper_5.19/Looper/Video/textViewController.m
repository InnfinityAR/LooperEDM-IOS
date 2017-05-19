//
//  textViewController.m
//  Looper
//
//  Created by lujiawei on 08/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "textViewController.h"
#import "LooperToolClass.h"
#import "LoginViewController.h"

@interface textViewController ()

@end

@implementation textViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.view setBackgroundColor:[UIColor redColor]];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    
    
    [self toMain];

    
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)toMain{
    LoginViewController* login = [[LoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    nav.delegate = self;
    nav.navigationBar.hidden = YES;
    nav.interactivePopGestureRecognizer.enabled = YES;
    
    self.view.window.rootViewController = nav;
    [self.view.window makeKeyAndVisible];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
