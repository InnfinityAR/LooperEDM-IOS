//
//  FamilyMemberView.h
//  Looper
//
//  Created by 工作 on 2017/9/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyMemberView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSArray *)dataArr;
@property(nonatomic,strong)id obj;

//用于判断cell是否被选中
@property(nonatomic)NSInteger isSelectCell;
@property(nonatomic,strong)UITableView *tableView;

//当在挑选成员变更职位的时候，tableViewCell的点击事件是不一样的
@property(nonatomic,strong)NSString *isSelectMemberToChangeJob;
-(void)updateData:(NSArray *)dataArr;
@end
