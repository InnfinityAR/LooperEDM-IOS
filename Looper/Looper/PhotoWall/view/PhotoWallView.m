//
//  PhotoWallView.m
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhotoWallView.h"
#import "PhotoWallViewModel.h"

@implementation PhotoWallView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{


    if (self = [super initWithFrame:frame]) {
        self.obj = (PhotoWallViewModel*)idObject;
        
        
        [self initView];
    }
    return self;
    

}

-(void)initView{


    


}


@end
