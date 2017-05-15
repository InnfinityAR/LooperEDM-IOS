//
//  SerachViewController.m
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "looperViewController.h"
#import "looperViewModel.h"
#import "LooperConfig.h"
#import "NIMCloudMander.h"

@interface looperViewController ()

@end

@implementation looperViewController{

    NSDictionary *looperData;

}
@synthesize looperVm = _looperVm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1.0]];
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


-(void)initLiveView{ 

//    if([looperData objectForKey:@"pull_url"]!=[NSNull null]){
//        
//    
//    
//    self.liveplayer = [[NELivePlayerController alloc]
//                       initWithContentURL:[[NSURL alloc] initWithString:[looperData objectForKey:@"pull_url"]]];
//    if (self.liveplayer == nil) {
//    }
//    self.liveplayer.view.frame = CGRectZero;
//    [self.view addSubview:self.liveplayer.view];
//    [self.liveplayer setBufferStrategy:NELPTopSpeed];
//     [self.liveplayer setScalingMode:NELPMovieScalingModeAspectFit];
//    [self.liveplayer setShouldAutoplay:YES];
//    [self.liveplayer setHardwareDecoder:true];
//    [self.liveplayer setPauseInBackground:NO];
//    
//    [self.liveplayer prepareToPlay];
//    [self.liveplayer play];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
//                                                 name:NELivePlayerDidPreparedToPlayNotification
//                                               object:_liveplayer];
//        
//    }
}


- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification
{
    NSLog(@"NELivePlayerDidPreparedToPlay");
  //  [self.liveplayer play]; //开始播放
}

-(void)initWithData:(NSDictionary*)localData{
    looperData = localData;
    self.view.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    
    
   // [self initLiveView];
    
    _looperVm=[[looperViewModel alloc] initWithController:self];
    [_looperVm initWithData:localData];
}


- (void)viewWillAppear:(BOOL)animated{

    if(_looperVm!=nil){
    
        [_looperVm getLoopMusic:1];
    }

}


- (void)viewWillDisappear:(BOOL)animated{
    if (! [ [ self.navigationController viewControllers ] containsObject:self ]) {
        [_looperVm removeAction];
        // [self.liveplayer stop];
    }
    [super viewWillDisappear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
