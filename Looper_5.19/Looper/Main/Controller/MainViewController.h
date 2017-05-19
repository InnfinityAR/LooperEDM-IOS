//
//  MainViewController.h
//  Looper
//
//  Created by lujiawei on 12/11/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"



@interface MainViewController : UIViewController{


    MainViewModel *MainVM;
    

}
@property(nonatomic)MainViewModel *MainVM;

@end
