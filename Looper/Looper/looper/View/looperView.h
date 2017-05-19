//
//  SerachView.h
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface looperView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(void)initViewWith:(NSDictionary*)looperData;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)ReceiveMessage:(int)type andData:(NSDictionary*)data;


-(void)updatefollow;

-(void)FeaturedUpdata:(NSDictionary*)FeatureData;

-(void)playMusic:(NSNumber*)number;

-(int)playMusicFront;

-(int)playMusicNext;

-(void)stopMusic;

-(void)removeMusic;

-(void)playMusicAtIndex:(int)index;

-(void)updataData:(NSDictionary*)looperDataSource andType:(int)type;




@end
