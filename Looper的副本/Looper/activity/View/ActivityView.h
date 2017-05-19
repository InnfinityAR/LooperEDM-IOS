//
//  ActivityView.h
//  Looper
//
//  Created by 工作 on 2017/5/17.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)reloadTableData:(NSMutableArray*)DataLoop andUserArray:(NSMutableArray*)DataUser;
@end
