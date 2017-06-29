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
@interface nActivityViewModel : NSObject
{
    id obj;
        
}
@property (nonatomic )id obj;
-(id)initWithController:(id)controller;

-(void)popController;

-(void)shareh5View:(NSDictionary*)webDic;

-(void)addActivityDetailView:(NSDictionary*)Dic;
-(void)jumpToCurrentActivity:(NSArray*)array;
-(void)addTicket:(NSDictionary *)dic;
-(void)removeDetailView;
-(void)toLooperView:(NSDictionary*)looperData;

-(void)savaCalendar:(NSDictionary*)dic;

-(void)addInformationToFavorite:(NSString*)activityID andisLike:(NSString*)islike;

-(void)addInformationToFollow:(NSString*)activityID andisLike:(NSString*)islike;


-(void)createPlayerView:(NSDictionary *)dicPlayer;

-(void)removePlayerInfo;



-(void)followUser:(NSString*)targetID;
-(void)unfollowUser:(NSString*)targetID;
@end
