//
//  addMusicView.h
//  Looper
//
//  Created by lujiawei on 28/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addMusicView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    
    


}
@property(nonatomic,strong)id obj;
@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, copy) NSArray *FavoriteArray;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andFavoriteArray:(NSArray*)FavoriteData;




@end
