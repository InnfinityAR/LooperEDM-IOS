//
//  SerachViewModel.m
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "looperViewModel.h"
#import "looperViewController.h"
#import "LooperConfig.h"
#import "PlayerInfoView.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
#import "RongCloudManger.h"
#import "DataHander.h"
#import "looperDetailView.h"
#import "HowToPlayView.h"
#import "WebViewController.h"
#import "MusicPlayView.h"
#import "SimpleChatViewController.h"
#import "UserListView.h"
#import "MusicListManage.h"
#import "addMusicController.h"
#import "UserInfoViewController.h"

@implementation looperViewModel{


    NSMutableDictionary *looperData;
    NSMutableDictionary *chatData;
    UserListView *userListV;
    MusicListManage *musicListV;
    MusicPlayView *musicV;
    NSArray *musicArray;
    
    addMusicController *addMusicCV;
    
    NSMutableDictionary *targetDic;

    
    int createUserNum;
    
    int playIndex;

}

@synthesize obj = _obj;
@synthesize looperV = _looperV;
@synthesize playerInfoV = _playerInfoV;
@synthesize looperDetailV = _looperDetailV;
@synthesize looperCharV = _looperCharV;
@synthesize isFollow = _isFollow;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (looperViewController*)controller;

        
    }
    return  self;
}



-(void)playMusicAtIndex:(int)index{
    playIndex= index;

    [_looperV playMusicAtIndex:index];
    [musicListV selectCellIndex:index];
    
    
    NSDictionary *dic = [musicArray objectAtIndex:playIndex];
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [tempDic setObject:[dic objectForKey:@"filename"] forKey:@"musicTitle"];
    [tempDic setObject:[dic objectForKey:@"music_cover"] forKey:@"photoUrl"];
    [tempDic setObject:[dic objectForKey:@"artist"] forKey:@"artist"];

   [_obj playMusicForBackgroundWithMusicInfo:tempDic];
}



-(void)updataArray:(NSArray *)removeArray{
    
    NSMutableArray *loopMusicArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    for (int i=0;i<[[looperData objectForKey:@"Music"] count];i++){
        [loopMusicArray addObject:[[[looperData objectForKey:@"Music"] objectAtIndex:i] objectForKey:@"fileid"]];
    }
    for(int i=0;i<[loopMusicArray count];i++){
        for (int j=0;j<[removeArray count];j++){
            if([[loopMusicArray objectAtIndex:i] isEqualToString:[removeArray objectAtIndex:j]]==true){
            
                [loopMusicArray removeObjectAtIndex:i];
                
            }
        }
    }
    [self updataLoopMusic:loopMusicArray];
}




-(void)updataLoopMusic:(NSArray*)array{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"] forKey:@"loopId"];
    [dic setObject:array forKey:@"fileIds"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"deleteAndUpdateMusics" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            [looperData setObject:responseObject[@"Music"] forKey:@"Music"];
            [musicListV updataLoad:responseObject[@"Music"]];
            musicArray =[[NSMutableArray alloc] initWithArray:responseObject[@"Music"]];
            [_looperV updataData:looperData andType:1];
            
        }else{
            
        }
    }fail:^{
        
    }];

}



-(void)removeLoopChat{

    [_looperCharV removeFromSuperview];

}


-(void)createLooperChatV{
    _looperCharV = [[looperChatView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [_looperCharV initWithData:chatData andLooperData:looperData];
    [[_obj view] addSubview:_looperCharV];
}

-(void)initWithData:(NSDictionary*)loopData{
    
    targetDic = [[NSMutableDictionary alloc] initWithCapacity:50];
    chatData = [[NSMutableDictionary alloc] initWithCapacity:50];
    
    [self getLoopDetailsByID:[loopData objectForKey:@"n_id"]];
    
}


-(void)removeLooperDatail{
    [_looperDetailV removeFromSuperview];
}


-(void)createLooperDeatail{

    _looperDetailV = [[looperDetailView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];

    [_looperDetailV initViewData:looperData];
      [[_obj view] addSubview:_looperDetailV];
}


-(void)removePlayerInfo{
    _looperV.userInteractionEnabled=true;
    [_playerInfoV removeFromSuperview];

}

-(void)pushController:(NSDictionary*)dic{
    createUserNum = 1;
    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:dic];
     [[_obj navigationController]  pushViewController:simpleC animated:NO];

}

-(void)createPlayerView:(NSDictionary *)dicPlayer{
    
    if([dicPlayer[@"userid"]intValue]!=[[LocalDataMangaer sharedManager].uid intValue]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
        [dic setObject:dicPlayer[@"userid"] forKey:@"targetId"];
        
        _looperV.userInteractionEnabled=false;
        _playerInfoV = [[PlayerInfoView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        _playerInfoV.userInteractionEnabled=true;
        _playerInfoV.multipleTouchEnabled=true;
        [[_obj view] addSubview:_playerInfoV];
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getUserInfo" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                [_playerInfoV initWithlooperData:responseObject[@"data"] andisFollow:[responseObject[@"isFollow"] intValue]];
            }else{
                
            }
        }fail:^{
            
        }];
    }
    
}


-(void)sendMessage:(NSString*)messageId andMessageText:(NSString*)MessageText andTimestamp:(NSString*)TimeStamp andData:(NSDictionary*)data{
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]);

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:messageId forKey:@"messageId"];
    [dic setObject:MessageText forKey:@"messageText"];
    [dic setObject:[NSString stringWithFormat:@"%ld",nowDate] forKey:@"timestamp"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"] forKey:@"loopId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendYunXinMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
                 [self getLoopMessage:1 and:100];
        }else{
            
        }
    }fail:^{
        
    }];

}

-(void)loopLeaveAction{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]);
    [dic setObject:[NSString stringWithFormat:@"%ld",nowDate] forKey:@"timestamp"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[looperData objectForKey:@"LoopID"] forKey:@"loopId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"leaveLoop" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            
        }else{
            
        }
    }fail:^{
        
    }];
}

-(void)ReceiveMessage:(NSDictionary*)data{
    
    if([[[looperData objectForKey:@"Loop"] objectForKey:@"loop_sdkid"]intValue]==[[data objectForKey:@"targetId"]intValue]){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if([[data objectForKey:@"senderUserId"] intValue ]==[[LocalDataMangaer sharedManager].uid intValue]){

                if([targetDic objectForKey:[data objectForKey:@"text"]]!=nil){
                    NSDictionary *dic = [targetDic objectForKey:[data objectForKey:@"text"]];
                        [self sendMessageReply:[dic objectForKey:@"targetID"]
                                       andType:1
                                  andMessageId:[data objectForKey:@"messageId"]
                                andMessageText:[data objectForKey:@"text"]
                            andTargetMessageId:[dic objectForKey:@"replyMessageId"]
                          andTargetMessageText:[dic objectForKey:@"replyText"]];

                }else{
                      [self sendMessage:[data objectForKey:@"messageId"] andMessageText:[data objectForKey:@"text"] andTimestamp:[data objectForKey:@"sentTime"] andData:data];
                }
            }
            [_looperV ReceiveMessage:1 andData:data];
        });
    }

}


-(void)sendMessage:(NSString*)str andTarget:(NSString*)TargetId andReplyMessageId:(NSString*)replyMessageId andReplayMessageText:(NSString*)replyText{
    
   // [[NIMCloudMander sharedManager] sendMessage:str andType:1 andTargetId:[[looperData objectForKey:@"Loop"] objectForKey:@"loop_sdkid"]];
    
    
    if(TargetId!=nil){
        NSMutableDictionary  *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:TargetId forKey:@"targetID"];
        [dic setObject:replyMessageId forKey:@"replyMessageId"];
        [dic setObject:replyText forKey:@"replyText"];
        [targetDic setObject:dic forKey:str];
        
    }
    [[RongCloudManger sharedManager] sendMessage:str andType:1 andTargetId:[[looperData objectForKey:@"Loop"] objectForKey:@"loop_sdkid"] andRealTarget:TargetId andReplyMessageId:replyMessageId andReplyMessageText:replyText];

}


-(void)getLoopDetailsByID:(NSString*)looperID{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:looperID forKey:@"loopId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopById" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            createUserNum = 0;
            
            [[RongCloudManger sharedManager] joinCharRoom:self];

            looperData =  [[NSMutableDictionary alloc] initWithDictionary:responseObject] ;
             musicArray =[[NSMutableArray alloc] initWithArray:responseObject[@"Music"]];
            
            _looperV = [[looperView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
            [_looperV initViewWith:looperData];
            [[_obj view] addSubview:_looperV];
            
            [self getLoopMessage:1 and:100];
            
            HowToPlayView *howToPlayV = [[HowToPlayView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
            [[_obj view] addSubview:howToPlayV];
            [howToPlayV intoSceenViewType:3];

        }else{
             [[_obj navigationController] popViewControllerAnimated:YES];
        }
    }fail:^{
        
    }];
}


-(void)followLoop{
 
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"] forKey:@"loopId"];
    [dic setObject:[[looperData objectForKey:@"Owner"] objectForKey:@"userid"] forKey:@"targetId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"followLoop" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            _isFollow = true;
             [[DataHander sharedDataHander] showView:@"followSucceed.png" andTime:1 andPos:CGPointMake(141*DEF_Adaptation_Font_x*0.5, 431*DEF_Adaptation_Font*0.5)];
            [_looperV updatefollow];
            
        }else{
            
        }
    }fail:^{
        
    }];
}

-(void)unfollowLoop{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"] forKey:@"loopId"];
    [dic setObject:[[looperData objectForKey:@"Owner"] objectForKey:@"userid"] forKey:@"targetId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"unfollowLoop" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            _isFollow = false;
               [[DataHander sharedDataHander] showView:@"unfollowSucceed.png" andTime:1 andPos:CGPointMake(141*DEF_Adaptation_Font_x*0.5, 431*DEF_Adaptation_Font*0.5)];
                  [_looperV updatefollow];
            
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)jumpToH5:(NSDictionary*)h5Data{
    WebViewController *webVc = [[WebViewController alloc] init];
    [webVc webViewWithData:h5Data andObj:self];
    [[_obj navigationController] pushViewController:webVc animated:NO];
}


-(void)getLoopMusic:(int)type{
    
    if(createUserNum!=1){

        if(looperData!=nil){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
            [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"] forKey:@"loopId"];
            [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopMusic" parameters:dic success:^(id responseObject){
                if([responseObject[@"status"] intValue]==0){
                    
                    [looperData setObject:responseObject[@"Music"] forKey:@"Music"];
                    
                    [_looperV updataData:looperData andType:type];

                    [musicListV updataLoad:responseObject[@"Music"]];
                    
                     musicArray =[[NSMutableArray alloc] initWithArray:responseObject[@"Music"]];
                }else{
                    
                }
            }fail:^{
                
            }];
        }
    }
    createUserNum=0;
}




-(void)unfollowUser:(NSString*)targetID{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:targetID forKey:@"targetId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"unfollowUser" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)followUser:(NSString*)targetID{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:targetID forKey:@"targetId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"followUser" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
        }else{
             
        }
    }fail:^{
        
    }];
}



-(void)removeAction{
    if(_looperV!=nil){
        [_looperV removeMusic];
    }
    
    
    if(_looperCharV!=nil){
       
        [_looperCharV removeAction];

    }
}


-(void)addToFavorite:(NSString*)musicId andisLike:(int)islike{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:musicId forKey:@"fileId"];
    [dic setObject:[[NSNumber alloc] initWithInt:islike] forKey:@"like"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"addToFavorite" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            [self getLoopMusic:2];
            
            
        }else{
            
        }
    }fail:^{
        
    }];


}


-(void)getLoopMessage:(int)page and:(int)pageSize{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"] forKey:@"loopId"];
    [dic setObject:[[NSNumber alloc] initWithInt:page] forKey:@"page"];
    [dic setObject:[[NSNumber alloc] initWithInt:pageSize] forKey:@"pageSize"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            chatData =responseObject;
            
            if(_looperV!=nil){
                [_looperV FeaturedUpdata:chatData];
            }
            if(_looperCharV!=nil){
                
                  [_looperCharV updataChatDic:chatData];
            }
        }else{
            
        }
    }fail:^{
        
    }];

}


-(void)pushMessage:(NSString*)message andTarget:(NSString*)TargetId{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:TargetId forKey:@"targetId"];
    [dic setObject:message forKey:@"content"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"pushMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
  
        
        }else{
            
        }
    }fail:^{
        
    }];

}



-(void)toMusicView:(int)indexLoop andIsPlay:(bool)isPlay{
    
    if([[looperData objectForKey:@"Music"] count]!=0){
        musicV = [[MusicPlayView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andlooperData:looperData isPlay:isPlay];
        [musicV createHudView:indexLoop andisPlay:isPlay];
        [[_obj view]addSubview:musicV];
        
        playIndex =indexLoop;
    }

}

-(void)addUserView{
    userListV = [[UserListView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andUserData:[looperData objectForKey:@"Fans"]];
    [[_obj view]addSubview:userListV];
}

-(void)addMusicListView{
    musicListV = [[MusicListManage alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andLooperData:looperData];
     [[_obj view]addSubview:musicListV];
    [musicListV selectCellIndex:playIndex];
    
}

-(void)addChatView{
    
    
}

-(void)updataMusicData:(NSDictionary*)dic andIndex:(int)indexPath{
    [musicV updataWithMusic:dic and:indexPath];
    
    playIndex = indexPath;
    
    if(playIndex==nil){
    
        playIndex=0;
    }
    
    if([musicArray count]!=0){
        NSDictionary *musicDic = [musicArray objectAtIndex:playIndex];
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [tempDic setObject:[musicDic objectForKey:@"filename"] forKey:@"musicTitle"];
        [tempDic setObject:[musicDic objectForKey:@"music_cover"] forKey:@"photoUrl"];
        [tempDic setObject:[musicDic objectForKey:@"artist"] forKey:@"artist"];
        [_obj playMusicForBackgroundWithMusicInfo:tempDic];

        
    }
    
    
   
}



-(void)parseMusic{

    [_looperV stopMusic];
}

-(void)frontMusic{
    
   playIndex= [_looperV playMusicFront];
    NSDictionary *musicDic = [musicArray objectAtIndex:playIndex];
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [tempDic setObject:[musicDic objectForKey:@"filename"] forKey:@"musicTitle"];
    [tempDic setObject:[musicDic objectForKey:@"music_cover"] forKey:@"photoUrl"];
    [tempDic setObject:[musicDic objectForKey:@"artist"] forKey:@"artist"];
    
     [_obj playMusicForBackgroundWithMusicInfo:tempDic];
}

-(void)backMusic{
   playIndex= [_looperV playMusicNext];
    NSDictionary *musicDic = [musicArray objectAtIndex:playIndex];
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [tempDic setObject:[musicDic objectForKey:@"filename"] forKey:@"musicTitle"];
    [tempDic setObject:[musicDic objectForKey:@"music_cover"] forKey:@"photoUrl"];
    [tempDic setObject:[musicDic objectForKey:@"artist"] forKey:@"artist"];
    
    [_obj playMusicForBackgroundWithMusicInfo:tempDic];
    
    
    
}


-(void)removeMusicView{
    [musicV removeFromSuperview];
}

-(void)removeUserView{
    [userListV removeFromSuperview];
}

-(void)removeMusicListView{

    [musicListV removeFromSuperview];
}


-(void)jumpToAddMusicView{
    
    addMusicCV = [[addMusicController alloc] init];
    [addMusicCV initWithLoopId:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"]];
   // [_obj presentViewController:addMusicCV animated:NO completion:nil];
    
     [[_obj navigationController]  pushViewController:addMusicCV animated:NO];
    
}

-(void)changeMusicOrder{

    
}


-(void)addPreferenceToCommentMessageId:(NSString*)messageId andlike:(int)islike andTarget:(NSString*)targetID andMessageText:(NSString*)messageText {
    
    
    if(islike==1){
        [[DataHander sharedDataHander] showView:@"goodSucceed.png" andTime:1 andPos:CGPointMake(141*DEF_Adaptation_Font_x*0.5, 431*DEF_Adaptation_Font*0.5)];
    }else{
        
    
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"] forKey:@"loopId"];
    [dic setObject:messageId forKey:@"targetMessageId"];
    [dic setObject:targetID forKey:@"targetId"];
    [dic setObject:@(islike) forKey:@"like"];
    [dic setObject:messageText forKey:@"targetMessageText"];
    NSLog(@"开始push：%@",dic);
       [AFNetworkTool Clarnece_Post_JSONWithUrl:@"addPreferenceToComment" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
             [self getLoopMessage:1 and:100];
        }else{
            
        }
    }fail:^{
        
    }];
   
}



-(void)sendMessageReply:(NSString*)targetID
                andType:(int)type
           andMessageId:(NSString*)messageid
           andMessageText:(NSString*)messageText
     andTargetMessageId:(NSString*)TargetMessageId
   andTargetMessageText:(NSString*)targetMessageText{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"]forKey:@"loopId"];
    [dic setObject:targetID forKey:@"targetId"];
    [dic setObject:messageid forKey:@"messageId"];
    [dic setObject:messageText forKey:@"messageText"];
    [dic setObject:[[NSNumber alloc] initWithInt:type] forKey:@"type"];  //3
    [dic setObject:TargetMessageId forKey:@"targetMessageId"];
    [dic setObject:targetMessageText forKey:@"targetMessageText"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
             [self getLoopMessage:1 and:100];
            
          //  [self pushMessage:messageText andTarget:[LocalDataMangaer sharedManager].uid];
            
        }else{
            
        }
    }fail:^{
        
    }];

}


-(void)shareH5
{
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        NSString* thumbURL = @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
        
       
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"我在 %@ 快上车", [[looperData objectForKey:@"Loop"] objectForKey:@"looptitle"]] descr:@"相聚loop 共享乐事" thumImage:thumbURL];
        //设置网页地址
        
        if([looperData objectForKey:@"ContentURL"]!=nil){
            shareObject.webpageUrl = [looperData objectForKey:@"ContentURL"];
        }else{
            NSString *h5Url = @"http://www.innfinityar.com?share.php&loopid=";
            shareObject.webpageUrl  = [NSString stringWithFormat:@"%@%@",h5Url,[[looperData objectForKey:@"Loop"] objectForKey:@"loopid"]];
        }

        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            
        }];
    }];

}

-(void)popController{
    
    [_obj dismissViewControllerAnimated:YES completion:nil];
    
    [[_obj navigationController] popViewControllerAnimated:YES];
    
}

//跳转到userInfo界面
-(void)jumpToAddUserInfoVC:(NSString *)userID{
    UserInfoViewController *userVC=[[UserInfoViewController alloc]init];
    userVC.userID=userID;
    [[self.obj navigationController]pushViewController:userVC animated:NO];
}
@end


