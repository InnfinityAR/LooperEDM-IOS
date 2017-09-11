//
//  MemberSelectView.h
//  Looper
//
//  Created by 工作 on 2017/9/11.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberDeleteView : UIView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary*)dataDic;
@property(nonatomic,strong)id obj;
@end
