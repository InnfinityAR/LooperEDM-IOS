//
//  barrageReplyView.h
//  Looper
//
//  Created by 工作 on 2017/7/21.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface barrageReplyView : UIView
@property(nonatomic,strong)UITextField *textField;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andIndex:(NSInteger)index andViewModel:(id)viewModel andActivityID:(NSString *)activityID;
-(void)addReplyData:(NSInteger)index andArray:(NSArray *)dataArr andSendPerson:(NSString *)sendPerson;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)id viewModel;
-(void)updateCommendLB:(NSArray *)dataArr;
@property(nonatomic,strong)NSString *activityID;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *replyArr;
@end
