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
     NSMutableArray *sessionArray;
    NSMutableDictionary *userData;

}


-(NSMutableArray*)getSessionArray{
    return sessionArray;
    
}

+(RongCloudManger *)sharedManager{
    if(RongCloudMangerM==nil){
        RongCloudMangerM=[[RongCloudManger alloc]init];
    }
    return RongCloudMangerM;
}

-(void)initRongCloudSDK{
      userData = [[NSMutableDictionary alloc] initWithCapacity:50];
     [[RCIMClient sharedRCIMClient] initWithAppKey:@"c9kqb3rdc93tj"];
}


-(void)joinCharRoom:(NSObject*)object{
    
    joinRoom = object;

}



-(void)getUserData:(NSString*)targetId
           success:(void (^)(id responseObject))success{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:targetId forKey:@"targetId"];
    
    if([userData objectForKey:targetId]!=nil){
        success([userData objectForKey:targetId]);
    }else{
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getUserInfo" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                [userData setObject:responseObject[@"data"] forKey:targetId];
                success(responseObject[@"data"]);
            }
        }fail:^{
            
        }];
    }
}




-(void)loginRCSdk{
    
    [[RCIMClient sharedRCIMClient] connectWithToken:[LocalDataMangaer sharedManager].tokenStr success:^(NSString *userId) {
        NSLog(@"%@",userId);
        
         sessionArray=[[NSMutableArray alloc]initWithArray:[self getConversationList]];
        
        [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
        
    } error:^(RCConnectErrorCode status) {
        
    } tokenIncorrect:^{
        
        NSLog(@"token错误");
    }];
}


-(void)getRomotoHistoryMessage:(int)typeNum andTargetId:(NSString*)targetId andRecordTime:(long)recordTime andMessageCount:(int)Count{
    [[RCIMClient sharedRCIMClient] getRemoteHistoryMessages:ConversationType_PRIVATE targetId:targetId recordTime:recordTime count:Count success:^(NSArray *messages){
    
        NSLog(@"%@",messages);
        
    
    } error:^(RCErrorCode status){
        
    }];
}


-(NSArray*)getConversationList{

   NSArray *conversationList= [[RCIMClient sharedRCIMClient]
     getConversationList:@[@(ConversationType_PRIVATE)]];
    for (RCConversation *conversation in conversationList) {
        NSLog(@"会话类型：%lu，目标会话ID：%@", (unsigned long)conversation.conversationType, conversation.targetId);
    }
    
     sessionArray=[[NSMutableArray alloc]initWithArray:conversationList];
    
    return conversationList;

}


-(void)sendMessage:(NSString*)MessageStr andType:(int)typeNum andTargetId:(NSString*)targetId andRealTarget:(NSString*)realTargetId andReplyMessageId:(NSString*)replyMessID andReplyMessageText:(NSString*)replyMessageText{

    int num;
    if(typeNum==1){
        num = ConversationType_CHATROOM;
    }else {
        num = ConversationType_PRIVATE;
    
        NSMutableDictionary *chatDic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [chatDic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
        [chatDic setObject:targetId forKey:@"targetId"];
        [chatDic setObject:MessageStr forKey:@"messageText"];
    
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendChatMessage" parameters:chatDic success:^(id responseObject){
        }fail:^{
            
        }];
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
        [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
        [dic setObject:message.senderUserId forKey:@"targetId"];
        

            [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getUserInfo" parameters:dic success:^(id responseObject){
                if([responseObject[@"status"] intValue]==0){
                  
                    NSMutableDictionary *senderDic = [[NSMutableDictionary alloc] initWithCapacity:50];
                                    [senderDic setObject:testMessage.content forKey:@"text"];
                                    [senderDic setObject:message.targetId forKey:@"targetId"];
                                    [senderDic setObject:[[NSNumber alloc] initWithLong: message.messageId] forKey:@"messageId"];
                                    [senderDic setObject:message.senderUserId forKey:@"senderUserId"];
                                    [senderDic setObject:[responseObject[@"data"]objectForKey:@"nickname"] forKey:@"name"];
                                    [senderDic setObject:[responseObject[@"data"]objectForKey:@"headimageurl"] forKey:@"HeadImageUrl"];
                                    [senderDic setObject:[[NSNumber alloc] initWithLong: message.sentTime/1000] forKey:@"sentTime"];
                                    [(looperViewModel*)joinRoom ReceiveMessage:senderDic];

                
                
                
                }
            }fail:^{
                
            }];
        
    }

}



@end
