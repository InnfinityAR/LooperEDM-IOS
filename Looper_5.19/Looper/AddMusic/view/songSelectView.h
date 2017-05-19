//
//  songSelectView.h
//  Looper
//
//  Created by lujiawei on 01/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface songSelectView : UIView  <UITableViewDataSource,UITableViewDelegate>
{
    
    
}
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)id titleName;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andTitle:(NSString*)titleName;

@end
