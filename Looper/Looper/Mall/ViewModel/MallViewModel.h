//
//  MallViewModel.h
//  Looper
//
//  Created by lujiawei on 07/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallViewModel : NSObject
{
    id obj;
    
}

-(id)initWithController:(id)controller;

-(void)createPropDetailView:(NSDictionary*)DetailData;

-(void)popViewMallController;

-(void)dailyCheckIn;

-(void)getCreditHistory;

@property (nonatomic )id obj;

-(void)popViewController;



-(void)requestDataCode:(NSString*)mobileNum;
-(void)checkVerificationCodeForvCode:(NSString *)vCode ProductId:(int)productId andresultid:(int)resultId andClientAddress:(NSString*)clientAddress andclientMobile:(NSString *)clientMobile anddelivery:(NSString *)delivery anddeliveryCode:(NSString *)deliveryCode andPayNumber:(NSInteger)payNumber  andclientName:(NSString *)clientName andPrice:(NSInteger)price;
@end
