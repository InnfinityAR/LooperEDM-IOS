//
//  MainChatView.h
//  Looper
//
//  Created by lujiawei on 3/28/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchTableView.h"

@interface MainChatView  : UIView <UITableViewDelegate,UITableViewDataSource,TouchTableViewDelegate>{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andLoopData:(NSDictionary*)loopData;

-(void)updataLoopFollowData:(NSDictionary *)loopData;

@end
