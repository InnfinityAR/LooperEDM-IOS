//
//  myInfoView.h
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myInfoView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)updataHeadView:(NSString*)headStr;

@end
