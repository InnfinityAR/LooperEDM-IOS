 //
//  nActivityViewModel.m
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nActivityViewModel.h"
#import "nActivityViewController.h"
#import "nActivityView.h"
#import "ActivityDetailView.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "ActivityDetailView.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
#import "CurrentActivityView.h"
#import "TicketCiew.h"
#import "looperViewController.h"
#import "GALActionOnCalendar.h"

#import "DataHander.h"
#import "UserInfoViewController.h"
#import "SimpleChatViewController.h"
#import "PhotoWallViewController.h"

#import "SaleTicketController.h"
#import "SDImageCache.h"
#import "ClubDetailView.h"
#import "BrandDetailView.h"
#import "UIImageView+WebCache.h"
#import "LocationManagerData.h"
#import "ActivitySerachView.h"
#import "PhotoWallViewController.h"

#import "FamilyOfficialView.h"

#import "Base64Class.h"
#import "LooperToolClass.h"
@implementation nActivityViewModel{

    NSMutableArray *allActivityArray;
    
    NSMutableArray *recommendArray;
    
    ActivityDetailView *activityDetailV;
    ActivitySerachView *activityView;

    int _isPhoto;
    PlayerInfoView * _playerInfoV;
    
    CurrentActivityView *view;
    NSArray *orderArray;
    TicketCiew *ticketV;
    NSInteger updatePhotoTag;
}

-(id)initWithController:(id)controller andOrderArr:(NSArray *)orderArr{
    if(self=[super init]){
        self.obj = (nActivityViewController*)controller;
        orderArray=orderArr;
        [self requestData];
    }
    return  self;

}

-(void)popController{

    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
   [[_obj navigationController] popViewControllerAnimated:NO];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

-(void)setCalendarData{
    
    [activityDetailV setCalendar];

}

-(void)addInformationToJoin:(NSString*)userId andActivityId:(NSString*)activityID andLike:(int)isLike{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:activityID forKey:@"activityId"];
    [dic setObject:[NSString stringWithFormat:@"%d",isLike] forKey:@"like"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"addInformationToJoin" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            
            
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)jumpToPhotoWall:(NSString*)activityID{
    
  
    PhotoWallViewController *photoWallVC=[[PhotoWallViewController alloc]init];
    [photoWallVC initWithActivityID:activityID];
    [[_obj navigationController]pushViewController:photoWallVC animated:NO];
    
    
}


-(void)savaCalendar:(NSDictionary*)dic{
    
    if([[dic objectForKey:@"issave"] intValue]==0){
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setAMSymbol:@"AM"];
        [dateFormatter setPMSymbol:@"PM"];
        [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mmaaa"];
        NSDate *date = [NSDate date];
        NSString * s = [dateFormatter stringFromDate:date];
        
        //开始时间(必须传)
        NSDate * startDate = [date dateByAddingTimeInterval:60 * 2];
        //结束时间(必须传)
        NSDate * endDate   = [date dateByAddingTimeInterval:60 * 5 * 24];
        
        float alarmFloat   = -500;
        NSString *eventTitle  = [dic objectForKey:@"activityname"];
        NSString *location = [dic objectForKey:@"city"];
        NSString *notes = @"";
        
        //isReminder 是否写入提醒事项
        [GALActionOnCalendar saveEventStartDate:[[NSDate alloc] initWithTimeIntervalSince1970:[[dic objectForKey:@"starttime"]doubleValue]]  endDate: [[NSDate alloc] initWithTimeIntervalSince1970:[[dic objectForKey:@"endtime"]doubleValue]] alarm:alarmFloat eventTitle:eventTitle location:location notes:notes andObj:self];
    }else{
        [[DataHander sharedDataHander] showViewWithStr:@"您之前已经成功添加过活动" andTime:1 andPos:CGPointZero];
    }
}


-(void)pushController:(NSDictionary*)dic{
    
    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:dic];
    [[_obj navigationController]  pushViewController:simpleC animated:NO];
    
}


-(void)getDataById:(NSString*)typeId andId:(NSString*)ID{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:typeId forKey:@"type"];
    [dic setObject:ID forKey:@"id"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getDjById" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            if([typeId intValue]==1){
                DJDetailView *djDetailV = [[DJDetailView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)and:self and:responseObject];
                [[_obj view]addSubview:djDetailV];
            }else if([typeId intValue]==2){
                ClubDetailView *clubDetailV = [[ClubDetailView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)and:self and:responseObject];
                [[_obj view]addSubview:clubDetailV];
            }else if([typeId intValue]==4){
                BrandDetailView *brandDetailV = [[BrandDetailView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)and:self and:responseObject];
                [[_obj view]addSubview:brandDetailV];
            }
        }else{
           
        }
    }fail:^{
        
    }];
}


-(void)createSerachView{
    
    activityView = [[ActivitySerachView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
  [[_obj view]addSubview:activityView];
    
    
}

-(void)searchOfflineInformation:(NSString*)serachStr{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:serachStr forKey:@"searchText"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"searchOfflineInformation" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            [activityView updateDataView:responseObject[@"data"]];
        }else{
            
            
        }
    }fail:^{
        
    }];
}



-(void)getNearbyOfflineInformation{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"200" forKey:@"distance"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.x) forKey:@"longitude"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.y) forKey:@"latitude"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getNearbyOfflineInformation" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSArray *array=responseObject[@"data"];
            NSMutableArray* temp=[[NSMutableArray alloc]init];
            for (int i=0; i<array.count; i++) {
                NSDictionary *activity=array[i];
                //当前时间的时间戳
                NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
                NSInteger timeNow =(long)[datenow timeIntervalSince1970];
                if (timeNow<=[activity[@"starttime"]integerValue]) {
                        [temp addObject:activity];
                }
            }
            NSArray *testArr = [temp sortedArrayWithOptions:NSSortStable usingComparator:
                                ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                                    int value1 = [[obj1 objectForKey:@"starttime"] intValue];
                                    int value2 = [[obj2 objectForKey:@"starttime"] intValue];
                                    if (value1 > value2) {
                                        return NSOrderedDescending;
                                    }else if (value1 == value2){
                                        return NSOrderedSame;
                                    }else{
                                        return NSOrderedAscending;
                                    }
                                }];
            
            view.nearArr=testArr;
            //城市默认为上海
            if (testArr.count==0) {
                [self getOfflineInformationByCity:@"上海"];
            }
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)getOfflineInformationByCity:(NSString*)cityName{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:cityName forKey:@"city"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformationByCity" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSArray *array=responseObject[@"data"];
            NSMutableArray* temp=[[NSMutableArray alloc]init];
            for (int i=0; i<array.count; i++) {
                NSDictionary *activity=array[i];
                //当前时间的时间戳
                NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
                NSInteger timeNow =(long)[datenow timeIntervalSince1970];
                if (timeNow<=[activity[@"starttime"]integerValue]) {
                    [temp addObject:activity];
                }
            }
            NSArray *testArr = [temp sortedArrayWithOptions:NSSortStable usingComparator:
                                ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                                    int value1 = [[obj1 objectForKey:@"starttime"] intValue];
                                    int value2 = [[obj2 objectForKey:@"starttime"] intValue];
                                    if (value1 > value2) {
                                        return NSOrderedDescending;
                                    }else if (value1 == value2){
                                        return NSOrderedSame;
                                    }else{
                                        return NSOrderedAscending;
                                    }
                                }];
            [view reloadTableDataWithNearArr:testArr];
        }else{
            
            
        }
    }fail:^{
        
    }];
}



-(void)getOfflineInformationCity{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformationCity" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSArray *dataArr=responseObject[@"data"];
            view.cityArr=dataArr;
        }else{
            
            
        }
    }fail:^{
        
    }];
}





-(void)addActivityDetailView:(NSDictionary*)ActivityDic andPhotoWall:(int)isPhoto{
    _isPhoto = isPhoto;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[ActivityDic objectForKey:@"activityid"] forKey:@"activityId"];
     [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformationDetial" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            if (isPhoto==1) {
                NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithDictionary: responseObject[@"data"]];
                [dictionary setObject:orderArray forKey:@"roulette"];
                activityDetailV =[[ActivityDetailView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andDetailDic:responseObject andActivityDic:dictionary];
                [[_obj view] addSubview:activityDetailV];
            }else{
            activityDetailV =[[ActivityDetailView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andDetailDic:responseObject andActivityDic:ActivityDic];
            [[_obj view] addSubview:activityDetailV];
            }

        }else{
            
            
        }
    }fail:^{
        
    }];

}

-(void)toLooperView:(NSDictionary*)looperData{
    
    looperViewController *looperV = [[looperViewController alloc] init];
    
    [looperV initWithData:looperData];
    
    [[_obj navigationController]  pushViewController:looperV animated:NO];
}
-(void)removeDetailView{
    
    
    // [activityDetailV removeFromSuperview];
    
//    if(_isPhoto==1){
//         [activityDetailV removeFromSuperview];
//         [[_obj navigationController]popViewControllerAnimated:true];
//        _isPhoto=0;
//    }else{
//         [activityDetailV removeFromSuperview];
//    
//    }
}

//跳转到购票
-(void)addTicket:(NSDictionary *)dic{
    TicketCiew *ticketView=[[TicketCiew alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andDic:dic];
    ticketV=ticketView;
    [[_obj view]addSubview:ticketView];

   
}
-(void)removePlayerInfo{
    [_playerInfoV removeFromSuperview];
    
}

-(void)jumpToAddUserInfoVC:(NSString *)userID{
    UserInfoViewController *userVC=[[UserInfoViewController alloc]init];
    userVC.userID=userID;
    [[self.obj navigationController]pushViewController:userVC animated:NO];
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



-(void)createPhotoWallController{
    PhotoWallViewController *photoWallVC=[[PhotoWallViewController alloc]init];
    [photoWallVC initWithActivityID:@"22222"];
    [[self.obj navigationController]pushViewController:photoWallVC animated:NO];
}



-(void)createPlayerView:(NSDictionary *)dicPlayer{
    
    if([dicPlayer[@"userid"]intValue]!=[[LocalDataMangaer sharedManager].uid intValue]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
        [dic setObject:dicPlayer[@"userid"] forKey:@"targetId"];
        
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

-(void)shareAllH5View{
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        // NSString* thumbURL =[webDic objectForKey:@"photo"];
        NSString* thumbURL = @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"【LOOPER】全国RAVE活动汇总" descr:@"你想知道的所有活动信息，在这里都能找到！"  thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl =  @"http://info.looper.pro";
        
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



-(void)shareh5View:(NSDictionary*)webDic{

        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
           // NSString* thumbURL =[webDic objectForKey:@"photo"];
             NSString* thumbURL = @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: [webDic objectForKey:@"activityname"] descr:@"活动即将开始，你还是一个人嘛？快来和LOOPER组团蹦迪吧！"  thumImage:thumbURL];
            //设置网页地址
            shareObject.webpageUrl =  [NSString stringWithFormat:@"http://info.looper.pro/actinfo.html?activityid=%@",[webDic objectForKey:@"activityid"]];
            
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

-(void)saveTrip{
    



}

-(void)followTrip{
    
    
    
    
}


-(void)sharetTicket:(NSDictionary*)ticketDic{
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象

        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[ticketDic objectForKey:@"name"] descr:@"请点击购票"  thumImage:nil];
        //设置网页地址
        shareObject.webpageUrl = [ticketDic objectForKey:@"htmlurl"];
        
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





-(void)addInformationToFollow:(NSString*)activityID andisLike:(NSString*)islike{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:activityID forKey:@"activityId"];
    [dic setObject:islike forKey:@"like"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"addInformationToFollow" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}



-(void)addInformationToFavorite:(NSString*)activityID andisLike:(NSString*)islike{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:activityID forKey:@"activityId"];
    [dic setObject:islike forKey:@"like"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"addInformationToFavorite" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            if([islike intValue]==1){
                [[DataHander sharedDataHander] showViewWithStr:@"收藏活动成功" andTime:1 andPos:CGPointZero];

            }else{
                [[DataHander sharedDataHander] showViewWithStr:@"取消活动成功" andTime:1 andPos:CGPointZero];
        }
        }else{
            
        }
    }fail:^{
        
    }];
}

-(void)followBrand:(NSString*)ID andisLike:(int)islike andType:(int)typeNum{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:ID forKey:@"id"];
    [dic setObject:[NSString stringWithFormat:@"%d",typeNum] forKey:@"type"];
    [dic setObject:[NSString stringWithFormat:@"%d",islike] forKey:@"like"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"followBrand" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            if(islike==1){
                 [[DataHander sharedDataHander] showViewWithStr:@"关注成功" andTime:1 andPos:CGPointZero];
            
            }else{
                [[DataHander sharedDataHander] showViewWithStr:@"取消成功" andTime:1 andPos:CGPointZero];
            }
            
        }else{
            
        }
    }fail:^{
        
    }];
}


-(long int)getTime:(NSString*)time{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:time];
    long int nowDate = (long int)([date timeIntervalSince1970]);
    return nowDate;
}



#warning-线下数据
-(void)requestData{
    
    allActivityArray = [[NSMutableArray alloc] initWithCapacity:50];
    recommendArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.x) forKey:@"longitude"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.y) forKey:@"latitude"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformation" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            for (int i=0;i<[responseObject[@"data"] count];i++){
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[responseObject[@"data"] objectAtIndex:i]];
                if([[dic objectForKey:@"recommendation"] intValue]==1){
                    NSDate *now= [NSDate date];
                    long int nowDate = (long int)([now timeIntervalSince1970]);

                    if([[dic objectForKey:@"endtime"] intValue]>nowDate){
//在这里加入活动中的奖品
                        NSMutableArray *rouletteArr=[[NSMutableArray alloc]init];
                        for (NSDictionary *roulette in orderArray) {
                            if ([[roulette objectForKey:@"activityid"]intValue]==[[dic objectForKey:@"activityid"]intValue]) {
                                [rouletteArr addObject:roulette];
                            }
                        }
                        [dic setValue:[rouletteArr copy] forKey:@"roulette"];
                        [recommendArray addObject:dic];
                    }
                }
                [allActivityArray addObject:dic];
            }
            [self createActivityView];
            
        }else{
            
        }
    }fail:^{
        
    }];
     
     
}

-(void)createActivityView{
    nActivityView *activityV= [[nActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andArray:recommendArray andAllArray:allActivityArray];
    [[_obj view] addSubview:activityV];

}

-(void)jumpToCurrentActivity:(NSArray*)array{
    
    [view removeFromSuperview];
    
    view=[[CurrentActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) andObj:self  andMyData:array];
    [self getNearbyOfflineInformation];
    [self getOfflineInformationCity];
    [[_obj view]addSubview:view];
}

-(void)jumpToSaleTicketController:(NSDictionary *)dataDic orderDic:(NSDictionary *)orderDic{
    SaleTicketController *saleTicketVC=[[SaleTicketController alloc]initWithDataDic:dataDic orderDic:orderDic andPrice:1];
    [[self.obj navigationController]pushViewController:saleTicketVC animated:YES];
}

-(void)removeActivityAction{
    if (ticketV!=nil) {
    [ticketV removeActivityAction];
    }
}
#pragma-----------------------------------------------------------------familyOfficial
//家族官方数据
-(void)getFamilyOfficialWithRaverId:(NSString *)raverId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (raverId!=nil&&[raverId isEqual:[NSNull null]]) {
          [dic setObject:raverId forKey:@"raverId"];
    }else{
    [dic setObject:[LocalDataMangaer sharedManager].raverid forKey:@"raverId"];
    }
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverHomePage" parameters:dic success:^(id responseObject){
        if ([responseObject[@"status"]integerValue]==0) {
            FamilyOfficialView *officialView=[[FamilyOfficialView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) andObj:self andDataDic:responseObject[@"data"] andFootprint:responseObject[@"footprint"] andAlbumn:responseObject[@"albumn"] andRole:[LocalDataMangaer sharedManager].role];
            [[_obj view]addSubview:officialView];
        }
    }fail:^{
        
    }];
}
//家族官网
-(void)createPhotoWallController:(NSString*)activityId{
    PhotoWallViewController *photoWallVC=[[PhotoWallViewController alloc]init];
    [photoWallVC initWithActivityID:activityId];
    [[self.obj navigationController]pushViewController:photoWallVC animated:NO];
}
-(void)followFamliyWithisLike:(int)islike andRaverId:(NSString *)raverId{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:raverId forKey:@"raverId"];
    [dic setObject:[NSString stringWithFormat:@"%d",islike] forKey:@"like"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"followRaver" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            if(islike==1){
                [[DataHander sharedDataHander] showViewWithStr:@"关注成功" andTime:1 andPos:CGPointZero];
            }else{
                [[DataHander sharedDataHander] showViewWithStr:@"取消成功" andTime:1 andPos:CGPointZero];
            }
        }else{
        }
    }fail:^{
    }];
}
-(void)uploadFamilyAlbumnWithImages:(NSArray *)images andRaverId:(NSString *)raverId{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:raverId forKey:@"raverId"];
    if (images!=nil&&images.count>0) {
//base64
        if(images!=nil){
            NSMutableArray *imageDataArray= [[NSMutableArray alloc] initWithCapacity:50];
            for (int i=0;i<[images count];i++){
                NSLog(@"%@",[images objectAtIndex:i]);
                UIImage *imagePhoto2 = [images objectAtIndex:i];
                NSData *imageDataP2 = UIImageJPEGRepresentation(imagePhoto2,0.1);
                [imageDataArray addObject:[Base64Class encodeBase64Data:imageDataP2]];
            }
            [dic setObject:imageDataArray forKey:@"images"];
        }
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"uploadRaverAlbumn" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            [self updateFamilyOfficialWithRaverId:raverId];
        }else{
          [[DataHander sharedDataHander] showViewWithStr:@"图片上传失败" andTime:1 andPos:CGPointZero];
        }
    }fail:^{
    }];
    }else{
       [[DataHander sharedDataHander] showViewWithStr:@"图片上传失败" andTime:1 andPos:CGPointZero];
    }
}
//更新家族官方数据
-(void)updateFamilyOfficialWithRaverId:(NSString *)raverId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:raverId forKey:@"raverId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverHomePage" parameters:dic success:^(id responseObject){
        if ([responseObject[@"status"]integerValue]==0) {
            [self.officialView updateCollectViewData:responseObject[@"albumn"]];
        }
    }fail:^{
        
    }];
}
-(void)deleteFamilyAlbumnWithImageId:(NSString *)imageid RaverId:(NSString *)raverId andUserId:(NSString *)userId{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:imageid forKey:@"imageId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"deleteRaverImage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
                [[DataHander sharedDataHander] showViewWithStr:@"删除成功" andTime:1 andPos:CGPointZero];
                [self updateFamilyOfficialWithRaverId:raverId];
        }else{
        }
    }fail:^{
    }];
}

#pragma updatePhoto
-(void)LocalPhotoWithTag:(NSInteger)tag
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    updatePhotoTag=tag;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [_obj presentModalViewController:picker animated:YES];
}


-(void)takePhotoWithTag:(NSInteger)tag
{
    updatePhotoTag=tag;
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
        
        MyImage=[LooperToolClass set_imageWithImage:image ToPoint:CGPointMake(0, 0)  scaledToSize:CGSizeMake(image.size.width, image.size.height)];
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
        if (updatePhotoTag==1) {
        [_officialView ImageFileSave:[UIImage imageNamed:filePath]];
        }else if(updatePhotoTag==2){
#pragma-修改familyOfficialV头视图,同时向涛哥返回数据
            [_officialView changeHeaderViewWIthImage:[UIImage imageNamed:filePath]];
             [[DataHander sharedDataHander] showViewWithStr:@"封面修改成功" andTime:1 andPos:CGPointZero];
        }
        [picker dismissViewControllerAnimated:YES completion:^(void){}];
    }
}
-(void)updateRaverImageWithRaverId:(NSString *)raverId andImage:(UIImage *)image{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:raverId forKey:@"raverId"];
        //base64
        if(image!=nil){
            NSData *imageDataP2 = UIImageJPEGRepresentation(image,0.1);
            NSString *path=[Base64Class encodeBase64Data:imageDataP2];
            [dic setObject:path forKey:@"image"];
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"updateRaverImage" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
               
            }else{
                [[DataHander sharedDataHander] showViewWithStr:@"更换封面失败" andTime:1 andPos:CGPointZero];
            }
        }fail:^{
        }];
    }else{
        [[DataHander sharedDataHander] showViewWithStr:@"更换封面失败" andTime:1 andPos:CGPointZero];
    }
    
}
#pragma -SearchView
-(id)initWithController:(id)controller andActivityDic:(NSDictionary *)dataDic andType:(NSInteger)type{
    if(self=[super init]){
        self.obj = (nActivityViewController*)controller;
        if (type==1) {
        [self jumpToActivityDetailView:dataDic];
        }else if(type==2){
            [self jumpToDJViewWithDJId:[dataDic objectForKey:@"djid"]];
        }
    }
    return  self;
}
-(void)jumpToActivityDetailView:(NSDictionary*)ActivityDic{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[ActivityDic objectForKey:@"activityid"] forKey:@"activityId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformationDetial" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            activityDetailV =[[ActivityDetailView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andDetailDic:responseObject andActivityDic:ActivityDic];
            activityDetailV.isFromSearchView=YES;
            [[_obj view] addSubview:activityDetailV];
        }else{
        }
    }fail:^{
    }];
}
-(void)jumpToDJViewWithDJId:(NSString*)ID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:ID forKey:@"id"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getDjById" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
                DJDetailView *djDetailV = [[DJDetailView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)and:self and:responseObject];
            djDetailV.isFromSearchView=YES;
                [[_obj view]addSubview:djDetailV];
        }
    }fail:^{
    }];
}

@end
