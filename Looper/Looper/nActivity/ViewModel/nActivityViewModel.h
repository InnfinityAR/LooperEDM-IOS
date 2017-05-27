//
//  nActivityViewModel.h
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityDetailView.h"
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
@end
