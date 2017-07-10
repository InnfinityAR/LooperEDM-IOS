//
//  PhotoWallViewModel.m
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhotoWallViewModel.h"
#import "PhotoWallViewController.h"


@implementation PhotoWallViewModel
-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (PhotoWallViewController*)controller;
        [self requestData];
    }
    return  self;
    
}

-(void)requestData{

    



}

=



@end
