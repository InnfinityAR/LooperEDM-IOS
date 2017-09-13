//
//  MemberSelectView.h
//  Looper
//
//  Created by 工作 on 2017/9/11.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ButtonBlock) (id sender);
@interface MemberDeleteView : UIView
-(instancetype)initWithContentStr:(NSString *)contentStr andBtnName:(NSString *)btnName;
//button点击事件
- (void)addButtonAction:(ButtonBlock)block;
@end
