//
//  LooperListViewModel.m
//  Looper
//
//  Created by lujiawei on 4/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LooperListViewModel.h"
#import "LooperListViewController.h"
#import "LooperConfig.h"
#import "looperViewController.h"
#import "CreateLoopController.h"
#import "AFNetworkTool.h"
#import "DataHander.h"
#import "LocalDataMangaer.h"

@implementation LooperListViewModel{

    
}

@synthesize obj = _obj;
@synthesize LooperListV = _LooperListV;
@synthesize loopListData = _loopListData;
@synthesize tagData = _tagData;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (LooperListViewController*)controller;
        [self requestAllTag];
    }
    return  self;
}


-(void)requestData:(NSString*)tag andType:(int)type{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:@"30" forKey:@"pageSize"];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:[[NSNumber alloc] initWithInt:type] forKey:@"type"];
    [dic setObject:tag forKey:@"tag"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoop" parameters:dic success:^(id responseObject){

        if([responseObject[@"status"] intValue]==0){
            _loopListData = responseObject;
            
            [_LooperListV reloadData];
            
            if([[_loopListData objectForKey:@"data"] count]==0){
                 [[DataHander sharedDataHander] showViewWithStr:@"该标签下暂时没有对应的loop" andTime:1 andPos:CGPointZero];
            }
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)requestAllTag{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getTag" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
         
            _tagData = [[NSMutableArray alloc] initWithCapacity:50];
            
            for (int i=0;i<[responseObject[@"data"] count];i++){
                NSDictionary *dic = [responseObject[@"data"] objectAtIndex:i];
                if([dic objectForKey:@"offical_flag"]!=[NSNull null]){
                    if([[dic objectForKey:@"offical_flag"] intValue]==1){
                        
                        [_tagData addObject:[dic objectForKey:@"diyflag_name"]];
                    }
                }
               
            }
            [self initView];
            
        }
    }fail:^{
        
    }];
}

-(void)initView{
    _LooperListV = [[LooperListView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
     [[_obj view] addSubview:_LooperListV];
    
    
    [self requestData:@"" andType:3];
}


-(void)toLooperView:(NSDictionary*)looperData{
    
    looperViewController *looperV = [[looperViewController alloc] init];
    
    [looperV initWithData:looperData];
    
    [[_obj navigationController]  pushViewController:looperV animated:NO];
}

-(void)toCreateLooperView{

    CreateLoopController *createLoop = [[CreateLoopController alloc] init];
    [[_obj navigationController]  pushViewController:createLoop animated:NO];
    
}

-(void)toCreateloop{
    
    

}


-(void)backFrontView{

  [[_obj navigationController] popViewControllerAnimated:NO];
    //  [_obj dismissViewControllerAnimated:YES completion:nil];

}

@end
