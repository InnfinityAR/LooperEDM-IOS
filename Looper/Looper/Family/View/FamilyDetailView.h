//
//  FamilyDetailView.h
//  Looper
//
//  Created by 工作 on 2017/8/30.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyDetailView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataDic:(NSDictionary *)dataDic;
@property(nonatomic,strong)id obj;
@end
