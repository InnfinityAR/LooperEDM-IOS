//
//  SaleTicketView.h
//  Looper
//
//  Created by 工作 on 2017/8/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleTicketView : UIView
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSDictionary *orderDic;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDataDic:(NSDictionary *)dataDic orderDic:(NSDictionary *)orderDic;
@property(nonatomic,strong)NSMutableArray *priceBtnArr;
@property(nonatomic,strong) NSMutableArray *  timeBtnArr;
@end
