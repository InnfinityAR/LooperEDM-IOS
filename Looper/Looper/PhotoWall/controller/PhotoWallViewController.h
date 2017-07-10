//
//  PhotoWallViewController.h
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoWallViewModel.h"

@interface PhotoWallViewController : UIViewController{
    
    PhotoWallViewModel *photoWallVm;
    
}
@property(nonatomic)PhotoWallViewModel *photoWallVm;


@end
