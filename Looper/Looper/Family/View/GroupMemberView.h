//
//  GroupMemberView.h
//  Looper
//
//  Created by 工作 on 2017/11/2.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupMemberView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSMutableArray *)dataArr;
@property(nonatomic,strong)id obj;

@property(nonatomic,strong)NSMutableArray *dataSource;//现有的成员
@end
