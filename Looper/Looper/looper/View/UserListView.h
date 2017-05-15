//
//  UserListView.h
//  Looper
//
//  Created by lujiawei on 4/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListView : UIView
{
    
    id obj;
    NSArray *userArray;
    
}
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSArray *userArray;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andUserData:(NSArray*)userArrayData;

@end
