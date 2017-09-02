//
//  FamilyViewModel.m
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FamilyViewModel.h"
#import "FamilyView.h"
#import "FamilyViewController.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "FamilyDetailView.h"
@implementation FamilyViewModel{


    FamilyView *familyV;

}


-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (FamilyViewController*)controller;
        [self requestData];
        
    }
    return  self;
    
}

-(void)requestData{

    
    familyV = [[FamilyView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:familyV];


}
//家族排行
-(void)getFamilyRankDataForOrderType:(NSString*)orderType andRaverId:(NSString *)raverId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    if (orderType==nil) {
        [dic setObject:@"1" forKey:@"orderType"];
    }else{
    [dic setObject:orderType forKey:@"orderType"];
    }
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    if (raverId==nil) {
        [dic setObject:[LocalDataMangaer sharedManager].raverid forKey:@"raverId"];
    }
     [dic setObject:@"8" forKey:@"raverId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverFamlily" parameters:dic  success:^(id responseObject) {

        if([responseObject[@"status"] intValue]==0){
            if (orderType==nil) {
//第一次加载
                [self.familyView initFamilyRankWithDataArr:responseObject[@"data"]];
            }else{
//排行筛选
                [self.rankView reloadData:responseObject[@"data"]];
            }
        }
    }fail:^{
        
    }
     
     ];

    
    
}
//家族详情
-(void)getFamilyDetailDataForRfId:(NSString*)rfId andRank:(NSString *)rankNumber{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:rfId forKey:@"rfId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverFamilyDetail" parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            FamilyDetailView *familyDetailV=[[FamilyDetailView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self andDataDic:responseObject[@"data"] andRankNumber:rankNumber];
            [self.familyView addSubview:familyDetailV];
        }
    }fail:^{
        
    }];
}

//申请家族
-(void)getApplyFamilyDataForRfId:(NSString*)rfId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:rfId forKey:@"rfId"];
     [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"applyFamily" parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            
        }
    }fail:^{
        
    }];
}

//获取所有的家族
-(void)getRaverData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaver" parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            [self.familyView initFamilyListWithDataArr:responseObject[@"raver"]];
        }
    }fail:^{
        
    }];
}
//搜索家族
-(void)searchRaverFamilyDataForSearchText:(NSString*)searchText{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:searchText forKey:@"searchText"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"searchRaverFamily" parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            [self.searchView initSearchData:responseObject[@"data"]];
        }
    }fail:^{
        
    }];
}

-(void)popController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
}
@end
