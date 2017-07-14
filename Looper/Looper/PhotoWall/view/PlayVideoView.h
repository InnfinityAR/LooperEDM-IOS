//
//  PlayVideoView.h
//  Looper
//
//  Created by lujiawei on 14/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayVideoView : UIView

{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andUrlStr:(NSString*)urlString;

@end
