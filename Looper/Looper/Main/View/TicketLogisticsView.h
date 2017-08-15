//
//  TicketLogisticsView.h
//  Looper
//
//  Created by 工作 on 2017/8/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define dataSourceArr @[@"06-13 16:31 \n提交至店长 shopmanagerA, 确认完毕", @"06-13 16:31 \n上班考勤 提交成功，我已经看不清楚局势了", @"06-13 16:31 \n提交至店长 shopmanagerA, 确认完毕,你真的天真的以为你的快递已经到了？别傻了孩子，早就掉进黄河老不回来了", @"06-13 16:31 \n上班考勤 提交成功", @"06-13 16:31 \n提交至店长 shopmanagerA, 确认完毕", @"06-13 16:31 \n上班考勤 提交成功"]
#define DotViewCentX 20*DEF_Adaptation_Font//圆点中心 x坐标
#define VerticalLineWidth 1//时间轴 线条 宽度
#define ShowLabTop 10*DEF_Adaptation_Font//cell间距
#define ShowLabWidth (320*DEF_Adaptation_Font - DotViewCentX - 20*DEF_Adaptation_Font)
#define ShowLabFont [UIFont systemFontOfSize:15]
@interface TicketLogisticsView : UIView<UITableViewDelegate,UITableViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andMyData:(NSDictionary*)myDataSource;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSDictionary *myData;
@property(nonatomic,strong)NSArray *kuaidiArr;
-(void)updataTableView :(NSArray *)kuaidiArr;


//用于储存controller
@property(nonatomic,strong)id ticketVC;
@end
