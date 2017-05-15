//
//  LooperListViewController.h
//  Looper
//
//  Created by lujiawei on 4/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LooperListViewModel.h"
#import "JKRBubbleViewController.h"

@interface LooperListViewController : JKRBubbleViewController{
    
    LooperListViewModel *LooperListVm;
    
}
@property(nonatomic)LooperListViewModel *LooperListVm;

@end
