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
@interface SaleTicketViewModel()
@property(nonatomic,strong)SaleTicketView *saleTicketV;
@end
@implementation SaleTicketViewModel
-(id)initWithController:(id)controller{
    if (self=[super init]) {
        self.obj=(SaleTicketController *)controller;
    }
    return self;
}
-(void)getDataFromHTTP:(NSDictionary *)dataDic{
    self.dataDic=dataDic;
    self.saleTicketV=[[SaleTicketView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH([self.obj view]) , DEF_HEIGHT([self.obj view])) and:self andDataDic:self.dataDic];
    [[self.obj view]addSubview:self.saleTicketV];
}
-(void)popViewController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
}
@end
