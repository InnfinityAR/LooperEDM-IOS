//
//  HomeViewController.h
//  Looper
//
//  Created by lujiawei on 12/13/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"

@interface HomeViewController : UIViewController{


    HomeViewModel *homeVm;
    

}

@property(nonatomic)HomeViewModel *homeVm;

@end
