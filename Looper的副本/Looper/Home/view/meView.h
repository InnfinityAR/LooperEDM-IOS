//
//  meView.h
//  Looper
//
//  Created by lujiawei on 12/27/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface meView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;

-(void)initWithData:(NSDictionary*)mineData;

@end

