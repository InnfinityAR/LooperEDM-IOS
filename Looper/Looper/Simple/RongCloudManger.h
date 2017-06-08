//
//  RongCloudManger.h
//  Looper
//
//  Created by lujiawei on 1/13/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMLib/RongIMLib.h>

@interface RongCloudManger : NSObject <RCIMClientReceiveMessageDelegate>
{




}


+(RongCloudManger *)sharedManager;
-(void)joinCharRoom:(NSObject*)object;
-(void)initRongCloudSDK;
-(void)loginRCSdk;
-(void)sendMessage:(NSString*)MessageStr andType:(int)typeNum andTargetId:(NSString*)targetId andRealTarget:(NSString*)realTargetId andReplyMessageId:(NSString*)replyMessID andReplyMessageText:(NSString*)replyMessageText;
-(void)getRomotoHistoryMessage:(int)typeNum andTargetId:(NSString*)targetId andRecordTime:(long)recordTime andMessageCount:(int)Count;

-(NSArray*)getConversationList;
-(NSMutableArray*)getSessionArray;


-(void)getUserData:(NSString*)targetId
           success:(void (^)(id responseObject))success;

@end
