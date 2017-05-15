//
//  NIMCloudMander.m
//  Looper
//
//  Created by lujiawei on 26/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "NIMCloudMander.h"
#import <NIMSDK/NIMSDK.h>
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "looperViewModel.h"
#import "SimpleChatViewModel.h"
#import "LocalDataMangaer.h"


@implementation NIMCloudMander{
    
    NSObject* joinRoom;
    NSMutableArray *chatArray;
    NSMutableDictionary *userData;
    NSMutableArray *sessionArray;
    
}

static NIMCloudMander *NIMCloudManderM=nil;

+(NIMCloudMander *)sharedManager{
    if(NIMCloudManderM==nil){
        NIMCloudManderM=[[NIMCloudMander alloc]init];
    }
    return NIMCloudManderM;
}

-(void)initNIMSDK{
    userData = [[NSMutableDictionary alloc] initWithCapacity:50];
    [[NIMSDK sharedSDK] registerWithAppID:@"f6830962858b70e845f6ef1fe084d299"
                                  cerName:@"looperEdm"];
    [self loginNIMSDK:[LocalDataMangaer sharedManager].uid andToken:[LocalDataMangaer sharedManager].tokenStr];
    [self registerAPNs];
}


- (void)registerAPNs
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}

-(NSMutableArray*)getSessionArray{
    return sessionArray;

}

-(void)loginNIMSDK:(NSString*)account andToken:(NSString*)token{
    
    [[[NIMSDK sharedSDK] loginManager] login:account
                                       token:token
                                  completion:^(NSError *error) {
                                      [[[NIMSDK sharedSDK] chatManager] addDelegate:self];
                                      sessionArray=[[NSMutableArray alloc]initWithArray:[self allRecentSessions]];
                                  }];
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


-(void)joinChatRoom:(NSString*)chatID andObject:(NSObject*)object{

    joinRoom = object;
    
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:[NIMSDK sharedSDK].loginManager.currentAccount];
    NIMChatroomEnterRequest *request = [[NIMChatroomEnterRequest alloc] init];
    request.roomId =chatID;
    request.roomNickname = user.userInfo.nickName;
    request.roomAvatar = user.userInfo.avatarUrl;
    
    [[[NIMSDK sharedSDK] chatroomManager] enterChatroom:request
                                             completion:^(NSError *error,NIMChatroom *chatroom,NIMChatroomMember *me) {
                                                 
                                             }];
}



- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{

    
    for (NIMMessage *message in messages) {
        if (message.session.sessionType == NIMSessionTypeChatroom ||message.session.sessionType == NIMSessionTypeP2P)
        {
            
            
        if(message.text!=nil){
            
            [self getUserData:message.from success:^(id responseObject){
            
                NSMutableDictionary *senderDic = [[NSMutableDictionary alloc] initWithCapacity:50];
                [senderDic setObject:message.text forKey:@"text"];
                [senderDic setObject:message.session.sessionId forKey:@"targetId"];
                [senderDic setObject:message.messageId forKey:@"messageId"];
                [senderDic setObject:message.from forKey:@"senderUserId"];
                [senderDic setObject:[responseObject objectForKey:@"nickname"] forKey:@"name"];
                [senderDic setObject:[responseObject objectForKey:@"headimageurl"] forKey:@"HeadImageUrl"];
                [senderDic setObject:[[NSNumber alloc] initWithLong: message.timestamp] forKey:@"sentTime"];
                
                [(looperViewModel*)joinRoom ReceiveMessage:senderDic];
            }];
            }
        }
    }
}

- (void)sendMessage:(NIMMessage *)message
didCompleteWithError:(nullable NSError *)error{

    if(error==nil){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:message.from forKey:@"userId"];
        [dic setObject:message.from forKey:@"targetId"];
        
        
        
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getUserInfo" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                if(message.text!=nil){
                    NSMutableDictionary *senderDic = [[NSMutableDictionary alloc] initWithCapacity:50];
                    [senderDic setObject:message.text forKey:@"text"];
                    [senderDic setObject:message.session.sessionId forKey:@"targetId"];
                    [senderDic setObject:message.messageId forKey:@"messageId"];
                    [senderDic setObject:message.from forKey:@"senderUserId"];
                    [senderDic setObject:[responseObject[@"data"]objectForKey:@"nickname"] forKey:@"name"];
                    [senderDic setObject:[responseObject[@"data"]objectForKey:@"headimageurl"] forKey:@"HeadImageUrl"];
                    [senderDic setObject:[[NSNumber alloc] initWithLong: message.timestamp] forKey:@"sentTime"];
                    
                    
                    [(looperViewModel*)joinRoom ReceiveMessage:senderDic];
                }
            }else{
                
            }
        }fail:^{
            
        }];
    }
}

//- (NSArray<NIMRecentSession *> *)allRecentSessions



-(NSArray*)allRecentSessions{

    return [[NIMSDK sharedSDK].conversationManager allRecentSessions];
}







-(void)fetchMessageHistory:(int)type andTargetId:(NSString*)targetID{
    [chatArray removeAllObjects];
    chatArray =[[NSMutableArray alloc] initWithCapacity:50];
    
    NIMSession *session;
    if(type==0){
        session = [NIMSession session:targetID type:NIMSessionTypeP2P];
    }else if(type==1){
        session = [NIMSession session:targetID type:NIMSessionTypeChatroom];
    }

    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]);
    
    [self getUserData:targetID success:^(id responseObject){
    
        
        NIMHistoryMessageSearchOption *option = [[NIMHistoryMessageSearchOption alloc] init];
        option.startTime = nowDate-86400;
        option.limit = 100;
        
        [[NIMSDK sharedSDK].conversationManager fetchMessageHistory:session option:option result:^(NSError *error, NSArray *messages) {
            
            
            for(int i =0;i<[messages count];i++){
                NIMMessage*  message = [messages objectAtIndex:i];
                if(message.text!=nil){
                
                NSMutableDictionary *senderDic = [[NSMutableDictionary alloc] initWithCapacity:50];
                [senderDic setObject:message.text forKey:@"text"];
                [senderDic setObject:message.session.sessionId forKey:@"targetId"];
                [senderDic setObject:message.messageId forKey:@"messageId"];
                [senderDic setObject:message.from forKey:@"senderUserId"];
                
                if([message.from isEqualToString:targetID]){
                    [senderDic setObject:[responseObject objectForKey:@"nickname"] forKey:@"name"];
                    [senderDic setObject:[responseObject objectForKey:@"headimageurl"] forKey:@"HeadImageUrl"];
                }else if([message.from isEqualToString:[LocalDataMangaer sharedManager].uid]){
                    [senderDic setObject:[LocalDataMangaer sharedManager].NickName forKey:@"name"];
                    [senderDic setObject:[LocalDataMangaer sharedManager].HeadImageUrl forKey:@"HeadImageUrl"];
                }
                [senderDic setObject:[[NSNumber alloc] initWithLong: message.timestamp] forKey:@"sentTime"];
                [chatArray addObject:senderDic];
                [self checkHistory:i andMaxCount:[messages count]-1];
                }
            }
            
        }];

        
        
    }];

}


-(void)checkHistory:(int)index andMaxCount:(int)count{
    if(count==index){
        NSLog(@"%@",chatArray);
        [(SimpleChatViewModel*)joinRoom ReceiveMessageArray:chatArray];
    
    }
}





-(void)sendMessage:(NSString*)str andType:(int)type andTargetId:(NSString*)targetId {
    NIMMessage *message = [[NIMMessage alloc] init];
    message.text = str;
    
    
    
    //构造会话
    NIMSession *session;
    if(type==0){
        session = [NIMSession session:targetId type:NIMSessionTypeP2P];
    }else if(type==1){
        session = [NIMSession session:targetId type:NIMSessionTypeChatroom];
    }
    //发送消息
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
    
    
    
    
}


-(NSString*)getNIMSDkID{
    
    NSString *userID = [NIMSDK sharedSDK].loginManager.currentAccount;

    return userID;
}







@end
