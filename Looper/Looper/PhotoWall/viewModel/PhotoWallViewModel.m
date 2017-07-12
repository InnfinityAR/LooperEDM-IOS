//
//  PhotoWallViewModel.m
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhotoWallViewModel.h"
#import "PhotoWallView.h"
#import "PhotoWallViewController.h"
#import "LooperConfig.h"

@implementation PhotoWallViewModel
-(id)initWithController:(id)controller andActivityId:(NSString*)activityId{
    if(self=[super init]){
        self.obj = (PhotoWallViewController*)controller;
        [self requestData:activityId];
    }
    return  self;
    
}

-(void)requestData:(NSString*)activityId{

    
    PhotoWallView *PhotoWallV =[[PhotoWallView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    
    [[_obj view] addSubview:PhotoWallV];



}

@end
