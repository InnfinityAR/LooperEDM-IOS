//
//  LoginViewController.h
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface LoginViewController : UIViewController{

    LoginViewModel *loginVm;



}
@property(nonatomic)LoginViewModel *loginVm;


-(void)jumpToMain;

@end
