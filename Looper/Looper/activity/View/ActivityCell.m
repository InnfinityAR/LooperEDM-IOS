//
//  ActivityCell.m
//  Looper
//
//  Created by 工作 on 2017/5/18.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainPhoto.clipsToBounds = YES;
    self.headPhoto.layer.cornerRadius=12;
    self.headPhoto.layer.masksToBounds=YES;
    //    cell.categoryNameLB.layer.borderColor = [UIColor greenSeaColor].CGColor;
    self.headPhoto.layer.borderWidth = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
