//
//  SerachViewController.h
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SerachViewModel.h"
#import "JKRBubbleViewController.h"

@interface SerachViewController : JKRBubbleViewController{

        SerachViewModel *SerachVm;

}
  @property(nonatomic)SerachViewModel *SerachVm;

@end
