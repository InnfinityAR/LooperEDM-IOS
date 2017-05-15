//
//  nMainView.h
//  Looper
//
//  Created by lujiawei on 3/15/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nMainView : UIView{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)MainChatEvent:(int)EventTag;
-(void)toLoopView:(NSDictionary*)loopData;
-(void)chatView:(NSString*)targetId;

-(void)updataView;


@end
