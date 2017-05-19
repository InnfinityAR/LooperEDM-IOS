//
//  HudView.m
//  Looper
//
//  Created by lujiawei on 12/21/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "HudView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "MainViewModel.h"

@implementation HudView

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
}



-(void)initView{





}






@end
