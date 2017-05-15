//
//  MusicViewCell.h
//  Looper
//
//  Created by lujiawei on 4/16/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicViewCell : UITableViewCell
{




}


@property(nonatomic,strong) UILabel *musicName;
@property(nonatomic,strong) UILabel *musicPlayer;



-(void)init_cell_subViewsWithCell:(NSArray*)selectArray
                      refreshCell:(NSDictionary*)dic
                          isOwner:(BOOL)isOwner
                              obj:(id)obj
                          isFrist:(BOOL)isFrist;


@end
