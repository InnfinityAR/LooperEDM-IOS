//
//  ShoppingArgumentView.h
//  Looper
//
//  Created by 工作 on 2017/11/13.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingArgumentView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataDic:(NSDictionary *)dataDic;
@property(nonatomic,strong)id obj;
@end
