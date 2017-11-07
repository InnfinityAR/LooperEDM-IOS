//
//  SerachViewModel.m
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SerachViewModel.h"
#import "SerachViewController.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "AFNetworkTool.h"
#import "looperViewController.h"
#import "DataHander.h"
#import "MainViewController.h"
#import "SimpleChatViewController.h"

#import "nActivityViewController.h"
#import "FamilyApplyView.h"
#import "LocalDataMangaer.h"
@implementation SerachViewModel{


    NSMutableArray *ActivityArray;
    NSMutableArray *userArray;
    NSMutableArray *DJArray;
NSMutableArray *RaverArray;
    FamilyApplyView   *familyApplyV;
}

@synthesize obj = _obj;
@synthesize SerachV = _SerachV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (SerachViewController*)controller;
        [self initView];
      
    }
    return  self;
}


-(void)updateData{

    if(_SerachV!=nil){
        [_SerachV reloadTableData:ActivityArray andUserArray:userArray andMusicArr:DJArray andAlbumnArr:RaverArray];
    }
}



-(void)initView{    

    

    _SerachV = [[SerachView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:_SerachV];

}


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(void)serachStr:(NSString*)setachStr{
    
    
    if([self isBlankString:setachStr]==false){
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:setachStr forKey:@"name"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"searchLoop" parameters:dic  success:^(id responseObject) {

        if([responseObject[@"status"] intValue]==0){
            ActivityArray = [responseObject[@"data"] objectForKey:@"Activity"];
            userArray = [responseObject[@"data"] objectForKey:@"User"];
            DJArray = [responseObject[@"data"] objectForKey:@"DJ"];
             RaverArray = [responseObject[@"data"] objectForKey:@"Raver"];
            [_SerachV reloadTableData:ActivityArray andUserArray:userArray andMusicArr:DJArray andAlbumnArr:RaverArray];
            
            if([userArray count]==0){
                [[DataHander sharedDataHander] showViewWithStr:@"找不到用户" andTime:1 andPos:CGPointZero];
            }
        }
    }fail:^{
        
    }];
    }else{
         [[DataHander sharedDataHander] showViewWithStr:@"写点东西再来搜吧" andTime:1 andPos:CGPointZero];
    }
}

-(void)createUserView:(NSDictionary *)userData{

    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:userData];
    [[_obj navigationController]  pushViewController:simpleC animated:NO];

}



-(void)movelooperPos:(NSDictionary *)loopData{
    //[_obj dismissViewControllerAnimated:YES completion:nil];
    looperViewController *looperV = [[looperViewController alloc] init];
    
    [looperV initWithData:loopData];
    
    [[_obj navigationController]  pushViewController:looperV animated:YES];
    
}



-(void)popController{
    
  
   //   [_obj dismissViewControllerAnimated:YES completion:nil];
    [[_obj navigationController] popViewControllerAnimated:NO];
    
 //[_obj presentViewController:serachV animated:YES completion:nil];
    
}

-(void)jumpToNActivityViewControllerWithActivityId:(NSDictionary *)activityDic andType:(NSInteger)type{
    nActivityViewController *nactivityVC=[[nActivityViewController alloc]initWithActivityDic:activityDic andType:type];
      [[_obj navigationController] pushViewController:nactivityVC animated:NO];
    
}
//家族申请弹窗
-(void)getFamilyApplyDataWithDataDic:(NSDictionary *)dataDic{
    if ([LocalDataMangaer sharedManager].raverid==nil||[[LocalDataMangaer sharedManager].raverid isEqual:[NSNull null]]) {
    FamilyApplyView *applyView=[[FamilyApplyView alloc]initWithFrame:[UIScreen mainScreen].bounds andObj:self andDataDic:dataDic];
    familyApplyV=applyView;
    [[self.obj view]addSubview:applyView];
    }else{
        [[DataHander sharedDataHander] showViewWithStr:@"亲你已经在家族中了哦" andTime:1 andPos:CGPointZero];
    }
}
//申请家族
-(void)getApplyFamilyDataForRfId:(NSString*)rfId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:rfId forKey:@"rfId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"applyFamily" parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            [familyApplyV removeFromSuperview];
            [[DataHander sharedDataHander] showViewWithStr:@"申请提交成功，请等待通知" andTime:1 andPos:CGPointZero];
        }else{
            [[DataHander sharedDataHander] showViewWithStr:@"你已申请过家族，不能重复申请" andTime:1 andPos:CGPointZero];
        }
    }fail:^{
        
    }];
}
@end


