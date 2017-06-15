//
//  jpushManger.m
//  Looper
//
//  Created by lujiawei on 07/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "jpushManger.h"

static jpushManger *jpushMangerM=nil;

@implementation jpushManger

+(jpushManger *)sharedManager{
    if(jpushMangerM==nil){
        jpushMangerM=[[jpushManger alloc]init];
    }
    return jpushMangerM;
}





@end
