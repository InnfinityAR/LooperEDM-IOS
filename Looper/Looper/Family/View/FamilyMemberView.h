//
//  FamilyMemberView.h
//  Looper
//
//  Created by 工作 on 2017/9/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyMemberView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSArray *)dataArr;
@property(nonatomic,strong)id obj;
@end
