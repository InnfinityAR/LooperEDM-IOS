//
//  SaleTicketViewModel.m
//  Looper
//
//  Created by 工作 on 2017/8/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SaleTicketViewModel.h"
#import "SaleTicketView.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "DataHander.h"
#import "TicketLogisticsView.h"
#import "LooperConfig.h"
#import "AliManagerData.h"
#import "TicketPayView.h"
@interface SaleTicketViewModel()
@property(nonatomic,strong)SaleTicketView *saleTicketV;
@property(nonatomic,strong)TicketPayView *ticketPayView;
@end
@implementation SaleTicketViewModel
-(id)initWithController:(id)controller{
    if (self=[super init]) {
        self.obj=(SaleTicketController *)controller;
    }
    return self;
}
-(void)getDataFromHTTP:(NSDictionary *)dataDic orderDic:(NSDictionary *)orderDic andPrice:(NSInteger)price{
//    if (price>0) {
//    self.saleTicketV=[[SaleTicketView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH([self.obj view]) , DEF_HEIGHT([self.obj view])) and:self andDataDic:dataDic orderDic:orderDic];
//    [[self.obj view]addSubview:self.saleTicketV];
//    }else{
        self.ticketPayView=[[TicketPayView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH([self.obj view]) , DEF_HEIGHT([self.obj view])) and:self andDataDic:dataDic andPayNumber:1 andOrderDic:orderDic andTime:nil];
        [[self.obj view]addSubview:self.ticketPayView];
//    }
}
-(void)popViewController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
}

//获取当前的抽奖活动
-(void)getCurrentRouletteFromHTTP{
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getCurrentRoulette" parameters:nil success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
        }else{
          
        }
    }fail:^{
        
    }];


}

//创建支付订单
-(void)createOrderForProductId:(int)productId andresultid:(int)resultId andClientAddress:(NSString*)clientAddress andclientMobile:(NSString *)clientMobile anddelivery:(NSString *)delivery anddeliveryCode:(NSString *)deliveryCode andPayNumber:(NSInteger)payNumber andclientName:(NSString *)clientName andPrice:(NSInteger)price{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@(productId) forKey:@"productId"];
    [dic setObject:@(resultId) forKey:@"resultId"];
    [dic setObject:clientAddress forKey:@"clientAddress"];
    [dic setObject:clientMobile forKey:@"clientMobile"];
    [dic setObject:delivery  forKey:@"delivery"];
    [dic setObject:deliveryCode forKey:@"deliveryCode"];
    [dic setObject:@(payNumber) forKey:@"number"];
    [dic setObject:clientName forKey:@"clientName"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createOrder" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSDictionary *dataDic=responseObject[@"data"];
            if ([[dataDic objectForKey:@"price"]intValue]>0) {
#warning-跳转到支付宝界面
                [self getMyOrderFromHttp];
                 [AliManagerData doAlipayPay:responseObject[@"data"]];
            }else{
                [self changeOrderStatusForOrderId:[dataDic objectForKey:@"orderid"] ProductId:[dataDic objectForKey:@"productid"]];
            }
        }else{
            
        }
    }fail:^{
        
    }];
}
-(void)changeOrderStatusForOrderId:(NSString *)orderId ProductId:(NSString*)productId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@([orderId intValue]) forKey:@"orderId"];
    [dic setObject:@([productId intValue]) forKey:@"productId"];
    [dic setObject:@(1) forKey:@"status"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"changeOrderStatus" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
             [self getMyOrderFromHttp];
            
        }else{
             [[DataHander sharedDataHander] showViewWithStr:@"您填写的地址信息错误" andTime:1 andPos:CGPointZero];
        }
    }fail:^{
        
    }];
}
//发送验证码
-(void)requestDataCode:(NSString*)mobileNum{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:mobileNum forKey:@"mobile"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendVerificationCode" parameters:dic  success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if([responseObject[@"status"] intValue]==1){
         [[DataHander sharedDataHander] showViewWithStr:responseObject[@"message"]andTime:1 andPos:CGPointZero];
        }
    }fail:^{
        
    }];
}
//验证验证码
-(void)checkVerificationCodeForvCode:(NSString *)vCode ProductId:(int)productId andresultid:(int)resultId andClientAddress:(NSString*)clientAddress andclientMobile:(NSString *)clientMobile anddelivery:(NSString *)delivery anddeliveryCode:(NSString *)deliveryCode andPayNumber:(NSInteger)payNumber  andclientName:(NSString *)clientName andPrice:(NSInteger)price{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:clientMobile forKey:@"mobile"];
    [dic setObject:vCode forKey:@"vCode"];
//    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"checkVerificationCode" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            [self createOrderForProductId:productId andresultid:resultId andClientAddress:clientAddress andclientMobile:clientMobile anddelivery:delivery anddeliveryCode:deliveryCode andPayNumber:payNumber andclientName:clientName andPrice:price];
        }else{
             [[DataHander sharedDataHander] showViewWithStr:@"手机号或验证码错误" andTime:1 andPos:CGPointZero];
        }
    }fail:^{
        [[DataHander sharedDataHander] showViewWithStr:@"手机号或验证码错误" andTime:1 andPos:CGPointZero];
    }];
    
    
}

-(void)getMyOrderFromHttp{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyOrder" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSArray *orderArr=(NSArray*)responseObject[@"data"];
            TicketLogisticsView *ticketView=[[TicketLogisticsView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH([self.obj view]) , DEF_HEIGHT([self.obj view])) and:nil andMyData:orderArr[orderArr.count-1]];
            [ticketView setTicketVC:self.obj];
            [[self.obj view] addSubview:ticketView];
            
        }else{
            
        }
    }fail:^{
        
    }];
    
    
}
@end
