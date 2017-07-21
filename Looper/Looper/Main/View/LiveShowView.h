//
//  LiveShowView.h
//  Looper
//
//  Created by lujiawei on 19/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveShowView : UIView <UITableViewDataSource,UITableViewDelegate>{
    
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSArray*)array;

@end
