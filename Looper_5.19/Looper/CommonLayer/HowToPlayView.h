//
//  HowToPlayView.h
//  Looper
//
//  Created by lujiawei on 2/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToPlayView : UIView

{
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)intoSceenViewType:(int)SceenType;

@end
