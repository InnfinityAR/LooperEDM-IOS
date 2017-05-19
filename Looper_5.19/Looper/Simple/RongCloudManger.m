//
//  RongCloudManger.m
//  Looper
//
//  Created by lujiawei on 1/13/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "RongCloudManger.h"
#import "LocalDataMangaer.h"
#import <RongIMLib/RongIMLib.h>
#import "looperViewModel.h"
#import "AFNetworkTool.h"
#import "SimpleChatViewModel.h"


static RongCloudManger *RongCloudMangerM=nil;

@implementation RongCloudManger{

     NSObject* joinRoom;

}

+(RongCloudManger *)sharedManager{
    if(RongCloudMangerM==nil){
        RongCloudMangerM=[[RongCloudManger alloc]init];
    }
    return RongCloudMangerM;
}

-(void)initRongCloudSDK{

     [[RCIMClient sharedRCIMClient] initWithAppKey:@"pkfcgjstpkj78"];
}


-(void)joinCharRoom:(NSObject*)object{
    
    joinRoom = object;

}


-(void)loginRCSdk{
    
    [[RCIMClient sharedRCIMClient] connectWithToken:[LocalDataMangaer sharedManager].tokenStr success:^(NSString *userId) {
        [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
        
    } error:^(RCConnectErrorCode status) {
        
    } tokenIncorrect:^{
        
        NSLog(@"token错误");
    }];
}


-(void)sendMessage:(NSString*)MessageStr andType:(int)typeNum andTargetId:(NSString*)targetId andRealTarget:(NSString*)realTargetId andReplyMessageId:(NSString*)replyMessID andReplyMessageText:(NSString*)replyMessageText{

    int num;
    if(typeNum==1){
        num = ConversationType_GROUP;
    }else if(typeNum==2){
        num = ConversationType_PRIVATE;
    }
    RCTextMessage *testMessage = [RCTextMessage messageWithContent:MessageStr];
    // 调用RCIMClient的sendMessage方法进行发送，结果会通过回调进行反馈。
    [[RCIMClient sharedRCIMClient] sendMessage:num
                                      targetId:targetId
                                       content:testMessage
                                   pushContent:nil
                                      pushData:nil
                                       success:^(long messageId) {
                                           NSLog(@"%ld",messageId);
                                           
                                           NSMutableDictionary *senderDic = [[NSMutableDictionary alloc] initWithCapacity:50];
                                           [senderDic setObject:MessageStr forKey:@"text"];
                                           [senderDic setObject:targetId forKey:@"targetId"];
                                           [senderDic setObject:[[NSNumber alloc] initWithLong:messageId] forKey:@"messageId"];
                                           [senderDic setObject:[LocalDataMangaer sharedManager].uid forKey:@"senderUserId"];
                                           [senderDic setObject:[LocalDataMangaer sharedManager].HeadImageUrl  forKey:@"HeadImageUrl"];
                                           if(realTargetId!=nil){
                                               [senderDic setObject:realTargetId  forKey:@"realTargetId"];
                                               [senderDic setObject:replyMessID  forKey:@"realMessageId"];
                                               [senderDic setObject:replyMessageText  forKey:@"realMessageText"];
                                           }
                                           NSDate *now= [NSDate date];
                                           long int nowDate = (long int)([now timeIntervalSince1970]);
                                           [senderDic setObject:[[NSNumber alloc] initWithLong:nowDate] forKey:@"sentTime"];

                                           [(looperViewModel*)joinRoom ReceiveMessage:senderDic];
                                       } error:^(RCErrorCode nErrorCode, long messageId) {
                                       }];
}


- (void)onReceived:(RCMessage *)message
              left:(int)nLeft
            object:(id)object {
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:message.senderUserId forKey:@"userId"];
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getUserById" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                NSMutableDictionary *senderDic = [[NSMutableDictionary alloc] initWithCapacity:50];
                [senderDic setObject:testMessage.content forKey:@"text"];
                [senderDic setObject:message.targetId forKey:@"targetId"];
                [senderDic setObject:[[NSNumber alloc] initWithLong: message.messageId] forKey:@"messageId"];
                [senderDic setObject:message.senderUserId forKey:@"senderUserId"];
                [senderDic setObject:[responseObject[@"data"]objectForKey:@"NickName"] forKey:@"name"];
                [senderDic setObject:[responseObject[@"data"]objectForKey:@"HeadImageUrl"] forKey:@"HeadImageUrl"];
                [senderDic setObject:[[NSNumber alloc] initWithLong: message.sentTime/1000] forKey:@"sentTime"];
                [(looperViewModel*)joinRoom ReceiveMessage:senderDic];
                
                
                
            }else{
                
            }
        }fail:^{
            
        }];
        
       
    }

}



@end
