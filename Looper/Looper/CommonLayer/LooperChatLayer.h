//
//  LooperChatLayer.h
//  Looper
//
//  Created by lujiawei on 12/22/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LooperChatLayer : UIView
{
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)initViewWithData:(NSDictionary*)data;




@end
