//
//  UseInfoView.h
//  Looper
//
//  Created by 工作 on 2017/5/23.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UseInfoView : UIView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)reloadTableData:(NSMutableDictionary*)DataLoop;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@end
