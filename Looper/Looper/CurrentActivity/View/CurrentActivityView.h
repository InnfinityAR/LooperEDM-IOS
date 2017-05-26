//
//  CurrentActivityView.h
//  Looper
//
//  Created by 工作 on 2017/5/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentActivityView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray* dataArr;
@property(nonatomic,strong)id obj;
-(void)reloadTableData:(NSMutableArray*)DataLoop;
-(instancetype)initWithFrame:(CGRect)frame andFromView:(UIView *)view andMyData:(NSMutableArray*)myDataSource;
@property(nonatomic,strong)UITableView *tableView;
@end
