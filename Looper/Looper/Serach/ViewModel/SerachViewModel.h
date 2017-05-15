//
//  SerachViewModel.h
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerachView.h"


@interface SerachViewModel : NSObject{
    
    id obj;
    SerachView *SerachV;
    
    
}


-(id)initWithController:(id)controller;

-(void)serachStr:(NSString*)setachStr;
-(void)popController;
-(void)movelooperPos:(NSDictionary *)loopData;
-(void)createUserView:(NSDictionary *)userData;

@property(nonatomic,strong)id obj;
@property(nonatomic,strong)SerachView *SerachV;

@end
