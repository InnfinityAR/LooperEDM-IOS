//
//  LooperListViewModel.h
//  Looper
//
//  Created by lujiawei on 4/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LooperListView.h"

@interface LooperListViewModel : NSObject{
    
    id obj;
    NSDictionary *loopListData;
    

}
-(id)initWithController:(id)controller;

-(void)backFrontView;
-(void)toCreateLooperView;
-(void)toLooperView:(NSDictionary*)looperData;
-(void)requestData:(NSString*)tag andType:(int)type;

@property(nonatomic,strong)id obj;
@property(nonatomic,strong)LooperListView *LooperListV;
@property(nonatomic,strong)NSDictionary *loopListData;
@property(nonatomic,strong)NSMutableArray *tagData;
@end
