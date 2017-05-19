//
//  SimpleChatViewModel.h
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleChatView.h"


@interface SimpleChatViewModel : NSObject{
    
    id obj;

    SimpleChatView *SimpleChatV;
    
    NSString *targetID;
  
}

@property(nonatomic,strong)id obj;
@property(nonatomic,strong)SimpleChatView *SimpleChatV;
@property(nonatomic,strong)NSString *targetID;

-(id)initWithController:(id)controller;

-(void)setTargetIDChat:(NSDictionary*)targetDic;

-(void)popController;

-(void)sendMessage:(NSString*)messageStr;
-(void)ReceiveMessage:(NSDictionary*)data;
-(void)ReceiveMessageArray:(NSArray*)data;

-(void)removeSimpleAction;

@end
