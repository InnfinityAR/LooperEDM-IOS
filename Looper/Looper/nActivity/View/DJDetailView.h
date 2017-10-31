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
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSDictionary*)djData;
//判断是否直接来自搜索，如果是，返回的时候需要直接释放controller
@property(nonatomic) BOOL isFromSearchView;
@end
