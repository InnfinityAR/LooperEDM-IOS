//
//  LooperListView.h
//  Looper
//
//  Created by lujiawei on 4/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AoiroSoraLayout.h"

@interface LooperListView : UIView  <UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)reloadData;
@end
