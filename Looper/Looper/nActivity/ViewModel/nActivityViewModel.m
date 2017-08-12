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

#import "ClubDetailView.h"
#import "BrandDetailView.h"

@implementation nActivityViewModel{

    NSMutableArray *allActivityArray;
    
    NSMutableArray *recommendArray;
    
    ActivityDetailView *activityDetailV;

    int _isPhoto;
    PlayerInfoView * _playerInfoV;
    
    CurrentActivityView *view;
    NSArray *orderArray;
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

   [[_obj navigationController] popViewControllerAnimated:NO];

}

-(void)setCalendarData{
    
    
    
    [activityDetailV setCalendar];

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

-(void)shareh5View:(NSDictionary*)webDic{

        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
           // NSString* thumbURL =[webDic objectForKey:@"photo"];
             NSString* thumbURL = @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: [webDic objectForKey:@"activityname"] descr:@"惊不惊喜？意不意外？别说了！来组团蹦一波吧！！"  thumImage:thumbURL];
            //设置网页地址
            shareObject.webpageUrl = [webDic objectForKey:@"htmlurl"];
            
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
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformation" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            for (int i=0;i<[responseObject[@"data"] count];i++){
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[responseObject[@"data"] objectAtIndex:i]];
//                if([[dic objectForKey:@"recommendation"] intValue]==1){
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
//                }
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
    [[_obj view]addSubview:view];
}

-(void)jumpToSaleTicketController:(NSDictionary *)dataDic orderDic:(NSDictionary *)orderDic{
    SaleTicketController *saleTicketVC=[[SaleTicketController alloc]initWithDataDic:dataDic orderDic:orderDic andPrice:1];
    [[self.obj navigationController]pushViewController:saleTicketVC animated:YES];
}
@end
