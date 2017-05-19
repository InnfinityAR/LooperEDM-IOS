//
//  HudView.h
//  Looper
//
//  Created by lujiawei on 12/21/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

@end
