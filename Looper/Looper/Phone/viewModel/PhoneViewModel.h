//
//  HomeViewModel.h
//  Looper
//
//  Created by lujiawei on 12/23/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneView.h"


@interface PhoneViewModel : NSObject{
    
    id obj;
    PhoneView *phoneV;
    

}


@property(nonatomic,strong)id obj;
@property(nonatomic,strong)PhoneView *phoneV;


-(id)initWithController:(id)controller;
-(void)popController;

-(void)JumpToSimpleChat:(NSDictionary*)TargetDic;



-(void)removePlayerInfo;
-(void)removeAction;

-(void)pushController:(NSDictionary*)dic;
-(void)readMessage:(int)type;


@end
