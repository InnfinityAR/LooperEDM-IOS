//
//  SerachViewController.h
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SimpleChatViewModel.h"


@interface SimpleChatViewController : UIViewController{

        SimpleChatViewModel *SimpleChatVm;

}
@property(nonatomic) SimpleChatViewModel *SimpleChatVm;

-(void)chatTargetID:(NSDictionary*)TargetDic;
@end
