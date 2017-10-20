//
//  FamilyOfficialView.h
//  Looper
//
//  Created by 工作 on 2017/10/20.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHImageViewer.h"
@interface FamilyOfficialView : UIView<XHImageViewerDelegate>
@property(nonatomic,strong)id obj;
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary *)dataDic andFootprint:(NSArray *)footprint andAlbumn:(NSArray *)albumn andRole:(NSString *)role;
@end
