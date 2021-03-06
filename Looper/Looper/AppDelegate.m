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
#import "nActivityViewController.h"
#import "SaleTicketController.h"
#import <AlipaySDK/AlipaySDK.h>

#import <Foundation/Foundation.h>


#import "WebViewController.h"


#import "LocationManagerData.h"

#import "ExtractPriceViewController.h"

#import "ScanQRCodeView.h"
#import "ScanQRCode.h"
#import "FamilyRankView.h"
#import"FamilyMessageView.h"


#import "FamilyDetailView.h"

#import"FamilyMemberView.h"

@interface AppDelegate () <UINavigationControllerDelegate>

@end

@implementation AppDelegate
@synthesize allowRotation = _allowRotation;

-(void)ViewDidLoad{



}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    NSLog(@"内存警告了⚠️⚠️⚠️⚠️⚠️⚠️⚠️");
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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
    
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdaa59db9c810d5d6" appSecret:@"b18344bcba1200518a859848a7f8e9ed" redirectURL:@"http://mobile.umeng.com/social"];
    
    
  //  -(void) removePlatformProviderWithPlatformType:(UMSocialPlatformType)platformType;
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_Sina];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_QQ];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_Qzone];
    
}


-(void)initJpush:(NSDictionary*)launchOptions{

    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
       
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];


    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"46ec314e43813bc79d201335"
                          channel:@"App Store1"
                 apsForProduction:YES
            advertisingIdentifier:nil];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}



- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}



void uncaughtExceptionHandler(NSException *exception) {
    
    NSLog(@"reason: %@", exception);
    
    // Internal error reporting
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initJpush:launchOptions];
    [NSThread sleepForTimeInterval:1.5];
    
    NSLog(@"%@",[UIScreen mainScreen].bounds);
    
    
    [self initUmSdk];
    [[LocationManagerData sharedManager] getLocalationPoint];
    
    BOOL isHasData =  [[LocalDataMangaer sharedManager] isHasUserData];

    if(isHasData == false){

        VideoViewController* videoVc = [[VideoViewController alloc] init];
        [videoVc setVideo:1];
        self.window.rootViewController = videoVc;
        [self.window makeKeyAndVisible];

    }else{
        MainViewController *start = [MainViewController alloc];
      //  ShoppingViewController *start=[ShoppingViewController alloc];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:start];
        nav.delegate = self;
        nav.navigationBar.hidden = YES;
        nav.interactivePopGestureRecognizer.enabled = YES;
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }

//    UIViewController *start = [UIViewController alloc];
//    [start.view addSubview:[[FamilyMemberView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObj:nil andDataArr:nil]];
//    [ScanQRCode initScanQRWithCurrentView: start.view];
//    [ScanQRCode initGenerateWithCurrentView:start.view andUrl:nil andImage:nil];
//  UIImageView *imageV=  [ScanQRCode initWithFrame:CGRectMake(0, 0, 50, 50) andUrl:nil andImage:nil];
////    [start.view addSubview:imageV];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:start];
//    nav.delegate = self;
//    nav.navigationBar.hidden = YES;
//    nav.interactivePopGestureRecognizer.enabled = YES;
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];
    
     NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
 
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
    [self.timer setFireDate:[NSDate distantFuture]];
//    [self.thread cancel];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
 [self.timer setFireDate:[NSDate date]];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"videoResume" object:nil];
    [self.player play];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationWillResignActive:(UIApplication* )application
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"videoStop" object:nil];
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


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }

    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }

    return YES;
}




@end
