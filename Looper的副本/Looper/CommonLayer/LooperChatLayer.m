//
//  LooperChatLayer.m
//  Looper
//
//  Created by lujiawei on 12/22/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "LooperChatLayer.h"

@implementation LooperChatLayer
@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = idObject;
    }
    return self;
}

-(void)initViewWithData:(NSDictionary*)data{
    
    [self createHudView];
    

    
}

-(void)createHudView{

    


}

@end
