//
//  sildeView.h
//  Looper
//
//  Created by lujiawei on 10/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sildeView : UIView
{
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;


-(void)initView:(NSArray*)dataSource;
@end
