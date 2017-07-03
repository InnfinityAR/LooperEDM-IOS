//
//  ActivityView.h
//  Looper
//
//  Created by 工作 on 2017/5/17.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityViewModel.h"
#import "ActivityBarrageView.h"
@interface ActivityView : UIView<UITableViewDataSource,UITableViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)reloadTableData:(NSMutableArray*)DataLoop;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSDictionary *objDic;
@property(nonatomic,strong)NSString *activityID;
@property(nonatomic,strong)NSDictionary *activityDic;
@end
