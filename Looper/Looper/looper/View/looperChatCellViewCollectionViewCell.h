//
//  looperChatCellViewCollectionViewCell.h
//  Looper
//
//  Created by lujiawei on 1/24/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "looperCellView.h"

@interface looperChatCellViewCollectionViewCell : UICollectionViewCell{



    looperCellView *looperCellV;


}
@property(nonatomic) looperCellView *looperCellV;

-(void)initCellWithData:(NSDictionary*)cellData and:(id)obj;

@end
