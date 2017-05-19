//
//  commonTableView.h
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commonTableView : UIView  <UITableViewDataSource,UITableViewDelegate>{


    id obj;
    int typeView;


}
@property(nonatomic,strong)id obj;
@property(nonatomic)int typeView;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(int)type;


-(void)updataView;
@end
