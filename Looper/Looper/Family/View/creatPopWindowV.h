//
//  creatPopWindowV.h
//  Looper
//
//  Created by 工作 on 2017/9/11.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface creatPopWindowV : UIView
//创建弹窗
+(UIView *)initWithContentLB:(NSString *)contentStr andTarget:(id)target andTag:(int)tag;
@end
