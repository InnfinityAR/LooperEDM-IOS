//
//  MallViewModel.m
//  Looper
//
//  Created by lujiawei on 07/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MallViewModel.h"
#import "MallViewController.h"
#import "MallMainView.h"
#import "LocalDataMangaer.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"


@implementation MallViewModel{
    
    
    NSMutableDictionary *mallData;
    
    
}

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (MallViewController*)controller;
        [self requestData];
        
    }
    return  self;
    
}


-(void)createPropDetailView:(NSDictionary*)DetailData{
    
    
        
    
    
    
    
    
    
}



-(void)getCommodityData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    

    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getCommodity" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            mallData = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            
            MallMainView *mallMainV = [[MallMainView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
            
            [mallMainV updateDataView:mallData];
        }
    }fail:^{
        
    }];
}


-(void)requestData{
    
    mallData = [[NSMutableDictionary alloc] initWithCapacity:50];
    
    [self getCommodityData];
}



@end
