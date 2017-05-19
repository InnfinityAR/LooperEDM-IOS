//
//  StartViewController.h
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "StartViewModel.h"

@interface StartViewController : UIViewController
{
    AVPlayer* player;
    StartViewModel *startVm;
    
    


}
@property(nonatomic)AVPlayer *player;
@property(nonatomic)StartViewModel *startVm;

-(void)toMainHomeView;

@end
