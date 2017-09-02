//
//  TBCycleView.h
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LooperConfig.h"
@interface CycleView : UIView

@property (nonatomic, strong) UIImageView *imageV;

- (void)drawProgress:(CGFloat )progress;

@end
