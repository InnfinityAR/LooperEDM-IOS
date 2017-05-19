//
//  SerachViewController.h
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "looperViewModel.h"
//#import "NELivePlayer.h"
//#import "NELivePlayerController.h"

@interface looperViewController : UIViewController{

        looperViewModel *looperVm;

}
@property(nonatomic) looperViewModel *looperVm;
//@property(nonatomic, strong) id<NELivePlayer> liveplayer;


-(void)initWithData:(NSDictionary*)localData;

-(void)playMusicForBackgroundWithMusicInfo:(NSDictionary*)musicInfo;
@end
