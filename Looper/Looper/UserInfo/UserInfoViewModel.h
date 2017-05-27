//
//  UserInfoViewModel.h
//  Looper
//
//  Created by 工作 on 2017/5/23.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UseInfoView.h"
@interface UserInfoViewModel : NSObject
@property(nonatomic,strong)id obj;
@property(nonatomic) NSInteger VMNumber;
@property(nonatomic,strong)UseInfoView *useView;
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@property(nonatomic,strong)NSDictionary *MainData;
@property(nonatomic,strong)NSDictionary *musicData;
-(id)initWithController:(id)controller;
-(void)getDataForSomething:(NSString *)something;
-(void)hudOnClick:(NSInteger)type;
-(void)popWithViewController;
-(void)removeCommonView;
//用于Loop的commitTableView
-(void)pushControllerToUser:(NSDictionary*)dic;
-(void)JumpLooperView:(NSDictionary*)loopData;
@end
