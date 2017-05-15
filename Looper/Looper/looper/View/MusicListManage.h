//
//  MusicListManage.h
//  Looper
//
//  Created by lujiawei on 4/15/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MusicViewCell.h"

@interface MusicListManage : UIView<UITableViewDataSource,UITableViewDelegate>
{
    
    id obj;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andLooperData:(NSDictionary*)looperData;
-(void)addMusicArray:(NSString*)musicId;
-(void)removeMusicArray:(NSString*)musicId;
-(void)updataLoad:(NSArray*)musicData;


@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSDictionary* looperData;


@end
