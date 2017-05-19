//
//  PlayerInfoView.h
//  Looper
//
//  Created by lujiawei on 1/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerInfoView : UIView <UIScrollViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)initWithlooperData:(NSDictionary*)looperData andisFollow:(int)isFollow;
@end
