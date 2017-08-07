//
//  TicketPayView.h
//  Looper
//
//  Created by 工作 on 2017/8/2.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketPayView : UIView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDataDic:(NSDictionary *)dataDic andPayNumber:(NSInteger)paynumber;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)id viewModel;
@end
