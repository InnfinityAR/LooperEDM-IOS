//
//  PhotoWallView.h
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoWallView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>


{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSDictionary*)dataSource;

-(void)reloadData:(NSDictionary*)dataSource;

-(void)updatePunch:(int)num;

@end
