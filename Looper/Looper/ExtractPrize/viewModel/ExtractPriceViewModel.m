//
//  ExtractPriceViewModel.m
//  Looper
//
//  Created by 工作 on 2017/8/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ExtractPriceViewModel.h"
#import "ExtractPriceViewController.h"
#import "ExtractPriceView.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import "SaleTicketController.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
#import "DataHander.h"
@interface ExtractPriceViewModel()
@property(nonatomic,strong)ExtractPriceView *extractView;

@end
@implementation ExtractPriceViewModel
-(instancetype)initWithController:(id)controller{
    if (self=[super init]) {
        self.obj=(ExtractPriceViewController *)controller;
    }
    return self;
}
-(void)updateView{
   self.extractView=[[ExtractPriceView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH([self.obj view]) , DEF_HEIGHT([self.obj view])) and:self];
    self.extractView.backgroundColor=[UIColor whiteColor];
    [[self.obj view]addSubview:self.extractView];
}
//获取商品详情
-(void)getRouletteProductForproductId:(NSInteger)productId andResultId:(NSInteger)resultId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@(productId) forKey:@"productId"];
//    [dic setObject:@(resultId) forKey:@"resultId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getProduct" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSDictionary *orderDic=responseObject[@"data"];
            NSMutableDictionary *dataDic=[NSMutableDictionary dictionary];
            [dataDic setObject:[orderDic objectForKey:@"starttime"] forKey:@"starttime"];
             [dataDic setObject:[orderDic objectForKey:@"endtime"] forKey:@"endtime"];
            if ([orderDic objectForKey:@"location"]==nil||[orderDic objectForKey:@"location"]==[NSNull null]) {
                 [dataDic setObject:@"默认地址" forKey:@"location"];
            }else{
             [dataDic setObject:[orderDic objectForKey:@"location"] forKey:@"location"];
            }
             if ([orderDic objectForKey:@"roulettename"]==nil||[orderDic objectForKey:@"roulettename"]==[NSNull null]) {
                  [dataDic setObject:@"640-2.png" forKey:@"photo"];
             }else{
              [dataDic setObject:[orderDic objectForKey:@"coverimage"] forKey:@"photo"];
             }
            if ([orderDic objectForKey:@"roulettename"]==nil||[orderDic objectForKey:@"roulettename"]==[NSNull null]) {
                [[DataHander sharedDataHander] showViewWithStr:@"当前数据错误" andTime:1 andPos:CGPointZero];
            }else{
                [dataDic setObject:[orderDic objectForKey:@"roulettename"] forKey:@"activityname"];
                [self jumpToSaleTicketController:dataDic andOrderDic:orderDic andResultId:resultId];
            }
            
        }else{
            
        }
    }fail:^{
        
    }];
}
-(void)popViewController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
}

-(void)jumpToSaleTicketController:(NSDictionary *)dataDic andOrderDic:(NSDictionary*)orderDic andResultId:(NSInteger)resultId{
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithDictionary:orderDic];
     NSInteger price=[[orderDic objectForKey:@"price"]integerValue];
    [dictionary setObject:@(resultId) forKey:@"resultId"];
    if ([[orderDic objectForKey:@"price"]integerValue]>0) {
     [dictionary setObject:@(0) forKey:@"isPrice"];
    }
    orderDic=[dictionary copy];
#warning-如果要传递一个界面，需要加入这个
//    if ([[orderDic objectForKey:@"price"]integerValue]>0) {
//        NSArray *array=@[dictionary];
//        orderDic=@{@"roulette":array};
//    }
    SaleTicketController *saleTicketVC=[[SaleTicketController alloc]initWithDataDic:dataDic orderDic:orderDic andPrice:price];
    [[self.obj navigationController]pushViewController:saleTicketVC animated:YES];
}

-(void)shareh5View:(NSDictionary*)webDic{
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
         NSString* thumbURL =[webDic objectForKey:@"photo"];
//        NSString* thumbURL = @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: [webDic objectForKey:@"activityname"] descr:@"LOOPER想带你一起去Ultra China！快来参加活动吧！"  thumImage:thumbURL];
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

-(void)removeActivityAction{
    [self.extractView removeActivityAction];
}

@end
