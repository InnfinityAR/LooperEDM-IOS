//
//  SimpleChatView.h
//  Looper
//
//  Created by lujiawei on 2/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleChatView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)updateWithTargetView:(NSDictionary*)targetDic;


-(void)addChatObj:(NSDictionary *)chatData;

-(void)addChatObjWith:(NSArray *)chatDataArray;
-(void)removeAllAction;

@end
