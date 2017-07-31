//
//  SettingViewModel.h
//  Looper
//
//  Created by lujiawei on 23/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "nSettingView.h"

@interface SettingViewModel : NSObject
{
    
    id obj;
    
    
}
-(id)initWithController:(id)controller;
-(void)backController;
-(void)addInfoView;
-(void)addAccoutView;
-(void)removeInfoView;
-(void)removeAccoutView;
-(void)removePhoneBindView;
-(void)addPhoneBindView;
-(void)addOpinionView;
-(void)removeOpinionView;
-(void)LocalPhoto;
-(void)updateUserInfo:(NSString*)userName andSex:(int)sex andHeadImage:(NSString*)headUrl andAge:(NSString*)age;
-(void)requestDataCode:(NSString*)mobileNum;

-(void)bindMobile:(NSString*)mobileNum andCode:(NSString*)code;
-(void)bugReport:(NSString*)reportString and:(NSString*)path;

-(void)jumpLoginViewC;
-(void)createVideoView;
-(void)loginWechat;

@property(nonatomic,strong)id obj;
@property(nonatomic,strong)nSettingView  *settingV;

@end
