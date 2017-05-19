//
//  HomeView.h
//  Looper
//
//  Created by lujiawei on 12/23/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeView : UIView

{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;



-(void)removeAllAnimation;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

@end
