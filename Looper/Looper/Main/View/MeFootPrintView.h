//
//  MeFootPrintView.h
//  Looper
//
//  Created by lujiawei on 23/10/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeFootPrintView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>{
    
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)updataCollectionData:(NSArray*)arrayData;


@end
