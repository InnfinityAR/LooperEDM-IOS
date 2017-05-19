//
//  SimpleChatCollectionViewCell.h
//  Looper
//
//  Created by lujiawei on 2/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleCellView.h"


@interface SimpleChatCollectionViewCell : UICollectionViewCell{
    
    
    
    SimpleCellView *simpleCellV;
    
    
}
@property(nonatomic) SimpleCellView *simpleCellV;

-(void)initCellWithData:(NSDictionary*)cellData and:(id)obj and:(BOOL)hasTime;


@end
