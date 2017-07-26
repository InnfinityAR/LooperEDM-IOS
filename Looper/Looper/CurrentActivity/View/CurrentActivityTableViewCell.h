//
//  CurrentActivityTableViewCell.h
//  Looper
//
//  Created by 工作 on 2017/5/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CurrentActivityTableViewCellDelegate <NSObject>

- (void)testBtn:(UIButton*)btn;

@end
@interface CurrentActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *themeLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet UILabel *ticketLB;
@property (weak, nonatomic) IBOutlet UIButton *edmBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UILabel *finishLB;
@property (nonatomic, weak)id <CurrentActivityTableViewCellDelegate> activityDelegate;
@end
