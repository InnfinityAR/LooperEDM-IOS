//
//  CurrentActivityTableViewCell.m
//  Looper
//
//  Created by 工作 on 2017/5/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "CurrentActivityTableViewCell.h"
#import "LooperConfig.h"
@implementation CurrentActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.edmBtn.layer.cornerRadius=10;
    self.edmBtn.layer.masksToBounds=YES;
    [self.edmBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self.saleBtn.layer setBorderWidth:0.7];
    self.saleBtn.layer.borderColor=[UIColor colorWithRed:24.0/255.0 green:163.0/255.0 blue:170.0/255.0 alpha:1.0].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
