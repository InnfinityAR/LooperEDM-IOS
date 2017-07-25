//
//  ActivityViewModel.h
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityView.h"
#import "sendMessageActivityView.h"
#import "ActivityBarrageView.h"
#import "barrageReplyView.h"
@class sendMessageActivityView;
@class ActivityView;
typedef void(^CompletionHandle)(NSError *error);
@interface ActivityViewModel : NSObject

@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic)NSInteger refreshNumber;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)ActivityView *activityV;
@property(nonatomic,strong)sendMessageActivityView *sendView;
@property(nonatomic,strong)id barrageView;
@property(nonatomic,strong)id replyView;
@property(nonatomic,strong)NSArray *barrageArr;
@property(nonatomic)BOOL isReplyV;
@property(nonatomic)BOOL commendForReply;
//用于@某某某
@property(nonatomic,strong)NSString *sendPerson;
//获取更多
- (void)getMoreDataForCollectionView;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取数据
-(void)pustDataForSomeString:(NSString *)string;

//陆兄style
-(id)initWithController:(id)controller;
-(void)popController;
-(void)dataForH5:(NSDictionary *)dic;
-(void)shareH5:(NSDictionary*)dic;

-(void)sendActivityMessage:(NSString *)activityId and:(NSString*)message and:(NSArray*)images;
-(void)getActivityInfoById:(NSString *)activityId  andUserId:(NSString *)userId  andPage:(NSInteger)page andSize:(NSInteger)size;
-(void)thumbActivityMessage:(NSString*)like andUserId:(NSString*)userId andMessageId:(NSString*)messageID andActivityID:(NSString *)activityID  andCommendForReply:(BOOL)isReply;

-(void)LocalPhoto;
-(void)jumpToAddUserInfoVC:(NSString *)userID;
-(void)requestData;

-(void)createPhotoWallController:(NSString*)activityId;

-(void)pustDataForActivityID:(NSInteger)activityID andMessageID:(NSInteger)messageID  andContent:(NSString *)content andUserID:(NSNumber *)userID andIndex:(NSInteger)index andIsReplyView:(BOOL)isReplyV andSendPerson:(NSString *)sendPerson;

-(void)getReplyDataForMessageID:(NSInteger)messageID andIndex:(NSInteger)index;
//为评论回复点赞
-(void)thumbActivityMessageLike:(NSNumber*)like andUserId:(NSString*)userId andReplyID:(NSString*)replyID MessageID:(NSInteger)messageID andIndex:(NSInteger)index andIsReplyView:(BOOL)isReplyV;
@end
