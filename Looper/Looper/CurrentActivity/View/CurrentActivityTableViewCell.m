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
    [self.finishLB.layer setBorderWidth:0.7];
    self.finishLB.layer.borderColor=[UIColor colorWithRed:170.0/255.0 green:172.0/255.0 blue:194.0/255.0 alpha:1.0].CGColor;
    self.cityLB=[[UILabel alloc]initWithFrame:CGRectMake(-12,  10*DEF_Adaptation_Font*0.5, 180*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5)];
    [self.headImage addSubview:self.cityLB];
    self.cityLB.textColor=[UIColor whiteColor];
    self.cityLB.backgroundColor=[UIColor colorWithRed:109/255.0 green:216/255.0 blue:116/255.0 alpha:1.0];
    self.cityLB.layer.cornerRadius=18*DEF_Adaptation_Font*0.5;
    self.cityLB.layer.masksToBounds=YES;
    self.cityLB.font=[UIFont systemFontOfSize:12];
    self.cityLB.textAlignment=NSTextAlignmentCenter;
     self.shadowIV=[[UIImageView alloc]initWithFrame:CGRectMake(0,  10*DEF_Adaptation_Font*0.5, 100, 35*DEF_Adaptation_Font*0.5)];
     self.shadowIV.image=[UIImage imageNamed:@"cityShadow.png"];
    [self.headImage addSubview:self.shadowIV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)textButton:(id)sender {
    
    if (self.activityDelegate && [self.activityDelegate respondsToSelector:@selector(testBtn:)]) {
        [self.activityDelegate testBtn:sender];
    }
    
}
@end
