//
//  barrageReplyView.h
//  Looper
//
//  Created by 工作 on 2017/7/21.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface barrageReplyView : UIView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andIndex:(NSInteger)index andViewModel:(id)viewModel;
-(void)addReplyData:(NSInteger)index andArray:(NSArray *)dataArr;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)id viewModel;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *replyArr;
@end
