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
@implementation ExtractPriceViewModel
-(instancetype)initWithController:(id)controller{
    if (self=[super init]) {
        self.obj=(ExtractPriceViewController *)controller;
    }
    return self;
}
-(void)updateView{
    ExtractPriceView *extractView=[[ExtractPriceView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH([self.obj view]) , DEF_HEIGHT([self.obj view])) and:self];
    extractView.backgroundColor=[UIColor whiteColor];
    [[self.obj view]addSubview:extractView];
}
//获取商品详情
-(void)getRouletteProductForproductId:(NSInteger)productId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@(productId) forKey:@"productId"];
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
            [dataDic setObject:@"640-2.png" forKey:@"activityname"];
            }else{
             [dataDic setObject:[orderDic objectForKey:@"roulettename"] forKey:@"activityname"];
            }
             if ([orderDic objectForKey:@"roulettename"]==nil||[orderDic objectForKey:@"roulettename"]==[NSNull null]) {
                  [dataDic setObject:@"640-2.png" forKey:@"photo"];
             }else{
              [dataDic setObject:[orderDic objectForKey:@"coverimage"] forKey:@"photo"];
             }
            [self jumpToSaleTicketController:dataDic andOrderDic:orderDic];
        }else{
            
        }
    }fail:^{
        
    }];
}
-(void)popViewController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
}

-(void)jumpToSaleTicketController:(NSDictionary *)dataDic andOrderDic:(NSDictionary*)orderDic{
    if ([[orderDic objectForKey:@"price"]integerValue]>0) {
        NSArray *array=@[orderDic];
        orderDic=@{@"roulette":array};
    }
    SaleTicketController *saleTicketVC=[[SaleTicketController alloc]initWithDataDic:dataDic orderDic:orderDic andPrice:[[orderDic objectForKey:@"price"]integerValue]];
    [[self.obj navigationController]pushViewController:saleTicketVC animated:YES];
}
@end
