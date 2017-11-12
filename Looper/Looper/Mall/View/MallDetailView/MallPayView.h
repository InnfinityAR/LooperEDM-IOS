//
//  MallPayView.h
//  Looper
//
//  Created by 工作 on 2017/11/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallPayView : UIView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andPayNumber:(NSInteger)paynumber andOrderDic:(NSDictionary *)orderDic andTime:(NSString*)time;
@property(nonatomic,strong)id viewModel;
@end
