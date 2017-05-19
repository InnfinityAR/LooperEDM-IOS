//
//  SelectTitleView.h
//  Looper
//
//  Created by lujiawei on 1/12/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTitleView : UIView
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSMutableArray*)data;
@end
