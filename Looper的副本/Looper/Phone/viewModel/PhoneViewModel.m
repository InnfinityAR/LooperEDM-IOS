//
//  HomeViewModel.m
//  Looper
//
//  Created by lujiawei on 12/23/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "PhoneViewModel.h"
#import "PhoneViewController.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import "SimpleChatViewController.h"

#import "PlayerInfoView.h"

@implementation PhoneViewModel{

    NSMutableArray *messageData;
    NSMutableDictionary *friendData;
    NSDictionary *sourceData;
    PlayerInfoView *_playerInfoV;

}


@synthesize obj = _obj;
@synthesize phoneV = _phoneV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (PhoneViewController*)controller;
        [self initView];
    }
    return  self;
}


//-(void)

-(void)initView{
    friendData = [[NSMutableDictionary alloc] initWithCapacity:50];
    _phoneV = [[PhoneView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [_phoneV initWithData:friendData andMessageData:messageData];
    [[_obj view] addSubview:_phoneV];

    
    [self getMyMessage];
   
}

-(void)removeAction{


    [_phoneV removeAllAction];
    
}


-(void)popController{

    [_phoneV removeFromSuperview];
    _phoneV=nil;
    messageData=nil;
    friendData=nil;
    
    [_obj popController];
}


-(void)getMyMessage{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyMessage" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            sourceData = responseObject;
            messageData =responseObject[@"data"];
             [_phoneV updataData:friendData andMessageData:messageData andSourceData:sourceData];
             [self getFriendList:1];
        }
    }fail:^{
        
    }];
}


-(void)readMessage:(int)type{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[NSNumber alloc] initWithInt:type] forKey:@"type"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"readMessage" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            }
    }fail:^{
        
    }];
}


-(void)getFriendList:(int)type{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getFriendList" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            if(type==1){
                [friendData setObject:responseObject[@"data"] forKey:@"follow"];
                if(_phoneV!=nil){
                     [self getFriendList:2];
                }
                
            }else{
                [friendData setObject:responseObject[@"data"] forKey:@"fans"];
                if(_phoneV!=nil){
                    [_phoneV updataData:friendData andMessageData:messageData andSourceData:sourceData];
                }
            }
        }
    }fail:^{
        
    }];
}


-(void)removePlayerInfo{
    [_playerInfoV removeFromSuperview];
    
}


-(void)pushController:(NSDictionary*)dic{
    
    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:dic];
    [[_obj navigationController] pushViewController:simpleC animated:NO];
    
    
}

-(void)JumpToSimpleChat:(NSDictionary*)TargetDic{

    NSLog(@"%@",TargetDic);

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:TargetDic[@"UserID"] forKey:@"userId"];

        _playerInfoV = [[PlayerInfoView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        _playerInfoV.userInteractionEnabled=true;
        _playerInfoV.multipleTouchEnabled=true;
        [[_obj view] addSubview:_playerInfoV];
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getUserById" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                [_playerInfoV initWithlooperData:responseObject[@"data"] andisFollow:0];
                
            }else{
                
            }
        }fail:^{
            
        }];
}




@end
