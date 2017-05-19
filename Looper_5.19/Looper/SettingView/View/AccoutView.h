//
//  AccoutView.h
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccoutView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)updataAccess:(int)accessNum;
@end
