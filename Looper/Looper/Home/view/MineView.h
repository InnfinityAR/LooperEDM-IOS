//
//  MineView.h
//  Looper
//
//  Created by lujiawei on 12/30/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(void)selectViewType:(int)type andSelectNum:(int)selNum andSelectStr:(NSString*)Selstr;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;


@end
