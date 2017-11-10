//
//  MallMainView.m
//  Looper
//
//  Created by lujiawei on 07/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MallMainView.h"
#import "MallViewModel.h"

@implementation MallMainView{
    
    
    NSDictionary *MallData;
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (MallViewModel*)idObject;
        [self initView];
    }
    return self;
    
}



-(void)updateDataView:(NSDictionary*)sourceData{
    
    MallData = sourceData;
    
}

-(void)createHudView{
    
    
    
    
    
}


-(void)initView{
    
    
    
    
    
    
    
}


@end
