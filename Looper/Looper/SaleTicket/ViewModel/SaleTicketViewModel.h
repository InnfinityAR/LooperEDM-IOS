//
//  SaleTicketViewModel.h
//  Looper
//
//  Created by 工作 on 2017/8/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaleTicketController.h"
@interface SaleTicketViewModel : NSObject
-(id)initWithController:(id)controller;
@property(nonatomic,strong)id obj;

-(void)getDataFromHTTP:(NSDictionary *)dataDic orderDic:(NSDictionary *)orderDic andPrice:(NSInteger)price;
-(void)popViewController;


-(void)requestDataCode:(NSString*)mobileNum;
-(void)checkVerificationCodeForvCode:(NSString *)vCode ProductId:(int)productId andresultid:(int)resultId andClientAddress:(NSString*)clientAddress andclientMobile:(NSString *)clientMobile anddelivery:(NSString *)delivery anddeliveryCode:(NSString *)deliveryCode andPayNumber:(NSInteger)payNumber  andclientName:(NSString *)clientName andPrice:(NSInteger)price;
@end
