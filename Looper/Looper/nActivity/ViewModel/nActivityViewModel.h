//
//  nActivityViewModel.h
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityDetailView.h"
#import "DJDetailView.h"
#import "FamilyOfficialView.h"
@interface nActivityViewModel : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    id obj;
        
}
@property(nonatomic,strong)FamilyOfficialView *officialView;
@property (nonatomic )id obj;
-(void)addInformationToJoin:(NSString*)userId andActivityId:(NSString*)activityID andLike:(int)isLike;

-(id)initWithController:(id)controller andOrderArr:(NSArray *)orderArr;

-(void)popController;

-(void)shareh5View:(NSDictionary*)webDic;

-(void)jumpToCurrentActivity:(NSArray*)array;
-(void)addTicket:(NSDictionary *)dic;
-(void)removeDetailView;
-(void)toLooperView:(NSDictionary*)looperData;

-(void)savaCalendar:(NSDictionary*)dic;

-(void)addInformationToFavorite:(NSString*)activityID andisLike:(NSString*)islike;

-(void)addInformationToFollow:(NSString*)activityID andisLike:(NSString*)islike;

-(void)createPlayerView:(NSDictionary *)dicPlayer;

-(void)removePlayerInfo;

-(void)getDataById:(NSString*)typeId andId:(NSString*)ID;

-(void)addActivityDetailView:(NSDictionary*)ActivityDic andPhotoWall:(int)isPhoto;

-(void)followUser:(NSString*)targetID;

-(void)unfollowUser:(NSString*)targetID;

-(void)followBrand:(NSString*)ID andisLike:(int)islike andType:(int)typeNum;

-(void)sharetTicket:(NSDictionary*)ticketDic;

-(void)setCalendarData;
-(void)jumpToSaleTicketController:(NSDictionary *)dataDic orderDic:(NSDictionary *)orderDic;

-(void)removeActivityAction;

-(void)getOfflineInformationCity;

-(void)getOfflineInformationByCity:(NSString*)cityName;
-(void)getNearbyOfflineInformation;
-(void)searchOfflineInformation:(NSString*)serachStr;
-(void)createSerachView;

-(void)shareAllH5View;

-(void)jumpToPhotoWall:(NSString*)activityID;
//家族官方数据
-(void)getFamilyOfficialWithRaverId:(NSString *)raverId;



-(void)createPhotoWallController:(NSString*)activityId;
-(void)followFamliyWithisLike:(int)islike andRaverId:(NSString *)raverId;
//上传，删除家族照片
-(void)uploadFamilyAlbumnWithImages:(NSArray *)images andRaverId:(NSString *)raverId;
-(void)deleteFamilyAlbumnWithImageId:(NSString *)imageid RaverId:(NSString *)raverId andUserId:(NSString *)userId;
-(void)LocalPhotoWithTag:(NSInteger)tag;
-(void)takePhotoWithTag:(NSInteger)tag;
-(void)updateRaverImageWithRaverId:(NSString *)raverid andImage:(UIImage *)image;
@end
