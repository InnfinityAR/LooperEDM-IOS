//
//  DJDetailView.h
//  Looper
//
//  Created by lujiawei on 27/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJDetailView : UIView  <UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
@end
