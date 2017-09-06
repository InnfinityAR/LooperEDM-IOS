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
#import "DataHander.h"
#import "FamilyApplyView.h"
#import "LocationManagerData.h"
@implementation FamilyViewModel{

    FamilyApplyView *familyApplyV;
    FamilyView *familyV;
    NSString *ownername;
}

@synthesize familyModel =_familyModel;


-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (FamilyViewController*)controller;
        [self requestData];
        
    }
    return  self;
    
}

-(void)requestData{
    
    _familyModel  = [[FramilyModel alloc] init];
    
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
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.x) forKey:@"longitude"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.y) forKey:@"latitude"];
    if (raverId!=nil) {
    [dic setObject:raverId forKey:@"raverId"];
    }
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverFamlily" parameters:dic  success:^(id responseObject) {

        if([responseObject[@"status"] intValue]==0){
            
            
            [_familyModel initWithData:responseObject];
            
            
            if (orderType==nil) {
//第一次加载
                [self.familyView initFamilyRankWithDataArr:_familyModel.RankingArray];
                ownername=responseObject[@"ownername"];
                if (raverId==nil){
                [self.familyView initFamilyMessageWithDataArr:_familyModel.InviteArray];
                [self.familyView initFamilyListWithDataArr:_familyModel.recommendArray];
                }else{
                    [self.familyView initFamilyMemberWithDataArr:_familyModel.familyMember];
                    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]initWithDictionary:_familyModel.familyDetailData];
                    if (ownername==nil||[ownername isEqual:[NSNull null]]) {
                    }else{
                    [dataDic setObject:ownername forKey:@"ownername"];
                    }
                    NSArray *applyArr=nil;
                    if ([[_familyModel.familyMember.firstObject objectForKey:@"role"]intValue]>1) {
                        applyArr=responseObject[@"apply"];
                    }
                    [self.familyView initFamilyDetailWithDataDic:[dataDic copy] andApplyArr:applyArr andLogArr:responseObject[@"message"]];
                     
                }
            }else{
//排行筛选
                [_familyModel updataWithData:responseObject];
                [self.rankView reloadData:_familyModel.RankingArray];
                if (raverId==nil) {
                [self.messageView reloadData:_familyModel.InviteArray];
                }else{
//同意邀请就直接跳转界面
                  [self.familyView initFamilyRankWithDataArr:_familyModel.RankingArray];
                    [self.familyView initFamilyMemberWithDataArr:_familyModel.familyMember];
                    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]initWithDictionary:_familyModel.familyDetailData];
                    [dataDic setObject:ownername forKey:@"ownername"];
                    NSArray *applyArr=nil;
                    if ([[_familyModel.familyMember.firstObject objectForKey:@"role"]intValue]>1) {
                        applyArr=responseObject[@"apply"];
                    }
                    [self.familyView initFamilyDetailWithDataDic:[dataDic copy] andApplyArr:applyArr andLogArr:responseObject[@"message"]];
                }
            }
        }
    }fail:^{
        
    }
     
     ];
}
//同意/拒绝申请家族
-(void)judgeJoinFamilyWithJoin:(NSString *)join andRaverId:(NSString *)raverId andApplyId:(NSString*)applyId andUserId:(NSString *)userid{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:join forKey:@"join"];
    [dic setObject:raverId forKey:@"raverId"];
    [dic setObject:applyId forKey:@"applyId"];
    [dic setObject:userid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"isJoinRaver" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            if ([join intValue]==1) {
            [[DataHander sharedDataHander] showViewWithStr:@"已同意" andTime:1 andPos:CGPointZero];
                 [self getFamilyRankDataForOrderType:@"1" andRaverId:raverId];
            }else{
            [[DataHander sharedDataHander] showViewWithStr:@"已拒绝" andTime:1 andPos:CGPointZero];
                [self getFamilyRankDataForOrderType:@"1" andRaverId:raverId];
            }
        }
    }fail:^{
        
    }];
}

//同意/拒绝邀请加入家族
-(void)judgeInviteJoinFamilyWithJoin:(NSString *)join andRaverId:(NSString *)raverId andinviteId:(NSString*)inviteId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:join forKey:@"join"];
    [dic setObject:raverId forKey:@"raverId"];
    [dic setObject:inviteId forKey:@"inviteId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"isJoinRaver" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            if ([join intValue]==1) {
                [[DataHander sharedDataHander] showViewWithStr:@"已同意" andTime:1 andPos:CGPointZero];
                 [self getFamilyRankDataForOrderType:@"1" andRaverId:raverId];
            }else{
                [[DataHander sharedDataHander] showViewWithStr:@"已拒绝" andTime:1 andPos:CGPointZero];
                [self getFamilyRankDataForOrderType:@"1" andRaverId:nil];
            }
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
            [familyApplyV removeFromSuperview];
            [[DataHander sharedDataHander] showViewWithStr:@"申请提交成功，请等待通知" andTime:2 andPos:CGPointZero];
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
//家族申请弹窗
-(void)getFamilyApplyDataWithDataDic:(NSDictionary *)dataDic{
    FamilyApplyView *applyView=[[FamilyApplyView alloc]initWithFrame:[UIScreen mainScreen].bounds andObj:self andDataDic:dataDic];
    familyApplyV=applyView;
    [[self.obj view]addSubview:applyView];
}



-(void)popController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
}
@end
