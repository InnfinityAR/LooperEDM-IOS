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






@property(nonatomic,strong)FamilyMessageView *messageView;
-(void)getFamilyRankDataForOrderType:(NSString*)orderType andRaverId:(NSString *)raverId;
-(void)getRaverData;
-(void)searchRaverFamilyDataForSearchText:(NSString*)searchText;
-(void)getFamilyDetailDataForRfId:(NSString*)rfId andRank:(NSString *)rankNumber;

-(void)getFamilyApplyDataWithDataDic:(NSDictionary *)dataDic;
-(void)getApplyFamilyDataForRfId:(NSString*)rfId;

//同意/拒绝申请家族
-(void)judgeJoinFamilyWithJoin:(NSString *)join andRaverId:(NSString *)raverId andApplyId:(NSString*)applyId;
//同意/拒绝邀请加入家族
-(void)judgeInviteJoinFamilyWithJoin:(NSString *)join andRaverId:(NSString *)raverId andinviteId:(NSString*)inviteId;
@end
