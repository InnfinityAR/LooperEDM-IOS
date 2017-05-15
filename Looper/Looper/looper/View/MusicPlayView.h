//
//  MusicPlayView.h
//  Looper
//
//  Created by lujiawei on 4/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSArray* musicArray;
@property(nonatomic,strong)NSDictionary *looperData;




-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andlooperData:(NSDictionary *)looperData isPlay:(bool)isPlay;

-(void)createHudView:(int)index andisPlay:(BOOL)isPlay;

-(void)updataWithMusic:(NSDictionary*)musicData and:(int)indexpath;


@end
