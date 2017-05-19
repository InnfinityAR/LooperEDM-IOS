//
//  StartView.h
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface StartView : UIView
{
    
    id obj;
    AVPlayer *player;
    
    
    
    
}
@property(nonatomic,strong)id obj;
@property(nonatomic)AVPlayer *player;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSMutableArray*)ListArray;

-(void)updataMusicProgress:(float)progressF;

-(void)stopMusic;
-(void)playMusic;
@end
