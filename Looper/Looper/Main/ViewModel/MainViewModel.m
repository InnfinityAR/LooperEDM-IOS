//
//  MainViewModel.m
//  Looper
//
//  Created by lujiawei on 12/11/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "MainViewModel.h"
#import "MainViewController.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import "SelectLooperView.h"
#import "ActivityLayer.h"
#import "HomeViewController.h"
#import "SerachViewController.h"
#import "looperViewController.h"
#import "HudView.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"
#import "HowToPlayView.h"
#import "messageViewController.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>

#import "Base64Class.h"
#import "RongCloudManger.h"
#import "MeFootPrintView.h"

#import "nMainView.h"
#import "DataHander.h"

#import "UserInfoView.h"
#import "commonTableView.h"
#import "LooperListViewController.h"
#import "SettingViewController.h"
#import "SimpleChatViewController.h"
#import "CreateLoopController.h"
#import "ActivityViewController.h"
#import "nActivityViewController.h"
#import "FamilyViewController.h"
#import "MallViewController.h"

#import "PlayerInfoView.h"
#import "HowToPlayView.h"
#import "UserInfoViewController.h"
#import "LiveShowView.h"

#import "JPUSHService.h"

#import "AliManagerData.h"
#import "TicketDetailView.h"
#import "PlayVideoView.h"

#import "ExtractPriceViewController.h"

@implementation MainViewModel{


    NSMutableArray *loopList;
    
    NSMutableArray *typesList;
    
    NSMutableArray *mapData;
    
    int checkXposition;
    
    int checkYposition;
    
    commonTableView *commonTable;
    
    NSArray *SessionArray;
    
    
    UIImageView *bkv ;
    
    
    LiveShowView *liveShowV;
    
    nActivityViewController *activity;
    
    NSString *_activityId;
    
    
    PlayerInfoView *_playerInfoV;
    
    MeFootPrintView *meFootPrint;
    
//award
  NSArray * rouletteArr;
}
@synthesize musicData = _musicData;
@synthesize MainData = _mainData;
@synthesize mainV = _mainV;
@synthesize selectV = _selectV;
@synthesize activityV = _activityV;
@synthesize hudV = _hudV;
@synthesize createLoopV = _createLoopV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (MainViewController*)controller;
        self.VMNumber=0;
        [self createBackView];
        [self requestData];
    }
    return  self;
}


-(void)createBackView{
    bkv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    UIImage *imageV= [UIImage imageNamed:@"640-2.png"];
    bkv.image =imageV;
    [[_obj view] addSubview:bkv];
}


-(void)getRouletteUser{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getHeartBeat" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            [LocalDataMangaer sharedManager].tokenStr =responseObject[@"user"][@"sdkid"];
            [LocalDataMangaer sharedManager].NickName =responseObject[@"user"][@"nickname"];
            [LocalDataMangaer sharedManager].sex =responseObject[@"user"][@"sex"];
            [LocalDataMangaer sharedManager].age =responseObject[@"user"][@"age"];
            [[LocalDataMangaer sharedManager] setData];
            [_mainV updataView:responseObject[@"user"]];
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)getSessionArray{
  //  SessionArray = [[NSArray alloc] initWithArray:[[NIMCloudMander sharedManager] allRecentSessions]];
}


-(void)getUserLoopList{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyLoops" parameters:dic success:^(id responseObject){
        
        loopList = [[NSMutableArray alloc] initWithArray:responseObject[@"data"]];
        
        if(_mainV!=nil){
            [self removeSelectLoopV];
            [self createLoopViewList];
        }else{
        
            [self initView];
        }
    }fail:^{
        
    }];
}


-(void)removePlayerInfo{
    
    [_playerInfoV removeFromSuperview];
    
}

-(void)jumpToAddUserInfoVC:(NSString *)userID{
    UserInfoViewController *userVC=[[UserInfoViewController alloc]init];
    userVC.userID=userID;
    [[self.obj navigationController]pushViewController:userVC animated:NO];
}


-(void)pushController:(NSDictionary*)dic{
    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:dic];
    [[_obj navigationController]  pushViewController:simpleC animated:NO];
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


-(void)createPlayerView:(int)PlayerId{
    
    if(PlayerId!=[[LocalDataMangaer sharedManager].uid intValue]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
        [dic setObject:[NSString stringWithFormat:@"%d",PlayerId] forKey:@"targetId"];
        
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


-(void)checkMapIsUse:(CGPoint)point{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.x] forKey:@"xPosition"];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.y] forKey:@"yPosition"];
    checkXposition = (int)point.x;
    checkYposition = (int)point.y;
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"checkLoopPosition" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            [self getTitleList];
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)getTitleList{
    NSDictionary *dic = [[NSDictionary alloc] init];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopTitles" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            typesList =[[NSMutableArray alloc] initWithArray:responseObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:@selector(createLoopView:) withObject:typesList afterDelay:0.1];
            });
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)updateMap{
    
    if(_mainV!=nil){
        
        //[_mainV requestMapData:CGPointMake(1,1)];
    }
}

-(void)getAreaMapList:(CGPoint)point{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.x] forKey:@"xPosition"];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.y] forKey:@"yPosition"];
    [dic setObject:[[NSNumber alloc] initWithFloat:100] forKey:@"range"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopByCoordinates" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            mapData = responseObject[@"data"];
            //[_mainV responeseMapData:mapData];

             
        }else{

        }
    }fail:^{
        
    }];
}


-(void)requestgetMyFavorite{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyFavorite" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            _musicData = responseObject[@"data"];
           
            if(_mainV ==nil){
                [self initView];
                
                
                [UIView animateWithDuration:1.5 animations:^{
                
                    bkv.alpha=0;
                }];
            }else{
                [_mainV updataView:[[_mainData objectForKey:@"data"] objectForKey:@"User"]];
                
                [commonTable updataView];
                
            }

        }
    }fail:^{
        
    }];
    
}

-(void)checkLoopName:(NSString*)loopName{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:loopName forKey:@"name"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopByCoordinates" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
           
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)updataMessage{

    
    [[RongCloudManger sharedManager] getConversationList];

}



-(void)requestData{
  
     NSTimer*time = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updataMessage) userInfo:nil repeats:YES];
    
    
    //[[NIMCloudMander sharedManager] initNIMSDK];
    [self requestMainData];

}

-(void)getRouletteResult{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];

    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRouletteResult" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
        
            NSLog(@"%@",responseObject);
        }
    }fail:^{
        
    }];
}

-(void)requestMainData{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    if ([JPUSHService registrationID] !=nil) {
        [dic setObject:[JPUSHService registrationID] forKey:@"registrationid"];
    }

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getHome" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSLog(@"%@",responseObject);
            _mainData = [[NSDictionary alloc] initWithDictionary:responseObject];
            
            [LocalDataMangaer sharedManager].rouletteArr=[responseObject[@"data"]objectForKey:@"roulette"];
            [self requestgetMyFavorite];

            //[self getRouletteResult];

            [LocalDataMangaer sharedManager].tokenStr =responseObject[@"data"][@"User"][@"sdkid"];
            [LocalDataMangaer sharedManager].NickName =responseObject[@"data"][@"User"][@"nickname"];
            [LocalDataMangaer sharedManager].sex =responseObject[@"data"][@"User"][@"sex"];
            [LocalDataMangaer sharedManager].age =responseObject[@"data"][@"User"][@"age"];
            [LocalDataMangaer sharedManager].creditNum =responseObject[@"data"][@"User"][@"credit"];
            if (responseObject[@"data"][@"raverid"]!=[NSNull null]&&responseObject[@"data"][@"raverid"]!=nil) {
                [LocalDataMangaer sharedManager].raverid=responseObject[@"data"][@"raverid"];
                 [LocalDataMangaer sharedManager].role=responseObject[@"data"][@"role"];
            }
            [[LocalDataMangaer sharedManager] setData];
            [[RongCloudManger sharedManager] initRongCloudSDK];
            [[RongCloudManger sharedManager]loginRCSdk];
            [self.expDic setObject:responseObject[@"data"][@"User"][@"level"] forKey:@"level"];
            [self.expDic setObject:responseObject[@"data"][@"User"][@"nextlevel"] forKey:@"nextlevel"];
            [self.expDic setObject:responseObject[@"data"][@"User"][@"exp"] forKey:@"exp"];
        }else{
            
        }
    }fail:^{
        
    }];
}
-(NSMutableDictionary *)expDic{
    if (!_expDic) {
        _expDic=[[NSMutableDictionary alloc]init];
    }
    return _expDic;
}
-(void)createLoopView:(NSMutableArray*)array{
    _createLoopV = [[CreateLoopView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andArray:array];
    [[_obj view] addSubview:_createLoopV];

}

-(void)createSerachView{
    
    SerachViewController *serachV = [[SerachViewController alloc] init];
   // serachV.startPoint = CGPointMake(40*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5);
   // serachV.bubbleColor = [UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0];
  // [_obj presentViewController:serachV animated:YES completion:nil];
    [[_obj navigationController]  pushViewController:serachV animated:YES];
}




-(void)JumpLooperView:(NSDictionary*)loopData{

    looperViewController *looperV = [[looperViewController alloc] init];

    [looperV initWithData:loopData];
    
    [[_obj navigationController]  pushViewController:looperV animated:NO];

}

-(void)pushControllerToUser:(NSDictionary*)dic{
    
    
    if([[dic objectForKey:@"userid"] isEqualToString:[LocalDataMangaer sharedManager].uid]!=true){
        
        SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
        [simpleC chatTargetID:dic];
        // [_obj presentViewController:simpleC animated:NO completion:nil];
        
        [[_obj navigationController]  pushViewController:simpleC animated:YES];
        
    }else{
        [[DataHander sharedDataHander] showViewWithStr:@"不能和自己聊天" andTime:2 andPos:CGPointZero];
        
    }

    
    
  
}

-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [_obj presentModalViewController:picker animated:YES];
}


-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [_obj presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* MyImage = [[UIImage alloc]init];
        
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        //NSData *imageData = UIImagePNGRepresentation(image);
        
        MyImage=[LooperToolClass set_imageWithImage:image ToPoint:CGPointMake(0, 0)  scaledToSize:CGSizeMake(400 * DEF_Adaptation_Font, 400 * DEF_Adaptation_Font)];
         NSData * data = [LooperToolClass set_ImageData_UIImageJPEGRepresentationWithImage:MyImage CGFloat_compressionQuality:0.5];
 
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateString = [formatter stringFromDate:[NSDate date]];
        dateString = [NSString stringWithFormat:@"%@.png",dateString];
        NSString* filePath = [[NSString alloc]initWithFormat:@"%@/%@",DocumentsPath,dateString];
        [fileManager removeItemAtPath:filePath error:nil];
        
        [fileManager createFileAtPath:filePath contents:data attributes:nil];
        [_createLoopV updataHeadView:filePath];
          [picker dismissViewControllerAnimated:YES completion:^(void){}];
        }
}


-(void)removeSelectLoopV{
    
    [_selectV removeCollocationV];
    [_selectV removeFromSuperview];
   
    _selectV = nil;

}


-(void)removelooperSelect{

    [_selectV removeFromSuperview];
}


-(void)pushHomeController{

    HomeViewController *home = [[HomeViewController alloc] init];
    [[_obj navigationController]  pushViewController:home animated:YES];


}

-(void)pushLooperListController{
    LooperListViewController *looperListVC= [[LooperListViewController alloc] init];
    looperListVC.startPoint = CGPointMake(217*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5);
    looperListVC.bubbleColor = [UIColor colorWithRed:37/255.0 green:31/255.0 blue:43/255.0 alpha:1.0];
     [[_obj navigationController]  pushViewController:looperListVC animated:YES];
    //[_obj presentViewController:looperListVC animated:YES completion:nil];
}

-(void)createMessageController{

    messageViewController *messageVc = [[messageViewController alloc] init];
//    [_obj presentViewController:messageVc animated:YES completion:nil];

      [[_obj navigationController]  pushViewController:messageVc animated:YES];
}

-(void)pushActivityViewController{
    ActivityViewController *activity = [[ActivityViewController alloc] init];
     [[_obj navigationController]  pushViewController:activity animated:YES];

}

-(void)pushNActivityViewController{
    nActivityViewController *activity = [[nActivityViewController alloc] initWithOrderArr: [LocalDataMangaer sharedManager].rouletteArr];
    [[_obj navigationController]  pushViewController:activity animated:YES];
    
}

-(void)createActivityView:(NSString*)activityId{
    
    _activityId = activityId;
    
    activity = [[nActivityViewController alloc] initWithOrderArr: [LocalDataMangaer sharedManager].rouletteArr];
    
    [[_obj navigationController]  pushViewController:activity animated:YES];
    
    [self performSelector:@selector(showActivityView) withObject:nil afterDelay:0.1];
}

-(void)showActivityView{
    [activity jumpToActivityId:_activityId];
}



-(void)createFamilyViewController{
    
    FamilyViewController *familyVc =[[FamilyViewController alloc] init];
    [[_obj navigationController]  pushViewController:familyVc animated:YES];
    


}

-(void)hudOnClick:(int)type{
    if (type==55000) {
        
      //  MallViewController *mallVc = [[MallViewController alloc] init];
     //   [[_obj navigationController]  pushViewController:mallVc animated:YES];
        
       // ExtractPriceViewController *extractVC=[[ExtractPriceViewController alloc]init];
       // [[_obj navigationController]  pushViewController:extractVC animated:YES];
    }
    if(type==LopperBtnTag){
        [self pushNActivityViewController];
    }else if(type==HomeBtnTag){
        [self performSelector:@selector(pushHomeController) withObject:nil afterDelay:0.3];
    }else if(type==9008){
       [self pushActivityViewController];
    }else if(type==ActiveBtnTag){
   
        [self pushNActivityViewController];


      //  [self createFamilyViewController];
       //[[DataHander sharedDataHander] showViewWithStr:@"coming soon" andTime:1 andPos:CGPointZero];

//      [self pushLooperListController];
    }else if(type==DJBtnTag){
        [self pushActivityViewController];
        
    }else if(type==SearchBtnTag){
        [self createSerachView];
    }else if(type==ActivityBackBtnTag){
        [_activityV removeFromSuperview];
    }else if(type==ActivityFollowBtnTag){
        
    }else if(type==ActivityLikeBtnTag){

        
    }else if(type==createLoopBackTag){
        [_createLoopV removeFromSuperview];
        
    }else if(type==103){
        //设置按钮
        [self jumpToSettingC];
        
    }else if(type==104){
        //消息信箱
        [self createMessageController];
        
    }else if(type==8001){
        //关注
        [self createCommonView:1];
        
    }else if(type==8002){
        //粉丝
        [self createCommonView:2];
        
    }else if(type==8003){
        //喜欢的音乐
        [self createCommonView:4];
        
    }else if(type==8004){
        //我的loop
        [self createCommonView:3];
        
    }
    else if(type==8008){
#warning 在这里写入订票详情
        [self getMyOrderFromHttp];
    }
    
    else if(type==8007){

        liveShowV = [[LiveShowView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self and:[[_mainData objectForKey:@"data" ]objectForKey:@"OfflineActivity"]];
        [[_obj view] addSubview:liveShowV];
    }else if (type==8009){
        [self getMyFootPrint];
        
        
        
        
        
    }else if(type==ActivityShareBtnTag){
        
        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
            NSString* thumbURL =  @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"looper" descr:@"looper" thumImage:thumbURL];
            //设置网页地址
            shareObject.webpageUrl = @"www.baidu.com";
            
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
}



-(void)getMyFootPrint{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyFootPrint" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSLog(@"%@",responseObject);
            
            
            if(meFootPrint==nil){
                meFootPrint =[[MeFootPrintView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
                [[_obj view] addSubview:meFootPrint];
                [meFootPrint updataCollectionData:responseObject[@"data"]];
                
            }else{
                
                [meFootPrint updataCollectionData:responseObject[@"data"]];
            }

        }else{
            
        }
    }fail:^{
        
    }];
    
}

-(void)playNetWorkVideo:(NSString*)videoUrl{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    PlayVideoView *playVideoV  = [[PlayVideoView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andUrlStr:videoUrl];
    [[_obj view] addSubview:playVideoV];
    
}

-(void)requestCreateLoop:(NSDictionary*)dicData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[dicData objectForKey:@"loopName"] forKey:@"name"];
    [dic setObject:[dicData objectForKey:@"selectType"] forKey:@"type"];
    [dic setObject:[dicData objectForKey:@"content"] forKey:@"description"];
    [dic setObject:[[NSNumber alloc] initWithInt:checkXposition] forKey:@"coordinateX"];
    [dic setObject:[[NSNumber alloc] initWithInt:checkYposition] forKey:@"coordinateY"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    UIImage *image = [UIImage imageNamed:[dicData objectForKey:@"head"]];
    NSData *imageData = UIImagePNGRepresentation(image);
    [dic setObject:[Base64Class encodeBase64Data:imageData] forKey:@"photo"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createLoop" parameters:dic success:^(id responseObject){
        [_createLoopV removeFromSuperview];
        if([responseObject[@"status"] intValue]==0){
             // [_mainV addLoopWithData:responseObject[@"data"]];
            
            [loopList addObject:responseObject[@"data"]];    
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)removeCommonView{

    [commonTable removeFromSuperview];
    

}


-(void)createCommonView:(int)type{
    commonTable=[[commonTableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self and:type];
    [[_obj view] addSubview:commonTable];

}


-(void)mapToPostition:(CGPoint)point{
    
    [_selectV removeFromSuperview];
   // [_mainV moveMap:point];
}



-(void)mainHudView{

    _hudV= [[HudView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
      _hudV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_hudV];
}


-(void)createActivityView{

    _activityV = [[ActivityLayer alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [_activityV initViewWithData:nil];
    [[_obj view] addSubview:_activityV];
}


-(void)createLoopViewList{

    _selectV = [[SelectLooperView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [_selectV initViewWithArray:loopList];
    [[_obj view] addSubview:_selectV];
}

-(void)moveLoopPos:(NSNotification*)notification{

    NSDictionary *messageDictionary = [notification object];
    NSDictionary* looperData = messageDictionary[@"data"];

    [self mapToPostition:CGPointMake([[looperData objectForKey:@"CoordinateX"] floatValue], [[looperData objectForKey:@"CoordinateY"] floatValue])];

}

-(void)toCreateLooperView{
    
    CreateLoopController *createLoop = [[CreateLoopController alloc] init];
    [[_obj navigationController]  pushViewController:createLoop animated:NO];
    
}


-(void)jumpToSettingC{
    SettingViewController *settingVc = [[SettingViewController alloc] init];
    [[_obj navigationController]  pushViewController:settingVc animated:YES];
}


-(void)initView{

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(getRouletteUser) userInfo:nil repeats:true];
    
    
    
    _mainV = [[nMainView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _mainV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_mainV];
    
    
    HowToPlayView *howToPlayV = [[HowToPlayView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:howToPlayV];
    [howToPlayV intoSceenViewType:1];
    
    
}

//获取我的历史订单
-(void)getMyOrderFromHttp{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyOrder" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            if ([responseObject[@"data"]count]!=0) {
            self.orderArr=responseObject[@"data"];
            TicketDetailView *ticketDetailV = [[TicketDetailView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andMyData:self.orderArr andType:1];
            [[_obj view] addSubview:ticketDetailV];
            }
            if ([responseObject[@"commodity"]count]!=0) {
                self.orderArr=responseObject[@"commodity"];
                TicketDetailView *ticketDetailV = [[TicketDetailView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andMyData:self.orderArr andType:2];
                [[_obj view] addSubview:ticketDetailV];
            }
        }else{
            
        }
    }fail:^{
        
    }];
    
    
}

-(void)thumbBoardMessage:(NSString*)boardId andLike:(int)isLike{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:boardId forKey:@"boardId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[NSString stringWithFormat:@"%d",isLike] forKey:@"like"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"thumbBoardMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            //  [self getImageBoard:_activityId];
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)sendImageBoardMessage:(NSString*)boardId andMessageText:(NSString*)message{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
     [dic setObject:boardId forKey:@"boardId"];
     [dic setObject:message forKey:@"messageText"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendImageBoardMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
           
            
            [self getMyFootPrint];
            
        }else{
            
        }
    }fail:^{
        
    }];
    
    
}

-(void)removeMeFootView{
    
    
    meFootPrint = nil;
    
    
}





-(void)getKuaiDi100FromHttp:(NSString *)com andNu:(NSString *)nu{
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//     [dic setObject:@"29833628d495d7a5" forKey:@"id"];
//    if (com!=nil) {
//          [dic setObject:com forKey:@"com"];
//    }
//    if (nu!=nil) {
//         [dic setObject:nu forKey:@"nu"];
//    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //com    string    是    需要查询的快递公司编号     no    string    是    需要查询的订单号
    NSString* url =[NSString stringWithFormat:@"http://api.kuaidi100.com/api?id=29833628d495d7a5&com=%@&nu=%@&show=0&muti=1&order=desc",com,nu];
//   NSString *url= @"http://api.kuaidi100.com/api?id=29833628d495d7a5&show=0&muti=1&order=desc";
    [manager POST:url parameters:nil constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"status"]integerValue]==1) {
            [self.tickLoginV updataTableView:[responseObject objectForKey:@"data"]];
        }else{
         [[DataHander sharedDataHander] showViewWithStr:[responseObject objectForKey:@"message"] andTime:2 andPos:CGPointZero];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
}];
    
}


@end
