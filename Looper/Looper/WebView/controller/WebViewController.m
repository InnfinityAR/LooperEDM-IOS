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
    NSMutableArray *userArray;
    id obj;
    
    int index;
    int sum;
    NSMutableArray *array;
    
    
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    
    
    UIWebView *webV;
    
    
    
    int userCount;
    

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

    webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 110*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-110*DEF_Adaptation_Font*0.5)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&userid=%@",urlH5,[LocalDataMangaer sharedManager].uid]]];
    [webV loadRequest:request];
    webV.delegate=self;
    [self.view addSubview:webV];
    [webV setBackgroundColor:[UIColor blackColor]];
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
     //[self createWebView];
     //[self createHudView];
    
    
//    NSDictionary *dic=[ReadJsonFile readFile:@"openid.json"];
//    
//    array = [[NSMutableArray alloc] initWithArray:[[dic objectForKey:@"data"] objectForKey:@"openid"]];
//    
//    
//    NSDictionary *dic1=[ReadJsonFile readFile:@"1.json"];
//   // NSDictionary *dic2=[ReadJsonFile readFile:@"2.json"];
//   // NSDictionary *dic3=[ReadJsonFile readFile:@"3.json"];
//    
//    
//    array1 = [[NSMutableArray alloc] initWithArray:[dic1 objectForKey:@"data"]];
//   // array2 = [[NSMutableArray alloc] initWithArray:[dic2 objectForKey:@"data"]];
//    //array3 = [[NSMutableArray alloc] initWithArray:[dic3 objectForKey:@"data"]];
//    
//    
//    index = 0;
//    sum = [array count];
////    NSLog(@"%@",array);
//    userCount = 0;
//    
//    
//    
//    userArray = [[NSMutableArray alloc] initWithCapacity:50];
//    
//    [self toNetWork:[array objectAtIndex:index]];
}



-(void)thumbupGroup:(NSString*)groupID andUnionID:(NSString*)unionID{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:groupID forKey:@"groupId"];
    [dic setObject:unionID forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"thumbupGroup" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            if((sum-1)>(index+1)){
                index =index +1;
                [self toNetWork:[array objectAtIndex:index]];
            }
        }else{
            
            
            if((sum-1)>(index+1)){
                index =index +1;
                [self toNetWork:[array objectAtIndex:index]];
            }

            
        }
    }fail:^{
        
    }];

}




-(void)sendMessage:(NSString*)message andGroupID:(NSString*)groupId andUnionId:(NSString*)unionID{

    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:@"3" forKey:@"activityId"];
    [dic setObject:unionID forKey:@"userId"];
    [dic setObject:message forKey:@"message"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendActivityMessage" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
        }
    }fail:^{
        
    }];

    
    
    
    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
//    [dic setObject:groupId forKey:@"groupId"];
//    [dic setObject:unionID forKey:@"userId"];
//    [dic setObject:message forKey:@"message"];
//    
//    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendActivityMessage" parameters:dic success:^(id responseObject){
//        if([responseObject[@"status"] intValue]==0){
//            [self thumbupGroup:groupId andUnionID:unionID];
//            
//        }else{
//            [self thumbupGroup:groupId andUnionID:unionID];
//            
//        }
//    }fail:^{
//        
//    }];
//
}




-(void)thumbActivityMessage:(NSString*)groupId andUserId:(NSString*)userId andMessageId:(NSString*)messageID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:groupId forKey:@"groupId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:messageID forKey:@"messageId"];

    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"thumbActivityMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
           
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}



-(void)createUser:(NSDictionary *)dicData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[dicData objectForKey:@"unionid"] forKey:@"openId"];
    [dic setObject:@"1" forKey:@"loginType"];
    [dic setObject:[dicData objectForKey:@"headimgurl"] forKey:@"headImageUrl"];
    [dic setObject:[dicData objectForKey:@"nickname"] forKey:@"userName"];
    [dic setObject:[dicData objectForKey:@"sex"] forKey:@"userSex"];

    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createUser" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){

            
            [userArray addObject:responseObject];
            
            
            
            int rand = 1;
            
            
            NSLog(@"rand == %d",rand);
            
            
  
            
            if(rand==1){
                if([array1 count]!=0){
                    [self sendMessage:[array1 objectAtIndex:0] andGroupID:@"1" andUnionId:[[responseObject objectForKey:@"data"] objectForKey:@"userid"]];
                    [array1 removeObjectAtIndex:0];
                }
            }else if(rand==2){
                if([array2 count]!=0){
                
                  [self sendMessage:[array2 objectAtIndex:0] andGroupID:@"2" andUnionId:[dicData objectForKey:@"unionid"]];
                [array2 removeObjectAtIndex:0];
                }
            }else if(rand ==3){
                if([array3 count]!=0){
                  [self sendMessage:[array3 objectAtIndex:0] andGroupID:@"3" andUnionId:[dicData objectForKey:@"unionid"]];
                [array3 removeObjectAtIndex:0];
                }
            }else{
                    if((sum-1)>(index+1)){
                         index =index +1;
                          [self toNetWork:[array objectAtIndex:index]];
                    }
            
            }
        }else{
            
            
        }
    }fail:^{
        
    }];


}

//1495512000 //

//1495600000
-(void)toNetWork:(NSString*)str{
    
    
    
    
    NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] initWithCapacity:50];
    
    
    [AFNetworkTool Clarence_GET_JSONDataWithUrl:str Params:dictemp success:^(id json){
        NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:json];
        if([[dic objectForKey:@"subscribe_time"] intValue]>1495510000){
            NSLog(@"%@",dic);
            
            userCount = userCount+1;
            
            
           // NSLog(@"userCount %d",userCount);
            
            [self createUser:dic];
            
            if((sum-1)>(index+1)){
                index =index +1;
                [self toNetWork:[array objectAtIndex:index]];
            }
            
        }else{
             NSLog(@"%@",dic);
            
            if((sum-1)>(index+1)){
                index =index +1;
                [self toNetWork:[array objectAtIndex:index]];
            }
        
        }

        
    } fail:^{
        
        
    }];
    
}



@end








