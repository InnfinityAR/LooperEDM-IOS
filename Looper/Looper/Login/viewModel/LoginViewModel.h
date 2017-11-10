//
//  LoginModel.h
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "loginView.h"
#import "LoginAccountView.h"

#define  QQBtnTag 100
#define  WEIBOBtnTag 101
#define  WECHATBtnTag 102
#define  IphoneCodeBtnTag 103
#define  LoginBtnTag 105
#define  AccountBtnTag 106
#define  joinBtnTag 107
#define  backBtnTag 108

#define sendBtnTag 110


@interface LoginViewModel : NSObject{

    loginView *loginV;
    LoginAccountView *accountV;
    UIVisualEffectView *effectView;
    UIView *bkView;
     id obj;

}


-(id)initWithController:(id)controller;

-(void)requestData:(int)DataType andIphone:(NSString*)iphoneNum andCode:(NSString*)codeNum;
-(void)hudOnClick:(int)type;

-(void)login:(NSString*)phoneNum andCode:(NSString*)code;
-(void)requestDataCode:(NSString*)mobileNum;

@property(nonatomic,strong)id obj;
@property(nonatomic)loginView *loginV;
@property(nonatomic)LoginAccountView *accountV;
@property(nonatomic)UIVisualEffectView *effectView;
@property(nonatomic)UIView *bkView;
-(void)creatLoginServiceV:(UIView *)superV;

@end
