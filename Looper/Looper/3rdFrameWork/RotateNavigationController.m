//
//  RotateNavigationController.m
//  RotateScreen
//
//  Created by obo on 16/1/28.
//  Copyright © 2016年 obo. All rights reserved.
//

#import "RotateNavigationController.h"

@implementation RotateNavigationController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        self.interfaceOrientation = UIInterfaceOrientationPortrait;
        self.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
    }
    
    return self;
}

//设置是否允许自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}

//设置支持的屏幕旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.interfaceOrientationMask ;
}

////设置presentation方式展示的屏幕方向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return self.interfaceOrientation ;
//}


@end
