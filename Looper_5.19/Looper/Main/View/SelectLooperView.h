//
//  SelectLooperView.h
//  Looper
//
//  Created by lujiawei on 12/16/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLooperView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>{
    
    id obj;
    
    
}
@property(nonatomic,strong)id obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
-(void)initViewWithArray:(NSMutableArray*)array;
-(void)removeCollocationV;

@end
