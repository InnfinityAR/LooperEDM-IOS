
//
//  LoginModel.m
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginViewController.h"
#import "loginView.h"
#import "AccountView.h"
#import "LooperConfig.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UMSocialNetwork/UMSocialNetwork.h>
#import <UShareUI/UShareUI.h>
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import <RongIMLib/RongIMLib.h>
#import "DataHander.h"
#import "nMainView.h"
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>

@implementation LoginViewModel

@synthesize loginV = _loginV;
@synthesize obj = _obj;
@synthesize accountV = _accountV;
@synthesize bkView = _bkView;
@synthesize effectView = _effectView;


-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (LoginViewController*)controller;
       
             [self initView];

    }
    return  self;
}

-(void)initView{

    
    _loginV = [[loginView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    
    [[_obj view] addSubview:_loginV];
    
}


-(void)hudOnClick:(int)type{
    if(type==500){
    
        [self loginWechat];
    }else if(type==400){
        
    }
}




-(void)LocalPhoto
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [_obj presentViewController:picker animated:YES completion:nil];
        
    });
}




-(void)loginSucceed{
    
    [_loginV removeAllView];
      [self.obj jumpToMain];
}


-(void)login:(NSString*)phoneNum andCode:(NSString*)code{


    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:phoneNum forKey:@"mobile"];
    [dic setObject:code forKey:@"vCode"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"checkVerificationCode" parameters:dic  success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    if([responseObject[@"status"] intValue]==0){
        
        [LocalDataMangaer sharedManager].uid = responseObject[@"data"][@"userid"];
        [LocalDataMangaer sharedManager].userData = responseObject[@"data"];
        [LocalDataMangaer sharedManager].tokenStr = responseObject[@"data"][@"sdkid"];
        [LocalDataMangaer sharedManager].HeadImageUrl = responseObject[@"data"][@"headimageurl"];
        [LocalDataMangaer sharedManager].sex = responseObject[@"data"][@"sex"];
        [LocalDataMangaer sharedManager].NickName = responseObject[@"data"][@"nickname"];
        [[LocalDataMangaer sharedManager] setData];
        
        [self loginSucceed];    
    }else{
        //手机号或验证码错误
        [[DataHander sharedDataHander] showViewWithStr:@"手机号或验证码错误" andTime:2 andPos:CGPointZero ];
   
    }

    }fail:^{
        
    }];

}

-(void)requestDataCode:(NSString*)mobileNum{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:mobileNum forKey:@"mobile"];

    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendVerificationCode" parameters:dic  success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    }fail:^{
        
    }];
}


- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated{

    [[DataHander sharedDataHander] showViewWithStr:@"微信未安装,请安装微信后在重试登入" andTime:2 andPos:CGPointZero];
}




-(void)loginWechat{
   
   // [self LocalPhoto];
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *userinfo =result;
        int sexNum;
        
        if(userinfo.openid!=nil){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
            [dic setObject:userinfo.openid forKey:@"openId"];
            [dic setObject:@"1" forKey:@"loginType"];
            [dic setObject:userinfo.iconurl forKey:@"headImageUrl"];
            [dic setObject:userinfo.name forKey:@"userName"];
            
            if([userinfo.gender isEqualToString:@"m"])
            {
                sexNum = 1;
            }else{
                sexNum = 2;
            }
            [dic setObject:[NSString stringWithFormat:@"%d",sexNum] forKey:@"userSex"];
            [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createUser" parameters:dic  success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                if(responseObject!=nil){
                    if([responseObject[@"status"] intValue]==0){
                    [LocalDataMangaer sharedManager].uid = responseObject[@"data"][@"userid"];
                    [LocalDataMangaer sharedManager].thirdId = responseObject[@"data"][@"openid"];
                    [LocalDataMangaer sharedManager].userData = responseObject[@"data"];
                    [LocalDataMangaer sharedManager].tokenStr = responseObject[@"data"][@"sdkid"];
                    [LocalDataMangaer sharedManager].HeadImageUrl = responseObject[@"data"][@"headimageurl"];
                    [LocalDataMangaer sharedManager].sex = responseObject[@"data"][@"sex"];
                    [LocalDataMangaer sharedManager].NickName = responseObject[@"data"][@"nickname"];
                    
                    
                    [[LocalDataMangaer sharedManager] setData];

                    [self loginSucceed];
                    }
                }
                
            }fail:^{
                
            }];
        }
    }];
     
    

}


-(void)loginQQ{
    

}


-(void)loginWeibo{
    
    
    
}

-(void)requestData:(int)DataType andIphone:(NSString*)iphoneNum andCode:(NSString*)codeNum{
    
    if(DataType ==QQBtnTag){
        
    }else  if(DataType ==WEIBOBtnTag){
        
    }else  if(DataType ==WECHATBtnTag){
        [self loginWechat];
    }else if(DataType ==IphoneCodeBtnTag){
        [self requestDataCode:iphoneNum];
    }else if(DataType ==LoginBtnTag){
        [self login:iphoneNum andCode:codeNum];
    }else if(DataType ==AccountBtnTag){
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];

        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _effectView.frame = CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
        [[_obj view] addSubview:_effectView];
        _effectView.alpha = 0.0f;
        
        _bkView =[[UIView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
        [_bkView setBackgroundColor:[UIColor colorWithRed:11.0/255.0 green:11.0/255.0 blue:14/255.0 alpha:1.0]];
        [_bkView setAlpha:0];
        [[_obj view] addSubview:_bkView];
        _accountV = [[LoginAccountView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
       [[_obj view] addSubview:_accountV];
       _accountV.transform = CGAffineTransformScale(_accountV.transform,0.01,1.0);
        [UIView animateWithDuration:0.5 animations:^{
             _effectView.alpha = 0.9f;
            _loginV.transform = CGAffineTransformScale(_loginV.transform,1.1,1.1);
            [_bkView setAlpha:0.72f];
            _accountV.transform = CGAffineTransformScale(_accountV.transform,100,1.0);
        }];
    }else if(DataType ==joinBtnTag){
        [self login:iphoneNum andCode:codeNum];
        
        
        
    }else if(DataType ==backBtnTag){
        [UIView animateWithDuration:0.5 animations:^{
            _loginV.transform = CGAffineTransformScale(_loginV.transform,1/1.1,1/1.1);
            [_bkView setAlpha:0.0f];
            [_accountV removeFromSuperview];
             _effectView.alpha = 0.0f;
        }];
    }

}










@end
