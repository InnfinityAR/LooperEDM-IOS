//
//  SaleTicketController.m
//  Looper
//
//  Created by 工作 on 2017/8/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SaleTicketController.h"
#import "SaleTicketViewModel.h"
@interface SaleTicketController ()
@property(nonatomic,strong)SaleTicketViewModel *saleTicketVM;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation SaleTicketController
-(instancetype)initWithDataDic:(NSDictionary *)dataDic orderDic:(NSDictionary*)orderDic{
    if (self=[super init]) {
        [self.saleTicketVM getDataFromHTTP:dataDic  orderDic:orderDic];
        self.dataDic=dataDic;
    }
    return self;
}
-(SaleTicketViewModel *)saleTicketVM{
    if (!_saleTicketVM) {
        _saleTicketVM=[[SaleTicketViewModel alloc]initWithController:self];
    }
    return _saleTicketVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//     [self.saleTicketVM getDataFromHTTP:self.dataDic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
