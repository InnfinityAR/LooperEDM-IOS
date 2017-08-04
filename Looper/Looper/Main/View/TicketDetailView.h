//
//  TicketDetailView.h
//  Looper
//
//  Created by 工作 on 2017/8/4.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketDetailView : UIView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andMyData:(NSArray*)myDataSource;
@property(nonatomic,strong)id obj;
@end
