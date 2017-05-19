//
//  MessageView.h
//  Looper
//
//  Created by lujiawei on 29/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nMessageView : UIView <UITableViewDataSource,UITableViewDelegate>{


    id obj;


}
@property(nonatomic)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;


@end
