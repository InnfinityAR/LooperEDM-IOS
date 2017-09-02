//
//  FamilyHeaderView.h
//  Looper
//
//  Created by 工作 on 2017/9/1.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyHeaderView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary *)dataDic;
@property(nonatomic,strong)id obj;
@end
