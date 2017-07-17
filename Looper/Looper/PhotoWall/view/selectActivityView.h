//
//  selectActivityView.h
//  Looper
//
//  Created by lujiawei on 17/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectActivityView : UIView

{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDic:(NSDictionary*)dicSource;
@end
