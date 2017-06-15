//
//  KKClickEffectImageView.m
//  Looper
//
//  Created by lujiawei on 15/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "KKClickEffectImageView.h"

@implementation KKClickEffectImageView



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = YES;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = NO;
}

#pragma mark - 高亮后产生的效果

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    if (highlighted) {
        
        self.alpha = 0.5;
    }
    else {
        
        self.alpha = 1.f;
    }
}


@end
