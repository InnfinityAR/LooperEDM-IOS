//
//  MallViewModel.m
//  Looper
//
//  Created by lujiawei on 07/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MallViewModel.h"
#import "MallViewController.h"
#import "MallMainView.h"
#import "LocalDataMangaer.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "ShoppingDetailView.h"
#import "DataHander.h"
#import "LooperConfig.h"

#import "LooperToolClass.h"
#import "integrateDetailView.h"
#import "LocalDataMangaer.h"
#import "DataHander.h"
#import "AliManagerData.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

#import "MallPayView.h"
#import "ShoppingArgumentView.h"

@implementation MallViewModel{
    
    
    NSMutableDictionary *mallData;
    MallMainView *mallMainV;
    ShoppingDetailView *detailV;

    AVPlayer*_player;
    AVPlayerLayer* playerLayer;
    
    
    UIView *backV;
    

    MallPayView *mallPayV;
    ShoppingArgumentView *argumentV;

}

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (MallViewController*)controller;
        [self requestData];
        
    }
    return  self;
    
}

-(void)popViewMallController{
    
    
    [mallMainV removeFromSuperview];
    [[_obj navigationController]  popViewControllerAnimated:true];
    
    
}


-(void)getCreditHistory{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getCreditHistory" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            integrateDetailView *integrateView =[[integrateDetailView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)  and:nil];
              [[self.obj view]addSubview:integrateView];

           
        }
    }fail:^{
        
    }];
}


-(void)onClickBackV{
    
    
    [_player pause];
    [_player setRate:0];
    [backV removeFromSuperview];
   
    
}



-(void)dailyCheckIn{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"dailyCheckin" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
         
            if([[responseObject objectForKey:@"popups"] isKindOfClass:[NSString class]]){
                
                
                [[DataHander sharedDataHander] showViewWithStr:[responseObject objectForKey:@"popups"] andTime:1 andPos:CGPointZero];
                
            }else{
            
            NSDictionary *popupsData = [responseObject objectForKey:@"popups"];
            
            if([[popupsData objectForKey:@"type"] intValue]==0){
                
                 [[DataHander sharedDataHander] showViewWithStr:[popupsData objectForKey:@"content"] andTime:1 andPos:CGPointZero];
                
            }else if([[popupsData objectForKey:@"type"] intValue]==1){
                
                backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
                [[_obj view] addSubview:backV];
                [backV setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
                
                backV.userInteractionEnabled=true;
                UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBackV)];
                [backV addGestureRecognizer:singleTap];
                
                UIImageView *messageImage=[[UIImageView alloc]initWithFrame:CGRectMake(12*DEF_Adaptation_Font*0.5,220*DEF_Adaptation_Font*0.5, 616*DEF_Adaptation_Font*0.5, 486*DEF_Adaptation_Font*0.5)];
                
                messageImage.layer.cornerRadius = 8*DEF_Adaptation_Font*0.5;
                messageImage.layer.masksToBounds = YES;
                
                
                [messageImage sd_setImageWithURL:[popupsData objectForKey:@"url"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                [backV addSubview:messageImage];
                
                
            }else if([[popupsData objectForKey:@"type"] intValue]==2){
                
                backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
                [[_obj view] addSubview:backV];
                [backV setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
                
                backV.userInteractionEnabled=true;
                UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBackV)];
                [backV addGestureRecognizer:singleTap];
                
                
                NSURL *url = [[NSURL alloc] initWithString:[popupsData objectForKey:@"url"]];
               _player=[AVPlayer playerWithURL:url];
               playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
                
                playerLayer.frame = CGRectMake(12*DEF_Adaptation_Font*0.5,220*DEF_Adaptation_Font*0.5, 616*DEF_Adaptation_Font*0.5, 486*DEF_Adaptation_Font*0.5);
                [backV.layer addSublayer:playerLayer];
                [_player play];
                playerLayer.cornerRadius = 8*DEF_Adaptation_Font*0.5;
                playerLayer.masksToBounds = YES;

            }
                
            }

        }else{
            
             [[DataHander sharedDataHander] showViewWithStr:@"签到失败" andTime:1 andPos:CGPointZero];
            
        }
    }fail:^{
        
       
    }];
}



-(void)createPropDetailView:(NSDictionary*)DetailData{
    detailV=[[ShoppingDetailView alloc]initWithFrame:[self.obj view].bounds andObject:self andDataDic:DetailData];
    [[self.obj view]addSubview:detailV];

}



-(void)getCommodityData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    

    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getCommodity" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            mallData = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            
           
            
            [mallMainV updateDataView:mallData];
        }
    }fail:^{
    
        NSLog(@"2222222");
        
    }];
}


-(void)requestData{
    
    mallData = [[NSMutableDictionary alloc] initWithCapacity:50];
    mallMainV = [[MallMainView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:mallMainV];
    [self getCommodityData];
}


-(void)createMallPayViewWithDataDic:(NSDictionary *)dataDic{
    mallPayV=[[MallPayView alloc]initWithFrame:[self.obj view].bounds and:self andPayNumber:1 andOrderDic:dataDic andTime:nil];
    [[_obj view] addSubview:mallPayV];
}
-(void)createShoppingArgumentVWithDataDic:(NSDictionary *)dataDic{
    argumentV=[[ShoppingArgumentView alloc]initWithFrame:[self.obj view].bounds andObject:self andDataDic:dataDic];
    [[_obj view]addSubview:argumentV];
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
//            if ([[dataDic objectForKey:@"price"]intValue]>0) {
#warning-跳转到支付宝界面
//                [self getMyOrderFromHttp];
//                [AliManagerData doAlipayPay:responseObject[@"data"]];
//            }else{
                [self changeOrderStatusForOrderId:[dataDic objectForKey:@"orderid"] ProductId:[dataDic objectForKey:@"productid"]];
            [mallPayV removeFromSuperview];
             [[DataHander sharedDataHander] showViewWithStr:@"支付成功" andTime:1 andPos:CGPointZero];
//            }
        }else{
            [[DataHander sharedDataHander] showViewWithStr:@"您填写的地址信息错误" andTime:1 andPos:CGPointZero];
        }
    }fail:^{
        
    }];
}
//改变创建订单的状态
-(void)changeOrderStatusForOrderId:(NSString *)orderId ProductId:(NSString*)productId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@([orderId intValue]) forKey:@"orderId"];
    [dic setObject:@([productId intValue]) forKey:@"productId"];
    [dic setObject:@(1) forKey:@"status"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"changeOrderStatus" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
//            [self getMyOrderFromHttp];
            
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)popViewController{
      [[self.obj navigationController]popViewControllerAnimated:YES];
}
@end
