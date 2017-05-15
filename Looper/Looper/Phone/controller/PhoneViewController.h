//
//  HomeViewController.h
//  Looper
//
//  Created by lujiawei on 12/13/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneViewModel.h"


@interface PhoneViewController : UIViewController{


    PhoneViewModel *phoneVm;
    

}

@property(nonatomic)PhoneViewModel *phoneVm;

-(void)popController;


@end
