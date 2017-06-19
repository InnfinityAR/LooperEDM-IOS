//
//  ActivityViewModel.m
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityViewModel.h"
#import "activityModel.h"
#import "ActivityViewController.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "DataHander.h"
#import "WebViewController.h"
#define ActivityURL @"getActivity"
#import "LocalDataMangaer.h"
@implementation ActivityViewModel
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
//陆兄style
-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (ActivityViewController*)controller;
        [self initView];
    }
    return  self;
}
-(void)initView{
    self.activityV = [[ActivityView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:self.activityV];
    
}

-(NSInteger)rowNumber{
    
    return self.dataArr.count;
}
-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber+=1;
//    [self pustDataForSomeString:(NSString *)string];
    
}
-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber=0;
    //    [self pustDataForSomeString:(NSString *)string];
    
}



-(void)thumbActivityMessage:(NSString*)like andUserId:(NSString*)userId andMessageId:(NSString*)messageID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:messageID forKey:@"messageId"];
    [dic setObject:like forKey:@"like"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"thumbActivityMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)sendActivityMessage:(NSString *)activityId and:(NSString*)message and:(NSArray*)images{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:activityId forKey:@"activityId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:message forKey:@"message"];
    [dic setObject:images forKey:@"images"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendActivityMessage" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            
            
        }
    }fail:^{
        
    }];
}

-(void)getActivityInfoById:(NSString *)activityId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:activityId forKey:@"activityId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getActivityInfo" parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){

            
        }
    }fail:^{
        
    }];
}


//加载数据
-(void)pustDataForSomeString:(NSString *)string{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:ActivityURL parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            self.dataArr = responseObject[@"data"];

            [self.activityV reloadTableData:self.dataArr];
 
        }
    }fail:^{
        
    }];
}

-(void)popController{
    
    [[_obj navigationController] popViewControllerAnimated:NO];
    
 
}
-(void)dataForH5:(NSDictionary *)dic{

    WebViewController *webVc = [[WebViewController alloc] init];
    [[_obj navigationController] pushViewController:webVc animated:NO];
    [webVc webViewWithData:dic andObj:self];
    
}

@end
