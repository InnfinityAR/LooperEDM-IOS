//
//  StartViewController.m
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//


#import "WebViewController.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "looperViewModel.h"

@implementation WebViewController{

    NSDictionary *_webDic;
    id obj;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


-(void)shareH5{
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        NSString* thumbURL =  [_webDic objectForKey:@"LoopImage"];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: [_webDic objectForKey:@"LoopName"] descr:[_webDic objectForKey:@"LoopDescription"]  thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = [_webDic objectForKey:@"H5Url"];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    }];
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag == 101){
    
        [[self navigationController] popViewControllerAnimated:YES];
    
    }else if(button.tag == 102){
    
        [self shareH5];
    }

}

-(void)createHudView{
    
    
    UIButton *back =[LooperToolClass createBtnImageName:@"active_back.png" andRect:CGPointMake(13, 51) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self.view addSubview: back];
    
    
    UIButton *share =[LooperToolClass createBtnImageName:@"active_share.png" andRect:CGPointMake(571, 62) andTag:102 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self.view addSubview: share];
}

-(void)createWebView{
    
    NSString *urlH5;
    if([_webDic objectForKey:@"isFollow"]!=nil){
        urlH5 = [NSString stringWithFormat:@"%@&fromios=1&isjoin=%@",[_webDic objectForKey:@"H5Url"],[_webDic objectForKey:@"isFollow"]];
    }else{
        urlH5 = [NSString stringWithFormat:@"%@&fromios=1",[_webDic objectForKey:@"H5Url"]];
    }
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlH5]];
    [webV loadRequest:request];
    [self.view addSubview:webV];
    [webV setBackgroundColor:[UIColor clearColor]];
    [webV stringByEvaluatingJavaScriptFromString:@"window.location.hash"];
    
    webV.allowsInlineMediaPlayback = YES;
    webV.mediaPlaybackRequiresUserAction = NO;

    
    JSContext *context = [webV valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    context[@"joinActivity"] = ^() {
        NSLog(@"danfafad");
        NSString *urlH5 = [NSString stringWithFormat:@"%@&fromios=1&isjoin=%d",[_webDic objectForKey:@"H5Url"],1];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlH5]];
        [webV loadRequest:request];
        
        [(looperViewModel*)obj followLoop];
    };
}

-(void)webViewWithData:(NSDictionary*)dataDic andObj:(id)objVm{
    _webDic = dataDic;
    obj =objVm;
    [self createWebView];
    [self createHudView];

}

@end








