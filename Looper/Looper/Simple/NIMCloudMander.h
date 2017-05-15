//
//  NIMCloudMander.h
//  Looper
//
//  Created by lujiawei on 26/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NIMSDK/NIMSDK.h>
@interface NIMCloudMander : NSObject <NIMChatManagerDelegate>
{
    
    


}


+(NIMCloudMander *)sharedManager;

-(void)initNIMSDK;
-(NSString*)getNIMSDkID;
-(void)sendMessage:(NSString*)str andType:(int)type andTargetId:(NSString*)targetId ;
-(void)loginNIMSDK:(NSString*)account andToken:(NSString*)token;
-(void)joinCharRoom:(NSObject*)object;
-(void)joinChatRoom:(NSString*)chatID andObject:(NSObject*)object;
-(void)fetchMessageHistory:(int)type andTargetId:(NSString*)targetID;
-(NSArray*)allRecentSessions;
-(NSMutableArray*)getSessionArray;


-(void)getUserData:(NSString*)targetId
           success:(void (^)(id responseObject))success;

@end
