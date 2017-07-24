//
//  ClubDetailView.h
//  Looper
//
//  Created by lujiawei on 27/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHImageViewer.h"

@interface ClubDetailView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,XHImageViewerDelegate>
{
    
    
    id obj;
    
    
}
@property(nonatomic)id obj;
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSDictionary*)clubData;
@end
