//
//  ActivityCell.h
//  Looper
//
//  Created by 工作 on 2017/5/18.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainPhoto;
@property (weak, nonatomic) IBOutlet UILabel *commentLB;
@property (weak, nonatomic) IBOutlet UIImageView *headPhoto;
@property (weak, nonatomic) IBOutlet UILabel *themeLB;
//@property (weak, nonatomic) IBOutlet UILabel *numberLB;
//@property (weak, nonatomic) IBOutlet UILabel *endTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *followCountLB;
@property (weak, nonatomic) IBOutlet UIView *hotView;

@end
