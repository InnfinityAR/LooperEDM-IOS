//
//  FeaturedListView.m
//  Looper
//
//  Created by lujiawei on 1/24/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FeaturedListView.h"
#import "looperViewModel.h"

@implementation FeaturedListView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;
        
    }
    return self;
}




@end
