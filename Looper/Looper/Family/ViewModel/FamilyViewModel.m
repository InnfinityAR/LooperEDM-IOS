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

#import "FramilyAddInviteView.h"

#import "MemberDeleteView.h"
#import "CreateFleetNameView.h"
#import "CreatFleetView.h"

#import "PlayerInfoView.h"
#import "UserInfoViewController.h"
#import "SimpleChatViewController.h"
#import "CreateFleetGroupView.h"
@interface FamilyViewModel()
@property(nonatomic,strong)PlayerInfoView *playerInfoV;
@end
#import "FleetMangerView.h"


@implementation FamilyViewModel{

    FamilyApplyView *familyApplyV;
    FamilyView *familyV;
    FleetMangerView *fleetMangerV;
    CreateFleetNameView  *createFleetV;
    CreateFleetGroupView *CreateFleetGroupV;
    
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
-(void)getFamilyRankDataForOrderType:(NSString*)orderType{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    if (orderType==nil) {
        [dic setObject:@"1" forKey:@"orderType"];
    }else{
    [dic setObject:orderType forKey:@"orderType"];
    }
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.x) forKey:@"longitude"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.y) forKey:@"latitude"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverFamlily" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            [_familyModel initWithData:responseObject];
            if (orderType==nil) {
//第一次加载     注：以后退出家族时传入的orderType也应该是nil，用来判断
                if (_familyModel.familyDetailData==nil) {
                    self.familyView.titleArray=@[@"家族列表",@"家族排行",@"家族消息"];
                    [self.familyView updateTitleArr];
                    [self.familyView updateSC];
                }else{
                    self.familyView.titleArray=@[@"家族详情",@"家族排行",@"家族成员"];
                    [self.familyView updateTitleArr];
                    [self.familyView updateSC];
                }
                [self.familyView initFamilyRankWithDataArr:_familyModel.RankingArray];
                ownername=responseObject[@"ownername"];
                if (_familyModel.familyDetailData==nil){
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
                        applyArr=_familyModel.applyArray;
                    }
                    [self.familyView initFamilyDetailWithDataDic:[dataDic copy] andApplyArr:applyArr andLogArr:_familyModel.messageArray];
                     
                }
            }else{
//排行筛选
                [_familyModel updataWithData:responseObject];
                [self.rankView reloadData:_familyModel.RankingArray];
                if (_familyModel.familyDetailData==nil) {
//拒绝邀请就重新加载界面
                [self.messageView reloadData:_familyModel.InviteArray];
                }else{
//同意邀请就直接跳转界面
                  [self.familyView initFamilyRankWithDataArr:_familyModel.RankingArray];
                    [self.familyView initFamilyMemberWithDataArr:_familyModel.familyMember];
                    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]initWithDictionary:_familyModel.familyDetailData];
                    [dataDic setObject:ownername forKey:@"ownername"];
                    NSArray *applyArr=nil;
                    if ([[_familyModel.familyMember.firstObject objectForKey:@"role"]intValue]>1) {
                        applyArr=_familyModel.applyArray;
                    }
                    [self.familyView initFamilyDetailWithDataDic:[dataDic copy] andApplyArr:applyArr andLogArr:_familyModel.messageArray];
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
                 [self getFamilyRankDataForOrderType:@"1"];
            }else{
            [[DataHander sharedDataHander] showViewWithStr:@"已拒绝" andTime:1 andPos:CGPointZero];
                [self getFamilyRankDataForOrderType:@"1"];
            }
        }else{
         [[DataHander sharedDataHander] showViewWithStr:@"已经加入家族" andTime:1 andPos:CGPointZero];
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
                 [self getFamilyRankDataForOrderType:@"1"];
            }else{
                [[DataHander sharedDataHander] showViewWithStr:@"已拒绝" andTime:1 andPos:CGPointZero];
                [self getFamilyRankDataForOrderType:@"1"];
            }
        }else{
            [[DataHander sharedDataHander] showViewWithStr:@"已经加入家族" andTime:1 andPos:CGPointZero];
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



-(void)getInviteUser{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getInviteUser" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
           
           FramilyAddInviteView* FramilyAddInviteV = [[FramilyAddInviteView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
            [FramilyAddInviteV setDataSource:responseObject[@"data"]];
            
            [[_obj view] addSubview:FramilyAddInviteV];

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


//变更职位
-(void)ChangeJobToSailorWithUserId:(NSString *)userId andRole:(NSString *)role andOriginalRole:(NSString *)originalRole{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
      [dic setObject:[_familyModel.familyDetailData objectForKey:@"raverid"] forKey:@"raverId"];
    if (role==nil) {
//传空的时候是在删除家族成员，因为删除家族成员需要先将他的职位改成水手
       [dic setObject:@"0" forKey:@"role"];
    }else{
     [dic setObject:role forKey:@"role"];
    }
    if ([originalRole integerValue]==0&&role==nil) {
         [self DeleteMemberWithUserId:userId  andOriginalRole:originalRole];
    }else{
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"updateRaverMemberRights" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
           
            if (role!=nil) {
                [self updateFamilyModelWithType:1 andInfo:nil];
            }else{
//传空的时候是在删除家族成员，因为删除家族成员需要先将他的职位改成水手
             [self DeleteMemberWithUserId:userId  andOriginalRole:originalRole];
            }
        }
    }fail:^{
        
    }];
    }
}
//删除家族成员
-(void)DeleteMemberWithUserId:(NSString *)userId  andOriginalRole:(NSString *)originalRole{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:[_familyModel.familyDetailData objectForKey:@"raverid"] forKey:@"raverId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"removeRaverMember" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
             [self updateFamilyModelWithType:1 andInfo:originalRole];
            
        }
    }fail:^{
        
    }];
}
-(void)updateFamilyModelWithType:(NSInteger)type andInfo:(NSString *)info{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:@"1" forKey:@"orderType"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.x) forKey:@"longitude"];
    [dic setObject:@([LocationManagerData sharedManager].LocationPoint_xy.y) forKey:@"latitude"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverFamlily" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            [_familyModel initWithData:responseObject];
            if (type==1) {
                [self.memberView updateData:_familyModel.familyMember];
//家族详情界面的更新
                NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]initWithDictionary:_familyModel.familyDetailData];
                [dataDic setObject:ownername forKey:@"ownername"];
                NSArray *applyArr=nil;
                if ([[_familyModel.familyMember.firstObject objectForKey:@"role"]intValue]>1) {
                    applyArr=_familyModel.applyArray;
                }
                [self.familyView initFamilyDetailWithDataDic:[dataDic copy] andApplyArr:applyArr andLogArr:_familyModel.messageArray];
//家族排行的更新
                 [self.rankView reloadData:_familyModel.RankingArray];
                
                if (info==nil) {
                      [[DataHander sharedDataHander] showViewWithStr:@"更改职位成功" andTime:1 andPos:CGPointZero];
                }else{
                  [[DataHander sharedDataHander] showViewWithStr:@"成员已移除成功" andTime:1 andPos:CGPointZero];
                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
                                   }
            }
        }
    }fail:^{
    }];
}
-(void)delayMethod{
//    if ([[self.WillDeleteMemberDic objectForKey:@"role"]integerValue]==6||[[self.WillDeleteMemberDic objectForKey:@"role"]integerValue]==5) {
//        
//    }
    MemberDeleteView   *selectView=[[MemberDeleteView alloc]initWithContentStr:[NSString stringWithFormat:@"请重新选择一位替换原成员%@“%@”的位置",[self.WillDeleteMemberDic objectForKey:@"nickname"],[self jobnameForStatus:[[self.WillDeleteMemberDic objectForKey:@"role"]intValue]]] andBtnName:@"选择" andType:2 andDataDic:self.WillDeleteMemberDic];
                    [self.familyView addSubview:selectView];
                    [selectView addButtonAction:^(id sender) {
                        CreatFleetView *fleetView=[[CreatFleetView alloc]initWithFrame:[UIScreen mainScreen].bounds andObj:self andDataArr:_familyModel.familyMember andType:1];
                        fleetView.shouldChangeRole=[self.WillDeleteMemberDic objectForKey:@"role"];
                        [[self familyView] addSubview:fleetView];
                    }];
}

//获取家族小组成员
-(void)getMemberGroupWithUserId:(NSString *)userId  andGroupId:(NSString *)groupId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
     [dic setObject:groupId forKey:@"groupId"];
    [dic setObject:[_familyModel.familyDetailData objectForKey:@"raverid"] forKey:@"raverId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverGroupMember" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
        
            
        }
    }fail:^{
        
    }];
}

//获取没有小组的家族散人
-(void)getMemberWithoutGroupWithUserId:(NSString *)userId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:[_familyModel.familyDetailData objectForKey:@"raverid"] forKey:@"raverId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverMemberWithoutGroup" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            
        }
    }fail:^{
        
    }];
}


-(void)createFleetGroup:(NSString*)FleetName{
    
     [self getRaverMemberWithoutGroup:[[_familyModel familyDetailData] objectForKey:@"raverid"]];
    
   


}

-(void)createFleetViewName{
    createFleetV =  [[CreateFleetNameView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[self.obj view]addSubview:createFleetV];
    
 }


-(void)createFleetMangerView{
    
    
    
    
    fleetMangerV  = [[FleetMangerView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[self.obj view]addSubview:fleetMangerV];
    
}

//家族小组成员管理
-(void)getMemberGroupManageWithUserId:(NSString *)userId andGroupId:(NSString *)groupId andTargetId:(NSString *)targetId andJoin:(NSString *)join{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:groupId forKey:@"groupId"];
    [dic setObject:targetId forKey:@"targetId"];
     [dic setObject:join forKey:@"join"];
    [dic setObject:[_familyModel.familyDetailData objectForKey:@"raverid"] forKey:@"raverId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"isJoinRaverGroup" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            
        }
    }fail:^{
        
    }];
}

-(void)getRaverGroup:(NSString*)raverId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:raverId forKey:@"raverId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverGroup" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
        
            
            
            
            
        }
    }fail:^{
        
    }];
}


-(void)getRaverMemberWithoutGroup:(NSString*)raverId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:raverId forKey:@"raverId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getRaverMemberWithoutGroup" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            CreateFleetGroupV=[[CreateFleetGroupView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
            [[self.obj view]addSubview:CreateFleetGroupV];

        }
    }fail:^{
        
    }];
}

-(void)createRaverGroup:(NSString*)raverId andLeaderId:(NSString*)leaderId andGroupName:(NSString*)name{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:raverId forKey:@"raverId"];
    [dic setObject:leaderId forKey:@"leaderId"];
    [dic setObject:name forKey:@"groupName"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createRaverGroup" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
            
            
            
        }
    }fail:^{
        
    }];
}

-(void)popController{
    [[self.obj navigationController]popViewControllerAnimated:YES];
   
}

-(void)createPlayerView:(int)PlayerId{
    
    [_playerInfoV removeFromSuperview];
    
    if(PlayerId!=[[LocalDataMangaer sharedManager].uid intValue]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
        [dic setObject:[NSString stringWithFormat:@"%d",PlayerId] forKey:@"targetId"];
        
        _playerInfoV = [[PlayerInfoView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        _playerInfoV.userInteractionEnabled=true;
        _playerInfoV.multipleTouchEnabled=true;
        [[_obj view] addSubview:_playerInfoV];
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getUserInfo" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                
                [_playerInfoV initWithlooperData:responseObject[@"data"] andisFollow:[responseObject[@"isFollow"] intValue]];
            }else{
                
            }
        }fail:^{
            
        }];
    }
}

-(NSString *)jobnameForStatus:(NSInteger)status{
    switch (status) {
        case 6:
            return @"舰长";
            break;
        case 5:
            return @"副舰长";
            break;
        case 4:
            return @"大副";
            break;
        case 3:
            return @"二副";
            break;
        case 2:
            return @"三副";
            break;
        case 1:
            return @"水手长";
            break;
        case 0:
            return @"水手";
            break;
        default:
            break;
    }
    return nil;
}
#pragma -PlayerInfoV
-(void)removePlayerInfo{
    [_playerInfoV removeFromSuperview];
    
}
-(void)followUser:(NSString*)targetID{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:targetID forKey:@"targetId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"followUser" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
        }else{
            
        }
    }fail:^{
        
    }];
}
//跳转到userInfo界面
-(void)jumpToAddUserInfoVC:(NSString *)userID{
    UserInfoViewController *userVC=[[UserInfoViewController alloc]init];
    userVC.userID=userID;
    [[self.obj navigationController]pushViewController:userVC animated:NO];
}
-(void)pushController:(NSDictionary*)dic{
    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:dic];
    [[_obj navigationController]  pushViewController:simpleC animated:NO];
    
}
@end
