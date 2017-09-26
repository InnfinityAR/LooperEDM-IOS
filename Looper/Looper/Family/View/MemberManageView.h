//
//  MemberManageView.h
//  Looper
//
//  Created by 工作 on 2017/9/12.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberManageView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj;
@property(nonatomic,strong)id obj;

@property(nonatomic,strong)NSMutableArray *dataSource;//现有的成员
@property(nonatomic,strong)NSMutableArray *anotherData;

-(void)reloadData;
@end
