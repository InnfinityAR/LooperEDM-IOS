//
//  FamilyMessageView.h
//  Looper
//
//  Created by 工作 on 2017/8/28.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyMessageView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataArr:(NSArray *)dataArr;
@property(nonatomic,strong)id obj;
@end
