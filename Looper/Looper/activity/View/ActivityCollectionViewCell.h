//
//  ActivityCollectionViewCell.h
//  Looper
//
//  Created by 工作 on 2017/7/7.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)  UILabel *commendLB;
@property(nonatomic,strong)UIButton *commendBtn;
@property(nonatomic,strong)void (^commendBtnClick)();
@property(nonatomic,strong)UILabel *userNameLB;
@property(nonatomic,strong)UIImageView *userImageView;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)void (^shareBtnClick)();
-(void)updateCell;
-(void)updateContentLBHeight;
@property(nonatomic,strong)UILabel *contentLB;
@end
