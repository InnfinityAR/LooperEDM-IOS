//
//  nActivityViewModel.m
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nActivityViewModel.h"
#import "nActivityViewController.h"
#import "nActivityView.h"
#import "ActivityDetailView.h"
#import "LooperConfig.h"

@implementation nActivityViewModel

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (nActivityViewController*)controller;
        [self requestData];
    }
    return  self;

}



-(void)requestData{
    
    
    nActivityView *activityV= [[nActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:activityV];
    

    
    
//    ActivityDetailView *activityDV = [[ActivityDetailView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
//    [[_obj view] addSubview:activityDV];
//    


}

@end
