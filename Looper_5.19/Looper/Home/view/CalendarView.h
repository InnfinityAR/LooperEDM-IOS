//
//  CalendarView.h
//  Looper
//
//  Created by lujiawei on 1/7/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarView : UIView  <UITableViewDataSource,UITableViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

@end
