//
//  addMusicController.m
//  Looper
//
//  Created by lujiawei on 28/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "addMusicController.h"
#import "addMusicViewModel.h"



@implementation addMusicController{

    addMusicViewModel *addMusicVm;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
}

-(void)initWithLoopId:(NSString*)loopId{
    
    addMusicVm = [[addMusicViewModel alloc] initWithController:self andLooperId:loopId];

}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
