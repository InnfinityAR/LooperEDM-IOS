//
//  FamilyCircleView.h
//  Looper
//
//  Created by 工作 on 2017/10/11.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyCircleView : UIView
@property(nonatomic)id obj;

-(instancetype)initWithFrame:(CGRect)frame
                                                and:(id)idObject
                         andDataSource:(NSArray *)dataSource
                                 andDataArr:(NSArray *)dataArr;
@end
