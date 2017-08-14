//
//  UserInfoView.h
//  Looper
//
//  Created by lujiawei on 3/25/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoView : UIView{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSDictionary* myData;

-(void)updataView:(NSDictionary*)data;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andMyData:(NSDictionary*)myDataSource;

@end
