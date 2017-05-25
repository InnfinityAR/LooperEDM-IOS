//
//  nActivityView.h
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPagedFlowView.h"

@interface nActivityView : UIView <NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSArray*)commendArray;
@end
