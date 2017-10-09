//
//  MainViewModel.h
//  Looper
//
//  Created by lujiawei on 12/11/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#define LopperBtnTag 500000
#define HomeBtnTag 500001
#define SearchBtnTag 500002
#define DJBtnTag 500003
#define ActiveBtnTag 500004
#define mainChatBackTag 500007
#define mainAccountBackTag 500008

#define createLoopBackTag 500003

#define jumpCamera 500005
#define createLoopTag 500004
#define titleTag 500006

#define ActivityBackBtnTag 100000
#define ActivityFollowBtnTag 100001
#define ActivityLikeBtnTag 100002
#define ActivityShareBtnTag 100003

#import <Foundation/Foundation.h>
#import "MainView.h"
#import "SelectLooperView.h"
#import "ActivityLayer.h"
#import "HudView.h"
#import "CreateLoopView.h"
#import "nMainView.h"

#import "TicketLogisticsView.h"
@interface MainViewModel : NSObject <UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{

    
    nMainView *mainV;
    SelectLooperView *selectV;
    ActivityLayer *activityV;
    CreateLoopView *createLoopV;
    HudView *hudV;
    NSDictionary *MainData;
    id obj;
    
    
}
@property(nonatomic,strong)id obj;
@property(nonatomic)nMainView *mainV;
@property(nonatomic)SelectLooperView *selectV;
@property(nonatomic)ActivityLayer *activityV;
@property(nonatomic)HudView *hudV;
@property(nonatomic)CreateLoopView *createLoopV;
@property(nonatomic)NSDictionary *MainData;
@property(nonatomic)NSArray *musicData;
@property(nonatomic)NSInteger VMNumber;
@property(nonatomic,strong)NSArray *orderArr;
@property(nonatomic,strong)TicketLogisticsView *tickLoginV;


-(id)initWithController:(id)controller;
-(void)hudOnClick:(int)type;
-(void)removeSelectLoopV;
-(void)removeCommonView;
-(void)getSessionArray;
-(void)updateMap;
-(void)toCreateLooperView;
-(void)createCommonView:(int)type;
-(void)JumpLooperView:(NSDictionary*)loopData;
-(void)createLoopView;
-(void)takePhoto;
-(void)LocalPhoto;
-(void)checkMapIsUse:(CGPoint)point;
-(void)getAreaMapList:(CGPoint)point;
-(void)requestCreateLoop:(NSDictionary*)dicData;
-(void)mapToPostition:(CGPoint)point;
-(void)pushControllerToUser:(NSDictionary*)dic;
-(void)createMessageController;
-(void)requestgetMyFavorite;
-(void)requestMainData;
-(void)createActivityView:(NSString*)activityId;
-(void)createPlayerView:(int)PlayerId;
-(void)getMyOrderFromHttp;

-(void)getMyFootPrint;
-(void)getKuaiDi100FromHttp:(NSString *)com andNu:(NSString *)nu;

@property(nonatomic,strong)NSArray *kuaidiArr;


@end
