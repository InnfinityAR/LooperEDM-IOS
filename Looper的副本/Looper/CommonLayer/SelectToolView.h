//
//  SelectView.h
//  Looper
//
//  Created by lujiawei on 12/30/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SelectToolView : UIView <UITableViewDataSource,UITableViewDelegate>{
    
    id obj;
    
}

@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;


-(void)initView:(NSDictionary*)dic andViewType:(int)TypeNum andTypeTag:(int)tagN;




@end
