//
//  SettingView.h
//  Looper
//
//  Created by lujiawei on 12/29/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;


@end
