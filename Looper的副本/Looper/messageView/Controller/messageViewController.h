//
//  messageViewController.h
//  Looper
//
//  Created by lujiawei on 29/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewModel.h"

@interface messageViewController : UIViewController
{
    
    MessageViewModel *messageVm;
    
}
@property(nonatomic)MessageViewModel *messageVm;





@end
