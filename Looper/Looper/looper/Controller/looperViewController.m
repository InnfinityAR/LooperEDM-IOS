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
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface looperViewController ()
@property(nonatomic,strong)NSString *musicTitle;
@property(nonatomic,strong)NSString *artist;
@property(nonatomic,strong)NSString *photoUrl;
@end

@implementation looperViewController{

    NSDictionary *looperData;
    AVPlayer *_player;
    BOOL _isPlayingNow;
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


// add background Music  hf w
#warning-加载数据的时候引用此方法赋值
-(void)playMusicForBackgroundWithMusicInfo:(NSDictionary*)musicInfo{
    self.musicTitle=[musicInfo objectForKey:@"musicTitle"];
    self.photoUrl=[musicInfo objectForKey:@"photoUrl"];
    self.artist=[musicInfo objectForKey:@"artist"];

    [self setPlayingInfo];

}

#pragma mark - 接收方法的设置
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {  //判断是否为远程控制
        switch (event.subtype) {
            case  UIEventSubtypeRemoteControlPlay:
                if (!_isPlayingNow) {
                    [_player play];
                }
                _isPlayingNow = !_isPlayingNow;
                [_looperVm parseMusic];
                
                break;
            case UIEventSubtypeRemoteControlPause:
                if (_isPlayingNow) {
                    [_player pause];
                }
                _isPlayingNow = !_isPlayingNow;
                 [_looperVm parseMusic];
                
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一首");
#warning-记得加入数据
                 [_looperVm backMusic];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"上一首 ");
                 [_looperVm frontMusic];
                break;
            default:
                break;
        }
    }
}

- (void)setPlayingInfo {
    //    设置后台播放时显示的东西，例如歌曲名字，图片等
    //    <MediaPlayer/MediaPlayer.h>
    if([self.photoUrl length]>0){
        MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.photoUrl]]]];
        
        NSDictionary *dic = @{MPMediaItemPropertyTitle:self.musicTitle,
                              MPMediaItemPropertyArtist:self.artist,
                              MPMediaItemPropertyArtwork:artWork
                              };
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
    
    }
}

- (void)viewDidAppear:(BOOL)animated {
    //    接受远程控制
    [self becomeFirstResponder];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void)viewDidDisappear:(BOOL)animated {
    //    取消远程控制
    [self resignFirstResponder];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}











@end
