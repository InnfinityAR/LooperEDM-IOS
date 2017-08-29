//
//  VideoViewController.m
//  Looper
//
//  Created by lujiawei on 04/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LooperConfig.h"
#import "LoginViewController.h"
#import "LooperToolClass.h"
#import "RotateNavigationController.h"

#import "textViewController.h"

#import "AppDelegate.h"


@interface VideoViewController ()

@end

@implementation VideoViewController{

    AVPlayer *_player;
    AVPlayerLayer *playerLayer;
    
    int num_video;
    
    UIButton* jumpBtn;


}


-(void)stop{
    
    [_player pause];
    
    [_player setRate:0];


}

-(void)resume{

    [_player play];
}



-(void)viewWillDisappear:(BOOL)animated{


    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"videoStop" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"videoResume" object:nil];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self LocalPhoto];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stop) name:@"videoStop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resume) name:@"videoResume" object:nil];
    
    
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = 1;
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    //上一句话是防止手动先把设备置为横屏,导致下面的语句失效.
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    
    
    [self playVideo];
    
    
    [self createViewTouch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag==102){
    
        [self jumpToView];
        
    }
}



- (BOOL)shouldAutorotate {
    return YES;
}


-(void)setVideo:(int)videoType{

    num_video=videoType;

}


-(void)playVideo{
   // [self clickToRotate];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"720.mp4" withExtension:nil];
    _player=[AVPlayer playerWithURL:url];
    playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT);
    [[self view].layer addSublayer:playerLayer];
    [_player play];
    
    

}


-(void)onClickTouchView{

    [jumpBtn setHidden:false];


}


-(void)createViewTouch{
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [[self view] addSubview:touchView];
    touchView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickTouchView)];
    [touchView addGestureRecognizer:singleTap];

    
    jumpBtn = [LooperToolClass createBtnImageName:@"btn_jump.png" andRect:CGPointMake(1700, 34) andTag:102 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [[self view] addSubview:jumpBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[_player currentItem]];
    jumpBtn.frame=CGRectMake(1700*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font*0.5, 104*DEF_Adaptation_Font*0.8,51*DEF_Adaptation_Font*0.8);
    
    [jumpBtn setHidden:true];

    


}


-(void)jumpToView{
    
    
    [_player seekToTime:kCMTimeZero];
    
    [_player pause];
    
    [_player setRate:0];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
    

    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = 0;

    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    //上一句话是防止手动先把设备置为竖屏,导致下面的语句失效.
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    
    
    if(num_video==1){
        LoginViewController* login = [[LoginViewController alloc] init];
        
        self.view.window.rootViewController = login;
        [self.view.window makeKeyAndVisible];
    
    }else if(num_video==2){
        
    
        [self.navigationController popViewControllerAnimated:true];
    }
    
    
    
   

    //[login jumpToMain];
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    [self jumpToView];
    
}





@end
