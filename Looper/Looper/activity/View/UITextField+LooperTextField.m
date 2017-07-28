//
//  UITextField+LooperTextField.m
//  Looper
//
//  Created by 工作 on 2017/7/28.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "UITextField+LooperTextField.h"
#import "LooperConfig.h"
@implementation UITextField (LooperTextField)
- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.size.width-=10*DEF_Adaptation_Font;
    return CGRectInset(bounds, 5*DEF_Adaptation_Font, 1);
    
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.size.width-=10*DEF_Adaptation_Font;
    return CGRectInset(bounds, 5*DEF_Adaptation_Font, 1);
    
}
@end
