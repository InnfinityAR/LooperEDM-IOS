//
//  CurrentActivityView.h
//  Looper
//
//  Created by 工作 on 2017/5/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentActivityView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray* dataArr;
//用于记录历史记录
@property(nonatomic,strong)NSMutableArray *historyActivityArr;
@property(nonatomic,strong)NSMutableArray *currentActivityArr;
@property(nonatomic,strong)id obj;
-(void)reloadTableData:(NSMutableArray*)DataLoop;
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andMyData:(NSArray*)myDataSource;
@property(nonatomic,strong)UITableView *tableView;
@end
