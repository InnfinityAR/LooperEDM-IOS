//
//  looperChatView.h
//  Looper
//
//  Created by lujiawei on 1/20/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface looperChatView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)initWithData:(NSDictionary *)looperCharDic andLooperData:(NSDictionary*)looperData;

-(void)removeAction;
-(void)reflashData:(NSDictionary*)looperData andPage:(int)page;
-(void)addPreference:(NSString*)messageId andTargetId:(NSString*)targetId andText:(NSString*)text andisLike:(int)like;

-(void)updataChatDic:(NSDictionary*)looperChatDic;

@end
