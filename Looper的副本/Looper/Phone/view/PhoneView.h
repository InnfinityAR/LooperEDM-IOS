//
//  PhoneView.h
//  Looper
//
//  Created by lujiawei on 1/3/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(void)removeAllAction;

-(void)initWithData:(NSDictionary*)fansFollowData andMessageData:(NSMutableArray*)messageData;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)updataData:(NSDictionary*)fansFollowData andMessageData:(NSMutableArray*)messageData andSourceData:(NSDictionary*)sourceData;

@end
