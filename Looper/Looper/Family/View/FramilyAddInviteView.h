//
//  FramilyAddInviteView.h
//  Looper
//
//  Created by lujiawei on 04/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FramilyAddInviteView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)setDataSource:(NSArray*)arrayData;
@end
