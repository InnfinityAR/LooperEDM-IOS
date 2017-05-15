//
//  StartViewModel.m
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "StartViewModel.h"
#import "StartViewController.h"
#import "LooperConfig.h"
#import "SelectView.h"
#import "ReadJsonFile.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"


@implementation StartViewModel
@synthesize obj = _obj;
@synthesize StartV = _StartV;
@synthesize selectView = _SelectV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (StartViewController*)controller;
       
        [self initView];
    }
    return  self;
}

-(void)initView{
    
    
    _SelectV = [[SelectView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    
    [[_obj view] addSubview:_SelectV];
}


-(void)removeSelectToStart:(int)typeNum{

    [_SelectV removeFromSuperview];
    
    
    
    
    
    [self requestData:typeNum];
    
}

-(void)requestData:(int)typeNum{
    

    NSDictionary *dic=[ReadJsonFile readFile:@"song.json"];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"song"]];
    
    
    NSDictionary *dic1 = [[NSDictionary alloc] init];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"music" parameters:dic1   success:^(id responseObject) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:(NSArray*)responseObject[@"data"]];

        if(typeNum==101){
            [array removeObjectsInRange:NSMakeRange(8, 15)];
        }
        
        _StartV = [[StartView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andArray:array];
        
        [[_obj view] addSubview:_StartV];
        
        
       
    }fail:^{
        
    }];
}

-(void)stopMusic{

    [_StartV playMusic];
    
}


-(void)toMainView:(NSArray*)resultArray{
    [_StartV removeFromSuperview];
     [[_obj view] setBackgroundColor:[UIColor colorWithRed:29/255.0 green:30/255.0 blue:35/255.0 alpha:1.0]];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic1 setObject:resultArray forKey:@"likeMArray"];
    [dic1 setObject:[LocalDataMangaer sharedManager].thirdId forKey:@"thirdPartyId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createTestRecord" parameters:dic1   success:^(id responseObject) {
       
        
        NSLog(@"%@",responseObject);
        
          [self.obj toMainHomeView];
    }fail:^{
        
    }];

}





@end
