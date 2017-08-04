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
@property(nonatomic,strong)NSDictionary *dataDic;
-(void)getDataFromHTTP:(NSDictionary *)dataDic;
-(void)popViewController;
@end
