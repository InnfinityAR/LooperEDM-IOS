//
//  EditPictureView.m
//  Looper
//
//  Created by lujiawei on 19/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "EditPictureView.h"
#import "CreateLoopViewModel.h"

@implementation EditPictureView
@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (CreateLoopViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
    
}




-(void)initView{
    
    
    
    
    
    
    

}



@end
