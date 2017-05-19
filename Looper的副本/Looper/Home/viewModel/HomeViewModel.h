//
//  HomeViewModel.h
//  Looper
//
//  Created by lujiawei on 12/23/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeView.h"
#import "meView.h"
#import "SettingView.h"
#import "AccountView.h"
#import "MessageView.h"
#import "MineView.h"
#import "CalendarView.h"
#import "aboutView.h"


#define meBackTag 101
#define meHeadTag 102
#define meTrendsTag 103
#define meFollowTag 104
#define meFansTag 105
#define meLogOutTag 106

#define meSettingTag 108
#define meShareTag 109
#define meAboutTag 110

#define settingAccount 201
#define settingBack 202
#define settingMessage 203
#define settingWidhCache 204


#define AccountBackTag 301


#define AccountBindPhoneTag 302
#define AccountBindWechatTag 303
#define AccountBackQQTag 304
#define AccountBindWEIBOTag 305

#define MessageBackTag 401

#define MineBackTag 501



@interface HomeViewModel : NSObject{
    
    HomeView *homeV;
    meView *meV;
    SettingView *settingV;
    AccountView *accountV;
    MessageView *messageV;
    MineView *mineV;
    CalendarView *calendarV;
    aboutView  *aboutV;
    
    id obj;
    

}


@property(nonatomic,strong)id obj;
@property(nonatomic)HomeView *homeV;
@property(nonatomic)meView *meV;
@property(nonatomic)SettingView *settingV;
@property(nonatomic)AccountView *accountV;
@property(nonatomic)MessageView *messageV;
@property(nonatomic)MineView *mineV;
@property(nonatomic)CalendarView *calendarV;
@property(nonatomic)aboutView  *aboutV;



-(void)deallocViewAnimation;


-(id)initWithController:(id)controller;
-(void)popViewController;
-(void)jumpToView:(int)TagView;
-(void)hudOnClick:(int)type;
-(void)LocalPhoto;

-(void)takePhoto;
-(void)toMusicView;

-(void)jumpToH5:(NSDictionary*)h5Data;
-(void)jumpToPhone;
-(void)createCalendarV;
-(void)removeAboutV;
-(void)removeCalendar;




@end
