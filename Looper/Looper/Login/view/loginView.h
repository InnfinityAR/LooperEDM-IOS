//
//  loginView.h
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginView : UIView
{

    id obj;


}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)removeAllView;
@property(nonatomic,strong)UIView *firstLoginView;
@end
