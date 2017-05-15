//
//  GFCalendarCell.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarCell.h"
#import "LooperConfig.h"

@implementation GFCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.todayCircle];
        [self addSubview:self.todayLabel];
        [self addSubview:self.selImg];
        
    }
    
    return self;
}

- (UIView *)todayCircle {
    if (_todayCircle == nil) {
        _todayCircle = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,42*0.5*DEF_Adaptation_Font, 42*0.5*DEF_Adaptation_Font)];
        _todayCircle.center = CGPointMake(0.5 * self.bounds.size.width, 0.5 * self.bounds.size.height);
        _todayCircle.layer.cornerRadius = 0.5 * _todayCircle.frame.size.width;
    }
    return _todayCircle;
}

- (UILabel *)todayLabel {
    if (_todayLabel == nil) {
        _todayLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _todayLabel.backgroundColor = [UIColor clearColor];
    }
    return _todayLabel;
}

- (UILabel *)selImg {
    if (_selImg == nil) {
        _selImg = [[UIImageView alloc] initWithFrame:CGRectMake( 8*DEF_Adaptation_Font,4*DEF_Adaptation_Font, 57*DEF_Adaptation_Font*0.5, 57*DEF_Adaptation_Font*0.5)];
        _selImg.image = [UIImage imageNamed:@"icon_calendar_active.png"];
        _selImg.tag==100;
    }
    return _selImg;
}




@end
