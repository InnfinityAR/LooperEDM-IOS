//
//  UserInfoViewModel.m
//  Looper
//
//  Created by 工作 on 2017/5/23.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "UserInfoViewModel.h"
#import "UserInfoViewController.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "messageViewController.h"
#import "SettingViewController.h"
#import "commonTableView.h"
#define UserInfoURL @"getHome"
#import "MainViewModel.h"
#import "MainViewController.h"
#import "SimpleChatViewController.h"
#import "looperViewController.h"
@implementation UserInfoViewModel{
    NSString *userID;
    commonTableView *commonTable;;
}
-(id)initWithController:(id)controller{
    if (self=[super init]) {
        self.obj=(UserInfoViewController *)controller;
        self.VMNumber=1;
        [self initView];
    }
    return self;
}
-(void)initView{
    self.useView=[[UseInfoView alloc]initWithFrame:CGRectMake(0, 0,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [self.obj setView:self.useView];
}
-(NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic=[NSMutableDictionary new];
    }
    return _dataDic;
}
-(void)getDataForSomething:(NSString *)something{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:something forKey:@"userId"];
    userID=something;
//    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:UserInfoURL parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            self.dataDic = responseObject[@"data"];
            _dataDic=[_dataDic objectForKey:@"User"];
            [self.useView reloadTableData:self.dataDic];
        }
    }fail:^{
        
    }];
    [self requestgetMyFavorite:self.VMNumber];
    
}
-(void)hudOnClick:(NSInteger)type{
    if(type==103){
        //设置按钮
        [self jumpToSettingC];
        
    }else if(type==104){
        //消息信箱
//        [self createMessageController];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:userID forKey:@"userid"];
        [self pushControllerToUser:dic];
        
    }else if(type==8001){
        //关注
        [self createCommonView:(int)type];
        
    }else if(type==8002){
        //粉丝
        [self createCommonView:(int)type];
        
    }else if(type==8003){
        //他的loop
       [self createCommonView:(int)type];
        
    }else if(type==8004){
        //喜欢的音乐
        [self createCommonView:(int)type];
        
    }
    else if (type==500008){
        [[self.obj navigationController] popViewControllerAnimated:YES];
    }

}
-(void)createMessageController{
    
    messageViewController *messageVc = [[messageViewController alloc] init];
    //    [_obj presentViewController:messageVc animated:YES completion:nil];
    
    [[_obj navigationController]  pushViewController:messageVc animated:YES];
}
-(void)jumpToSettingC{
    SettingViewController *settingVc = [[SettingViewController alloc] init];
    [[_obj navigationController]  pushViewController:settingVc animated:YES];
}



-(void)createCommonView:(int)type{
    type=type-8000;
    commonTable=[[commonTableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self and:type];
    [[_obj view] addSubview:commonTable];
    
}
//加载musicData数据
-(void)requestgetMyFavorite:(NSInteger)type{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
//    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:userID forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyFavorite" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            _musicData = responseObject[@"data"];
            [self requestMainData:type];
        }
    }fail:^{
        
    }];
    
}
//加载mainData数据
-(void)requestMainData:(NSInteger)type{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:userID forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getHome" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSLog(@"%@",responseObject);
            _MainData = [[NSDictionary alloc] initWithDictionary:responseObject];
            [commonTable updataView];
            
        }else{
            
        }
    }fail:^{
        
    }];
}
-(void)popWithViewController{
    [[self.obj navigationController] popViewControllerAnimated:YES];

}
-(void)removeCommonView{
    
    [commonTable removeFromSuperview];
    
    
}
-(void)pushControllerToUser:(NSDictionary*)dic{
    
    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:dic];
    [[_obj navigationController]  pushViewController:simpleC animated:YES];
}
-(void)JumpLooperView:(NSDictionary*)loopData{
    
    looperViewController *looperV = [[looperViewController alloc] init];
    
    [looperV initWithData:loopData];
    
    [[_obj navigationController]  pushViewController:looperV animated:NO];
    
}

@end
