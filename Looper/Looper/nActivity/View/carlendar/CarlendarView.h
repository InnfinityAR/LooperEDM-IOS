//
//  CarlendarView.h
//  Looper
//
//  Created by 工作 on 2017/7/10.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSCalendarView.h"
#import "CurrentActivityTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface CarlendarView : UIView<UITableViewDataSource,UITableViewDelegate,LTSCalendarEventSource>
{
    BOOL cellCountIsOne;
    BOOL firstUpdate;
}
@property(nonatomic,strong) NSMutableDictionary *eventsByDate;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *events;
@property (nonatomic,strong)LTSCalendarView *calendarView;
- (void)lts_InitUI;
- (NSDateFormatter *)dateFormatter;
-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArr andObj:(id)obj;
@property(nonatomic,strong)id obj;
@end
