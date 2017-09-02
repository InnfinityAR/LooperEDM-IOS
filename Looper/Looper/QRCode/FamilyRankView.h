//
//  FamilyRankView.h
//  Looper
//
//  Created by 工作 on 2017/8/24.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyRankView : UIView

-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataArr:(NSArray *)dataArr andType:(int)type;
@property(nonatomic,strong)id obj;
-(void)reloadData:(NSArray *)dataArr;
@end
