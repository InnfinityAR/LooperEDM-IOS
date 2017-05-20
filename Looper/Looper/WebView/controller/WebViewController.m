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
#import "ReadJsonFile.h"

#import "DataHander.h"

#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"


@implementation WebViewController{

    NSDictionary *_webDic;
    id obj;
    
    int index;
    int sum;
    NSMutableArray *array;
    
    UIWebView *webV;
    

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
        NSString* thumbURL =  @"https://looper.blob.core.chinacloudapi.cn/images/activityshare.png";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: [_webDic objectForKey:@"activityname"] descr:@"基友在哪？！快来帮我赢取免费轰趴吧！"  thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = [_webDic objectForKey:@"baseurl"];
        
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
    
        if(index>0){
            index =index-1;
            [webV goBack];
        }else{
        
             [[self navigationController] popViewControllerAnimated:YES];
        }
        
       
    
    }else if(button.tag == 102){
    
        [self shareH5];
        
        
    }

}

-(void)createHudView{
    
    index = 0;
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [[self view] addSubview:backBtn];
    

    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,32*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [[self view] addSubview:shareBtn];
    
}

-(void)createWebView{
    
    NSString *urlH5 = [_webDic objectForKey:@"baseurl"];

    webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 99*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-99*DEF_Adaptation_Font*0.5)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&userid=%@",urlH5,[LocalDataMangaer sharedManager].uid]]];
    [webV loadRequest:request];
    webV.delegate=self;
    [self.view addSubview:webV];
    [webV setBackgroundColor:[UIColor clearColor]];
    [webV stringByEvaluatingJavaScriptFromString:@"window.location.hash"];
    
    webV.allowsInlineMediaPlayback = YES;
    webV.mediaPlaybackRequiresUserAction = NO;
    JSContext *context = [webV valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    context[@"finishLoading"] = ^() {
        NSLog(@"666666666");
       
    };
}


- (void)webViewDidStartLoad:(UIWebView *)webView{


    [[DataHander sharedDataHander] showDlg];

}


- (void)webViewDidFinishLoad:(UIWebView *)webView{

    index = index+1;
    [[DataHander sharedDataHander] hideDlg];
    

}


-(void)webViewWithData:(NSDictionary*)dataDic andObj:(id)objVm{
    _webDic = dataDic;
    obj =objVm;
    [self createHudView];
    
    [self createWebView];
   // [self createHudView];
    
    
}



@end








