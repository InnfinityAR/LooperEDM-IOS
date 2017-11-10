//
//  ShoppingPhotoView.h
//  Looper
//
//  Created by 工作 on 2017/11/9.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingPhotoView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andPhotoArr:(NSArray *)photoNameArr andIntex:(NSInteger)index;
@property(nonatomic,strong)id obj;
@end
