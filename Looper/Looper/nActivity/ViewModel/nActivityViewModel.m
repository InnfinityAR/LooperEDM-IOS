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
@implementation nActivityViewModel{

    NSMutableArray *allActivityArray;
    
    NSMutableArray *recommendArray;
    
}

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (nActivityViewController*)controller;
        [self requestData];
    }
    return  self;

}

-(void)popController{

   [[_obj navigationController] popViewControllerAnimated:NO];

}

-(void)addActivityDetailView:(NSDictionary*)Dic{

    ActivityDetailView *activityDetailV =[[ActivityDetailView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];;
    [[_obj view] addSubview:activityDetailV];



}
//跳转到购票
-(void)addTicket:(NSDictionary *)dic{
    TicketCiew *ticketView=[[TicketCiew alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andDic:dic];
    [[_obj view]addSubview:ticketView];
}

-(void)shareh5View:(NSDictionary*)webDic{

        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
            NSString* thumbURL =[webDic objectForKey:@"photo"];
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: [webDic objectForKey:@"activityname"] descr:@"基友在哪？！快来帮我赢取免费轰趴吧！"  thumImage:thumbURL];
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





-(void)requestData{
    allActivityArray = [[NSMutableArray alloc] initWithCapacity:50];
    recommendArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformation" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            for (int i=0;i<[responseObject[@"data"] count];i++){
                NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[responseObject[@"data"] objectAtIndex:i]];
                if([[dic objectForKey:@"recommendation"] intValue]==1){
                    [recommendArray addObject:dic];
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

    nActivityView *activityV= [[nActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andArray:recommendArray];
    [[_obj view] addSubview:activityV];
    

}

-(void)jumpToCurrentActivity:(NSArray*)array{
    CurrentActivityView *view=[[CurrentActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) andObj:self  andMyData:array];
                               [[_obj view]addSubview:view];
}


@end
