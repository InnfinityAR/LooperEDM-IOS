//
//  SerachViewModel.h
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "looperView.h"
#import "looperDetailView.h"
#import "PlayerInfoView.h"
#import "looperChatView.h"


@interface looperViewModel : NSObject{
    
    id obj;
    looperView *looperV;
    PlayerInfoView *playerInfoV;
    looperDetailView *looperDetailV;
    looperChatView *looperCharV;
    BOOL isFollow;
    
    
}


-(id)initWithController:(id)controller;

-(void)initWithData:(NSDictionary*)loopData;



-(void)createPlayerView:(NSDictionary *)dicPlayer;

-(void)popController;
-(void)shareH5;
-(void)removePlayerInfo;
-(void)createLooperDeatail;
-(void)removeLooperDatail;
-(void)removeUserView;
-(void)addMusicListView;
-(void)removeMusicListView;
-(void)removeMusicView;
-(void)getThumbUpCount:(int)type andPage:(int)page;
-(void)jumpToAddMusicView;
-(void)pushController:(NSDictionary*)dic;
-(void)toMusicView:(int)indexLoop andIsPlay:(bool)isPlay;
-(void)addUserView;
-(void)followLoop;
-(void)unfollowLoop;
-(void)sendMessage:(NSString*)str andTarget:(NSString*)TargetId andReplyMessageId:(NSString*)replyMessageId andReplayMessageText:(NSString*)replyText;
-(void)ReceiveMessage:(NSDictionary*)data;

-(void)addPreferenceToCommentMessageId:(NSString*)messageId andlike:(int)islike andTarget:(NSString*)targetID andMessageText:(NSString*)messageText;
-(void)followUser:(NSString*)targetID;
-(void)unfollowUser:(NSString*)targetID;
-(void)parseMusic;
-(void)removeLoopChat;
-(void)createLooperChatV;
-(void)removeAction;
-(void)jumpToH5:(NSDictionary*)h5Data;
-(void)addToFavorite:(NSString*)musicId andisLike:(int)islike;

-(void)updataLoopMusic:(NSArray*)array;
-(void)updataArray:(NSArray *)removeArray;
-(void)updataMusicData:(NSDictionary*)dic andIndex:(int)indexPath;

-(void)frontMusic;
-(void)backMusic;
-(void)getLoopMusic:(int)type;

-(void)playMusicAtIndex:(int)index;


@property(nonatomic,strong)id obj;
@property(nonatomic,strong)looperView *looperV;
@property(nonatomic,strong)PlayerInfoView *playerInfoV;
@property(nonatomic,strong) looperDetailView *looperDetailV;
@property(nonatomic,strong) looperChatView *looperCharV;
@property(nonatomic)BOOL isFollow;


@end
