//
//  nActivityViewController.h
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nActivityViewModel.h"

@interface nActivityViewController : UIViewController
{
    
    nActivityViewModel *activityVm;
    
}
@property(nonatomic)nActivityViewModel *activityVm;



@end
