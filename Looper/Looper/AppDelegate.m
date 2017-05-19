//
//  AppDelegate.m
//  Looper
//
//  Created by lujiawei on 12/2/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "StartViewController.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "PhoneViewController.h"
#import "SerachViewController.h"
#import "looperViewController.h"
#import "SDWebImageManager.h"
#import "AFNetworkTool.h"
#import "Base64Class.h"
#import "LooperConfig.h"
#import "VideoViewController.h"

#import "LocalDataMangaer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UMMobClick/MobClick.h>

#import "WebViewController.h"



@interface AppDelegate () <UINavigationControllerDelegate>

@end

@implementation AppDelegate

@synthesize allowRotation = _allowRotation;

-(void)ViewDidLoad{



}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    NSLog(@"内存警告了⚠️⚠️⚠️⚠️⚠️⚠️⚠️");
 
}


-(void)initUmSdk{
    
    UMConfigInstance.appKey = @"58453e873eae257110001202";
    UMConfigInstance.channelId = @"App Store";

    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！

    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58453e873eae257110001202"];
    
    // 获取友盟social版本号
    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdaa59db9c810d5d6" appSecret:@"7bb14bcdca4245d777895baba432f7d5" redirectURL:@"http://mobile.umeng.com/social"];
    
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

void uncaughtExceptionHandler(NSException *exception) {
    
    NSLog(@"reason: %@", exception);
    
    // Internal error reporting
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSLog(@"didFinishLaunchingWithOptions");
    
    [NSThread sleepForTimeInterval:1.5];

    
    NSLog(@"%f",DEF_SCREEN_WIDTH);
    NSLog(@"%f",DEF_SCREEN_HEIGHT);
    
    
    
    [self initUmSdk];
    
    BOOL isHasData =  [[LocalDataMangaer sharedManager] isHasUserData];
    
   // isHasData=false;
    
    if(isHasData == false){

        VideoViewController* videoVc = [[VideoViewController alloc] init];
        self.window.rootViewController = videoVc;
        [self.window makeKeyAndVisible];

    }else{
        
        WebViewController *webcv = [[WebViewController alloc] init];
        [webcv webViewWithData:nil andObj:self];
        self.window.rootViewController = webcv;
        [self.window makeKeyAndVisible];
        
        

//        MainViewController *start = [MainViewController alloc];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:start];
//        nav.delegate = self;
//        nav.navigationBar.hidden = YES;
//        nav.interactivePopGestureRecognizer.enabled = YES;
//        self.window.rootViewController = nav;
//
//        [self.window makeKeyAndVisible];
    }

     NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
 
    return YES;
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_allowRotation == 1) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    else
    {
        return (UIInterfaceOrientationMaskPortrait);
    }
}



-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count >1) {
        
        
    } else {
        if (navigationController.viewControllers.count <= 1) {
        }
    }
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count >1) {
        
        
    }
}







- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void)applicationWillResignActive:(UIApplication* )application
{
    //开启后台处理多媒体事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
    UIBackgroundTaskIdentifier *_bgTaskId=[AppDelegate backgroundPlayerID:_bgTaskId];
    //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
}

+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
    //设置并激活音频会话类别
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    //允许应用程序接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
    newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}



@end
