//
//  FramilyAddInviteView.m
//  Looper
//
//  Created by lujiawei on 04/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FramilyAddInviteView.h"
#import "FamilyViewModel.h"

@implementation FramilyAddInviteView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{

    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        
        [self createView];
        
    }
    return self;
}


-(void)createView{

    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    

}







@end
