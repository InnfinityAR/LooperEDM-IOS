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

#import "AFNetworkTool.h"


@implementation WebViewController{

    NSDictionary *_webDic;
    id obj;
    
    int index;
    int sum;
    NSMutableArray *array;

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
    
//    NSString *urlH5;
//    if([_webDic objectForKey:@"isFollow"]!=nil){
//        urlH5 = [NSString stringWithFormat:@"%@&fromios=1&isjoin=%@",[_webDic objectForKey:@"H5Url"],[_webDic objectForKey:@"isFollow"]];
//    }else{
//        urlH5 = [NSString stringWithFormat:@"%@&fromios=1",[_webDic objectForKey:@"H5Url"]];
//    }
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mp.weixin.qq.com/s?__biz=MzIwNzY3NDIzMg==&mid=100000347&idx=1&sn=f67fdd9c6a6c4c70879e4ae7c19cb95a&chksm=170f8c4c2078055a42795e39cbbae1d0ebbefb0f908e67fb22dba06670903231739f9512b4ce&mpshare=1&scene=1&srcid=0517K2LXXzri3rqXHj2sZEXF&key=399c349161821f04946fea8c6242bea52429aad73ef8295a5747722c66f60661dd7e4ec8a9d967202af3b499438884b066f1ff78857c03bdb84cedf25691dc61d461167620e1dd7ca0d3e48837335fd4&ascene=0&uin=MTEzMzE2NjcyMA%3D%3D&devicetype=iMac+MacBookPro11%2C5+OSX+OSX+10.12.4+build(16E195)&version=12010310&nettype=WIFI&fontScale=100&pass_ticket=2wjo%2Fpg%2FFmEsvNBIUxJHQcM7ah3voUuA%2BzcTO4hUxM3nTe9aCL5nU4DytoUkXn%2BP"]];
    [webV loadRequest:request];
    [self.view addSubview:webV];
    [webV setBackgroundColor:[UIColor clearColor]];
    [webV stringByEvaluatingJavaScriptFromString:@"window.location.hash"];
    
    webV.allowsInlineMediaPlayback = YES;
    webV.mediaPlaybackRequiresUserAction = NO;

    
//    JSContext *context = [webV valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//
//    context[@"joinActivity"] = ^() {
//        NSLog(@"danfafad");
//        NSString *urlH5 = [NSString stringWithFormat:@"%@&fromios=1&isjoin=%d",[_webDic objectForKey:@"H5Url"],1];
//        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlH5]];
//        [webV loadRequest:request];
//        
//        [(looperViewModel*)obj followLoop];
//    };
}

-(void)webViewWithData:(NSDictionary*)dataDic andObj:(id)objVm{
    _webDic = dataDic;
    obj =objVm;
   // [self createWebView];
   // [self createHudView];
    
    
    NSDictionary *dic=[ReadJsonFile readFile:@"openid.json"];
    
    array = [[NSMutableArray alloc] initWithArray:[[dic objectForKey:@"data"] objectForKey:@"openid"]];
    
    index = 0;
    sum = [array count];
    NSLog(@"%@",array);
    
    
    
    
    [self toNetWork:[array objectAtIndex:index]];
    
}

-(void)toNetWork:(NSString*)str{
    
    NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] initWithCapacity:50];

    
    [AFNetworkTool Clarence_GET_JSONDataWithUrl:str Params:dictemp success:^(id json){
        
        
        NSLog(@"%@",json);
        
        if((sum-1)>(index+1)){
            
            index =index +1;
            [self toNetWork:[array objectAtIndex:index]];
        
        
        
        }
        
    } fail:^{
        
        
    }];




}



@end








