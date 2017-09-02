//
//  ActivityDetailView.h
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYGooeyMenu.h"
#import<WebKit/WebKit.h>
@interface ActivityDetailView : UIView <UIWebViewDelegate,menuDidSelectedDelegate,UIImagePickerControllerDelegate,WKNavigationDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDetailDic:(NSDictionary*)detailDic andActivityDic:(NSDictionary *)ActivityDic;
-(void)setCalendar;

@end
