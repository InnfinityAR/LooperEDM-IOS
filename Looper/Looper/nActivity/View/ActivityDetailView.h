//
//  ActivityDetailView.h
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYGooeyMenu.h"

@interface ActivityDetailView : UIView <UIWebViewDelegate,menuDidSelectedDelegate,UIImagePickerControllerDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDetailDic:(NSDictionary*)detailDic;

@end
