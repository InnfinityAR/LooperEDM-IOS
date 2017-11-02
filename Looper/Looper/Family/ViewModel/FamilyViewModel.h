//
//  FamilyViewModel.h
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamilyRankView.h"
#import "FamilyView.h"
#import "FamilySearchView.h"
#import "FramilyModel.h"

#import "FamilyMessageView.h"

#import "FamilyMemberView.h"
#import "FamilyDetailView.h"
@interface FamilyViewModel : NSObject

{
    id obj;
    
}

@property (nonatomic )id obj;

-(id)initWithController:(id)controller;
-(void)popController;

@property(nonatomic,strong)FamilyView *familyView;
@property(nonatomic,strong)FamilyRankView *rankView;
@property(nonatomic,strong)FamilySearchView *searchView;
@property(nonatomic,strong)FramilyModel *familyModel;
@property(nonatomic,strong)FamilyMemberView *memberView;
//为了传入家族详情打卡
@property(nonatomic,strong)FamilyDetailView *detailView;
@property(nonatomic,strong)NSArray *familyFootArr;

@property(nonatomic,strong)FamilyMessageView *messageView;
-(void)getFamilyRankDataForOrderType:(NSString*)orderType;
-(void)searchRaverFamilyDataForSearchText:(NSString*)searchText;

-(void)getFamilyApplyDataWithDataDic:(NSDictionary *)dataDic;
-(void)getApplyFamilyDataForRfId:(NSString*)rfId;
-(void)getInviteUser;
//同意/拒绝申请家族
-(void)judgeJoinFamilyWithJoin:(NSString *)join andRaverId:(NSString *)raverId andApplyId:(NSString*)applyId andUserId:(NSString *)userid;
//同意/拒绝邀请加入家族
-(void)judgeInviteJoinFamilyWithJoin:(NSString *)join andRaverId:(NSString *)raverId andinviteId:(NSString*)inviteId;
//邀请加入家族
-(void)inviteMemberToFamilyWithRaverId:(NSString *)raverId andTargetId:(NSString *)targetId andUserId:(NSString *)userId;

-(void)createFleetMangerViewWithUserId:(NSString *)userid andRaverId:(NSString *)raverid andType:(NSInteger)type;

-(void)playNetWorkVideo:(NSString*)videoUrl;

//删除家族成员
-(void)ChangeJobToSailorWithUserId:(NSString *)userId andRole:(NSString *)role andOriginalRole:(NSString *)originalRole;
//将要删除的家族成员的字段
@property(nonatomic,strong)NSDictionary *WillDeleteMemberDic;


-(void)createPlayerView:(int)PlayerId;
-(void)thumbBoardMessage:(NSString*)boardId andLike:(int)isLike;


-(void)createFleetViewName;
-(void)createFleetGroup:(NSString*)FleetName;
//创建家族小组
-(void)createRaverGroup:(NSString*)raverId andLeaderId:(NSString*)leaderId andGroupName:(NSString*)name;




-(void)createMemberManageViewWithDataDic:(NSDictionary *)dataDic;


//获取家族小组成员
-(void)getMemberGroupWithUserId:(NSString *)userId  andGroupId:(NSString *)groupId;
-(void)getMemberWithoutGroupWithUserId:(NSString *)userId;
//用于储存memberManage的当前数据
@property(nonatomic,strong)NSDictionary *currentDic;



-(void)createChangeJobViewWithDataDic:(NSDictionary *)dataDic;

-(void)getMemberFootPrint:(int)page andPageSize:(int)size;

-(void)createPhotoWallController:(NSString*)activityId;

-(void)getRaverFootPrintData;


//将小组成员移出为散人0 加入小组1
-(void)moveMemberGroupWithTargetId:(NSString *)TargetId andRaverId:(NSString *)raverId andGroupId:(NSString *)groupId andJoin:(NSString *)join;


-(void)createGroupMemberWithUserId:(NSString *)userId  andGroupId:(NSString *)groupId;
@end
