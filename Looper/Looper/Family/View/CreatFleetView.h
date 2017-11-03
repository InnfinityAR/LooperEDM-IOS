//
//  CreatFleetView.h
//  Looper
//
//  Created by 工作 on 2017/9/14.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatFleetView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSArray *)dataArr andType:(NSInteger)type;
@property(nonatomic,strong)id obj;

@property(nonatomic,strong)NSDictionary *shouldChangeRole;


@property(nonatomic)BOOL changeJobWhenRoleIsOne;
@end
