//
//  ViewController.m
//  Looper
//
//  Created by lujiawei on 12/2/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "ViewController.h"
#import "CurrentActivityView.h"
#import "LooperConfig.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   // self.
   // [self.navigationBar setHidden:YES];

  //  [self.view setBackgroundColor:[UIColor brownColor]];
    self.view.userInteractionEnabled=true;
    
  CurrentActivityView *view1=[[CurrentActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) andFromView:self.view andMyData:nil];
//    self.view=view;
  ///  [[self view] addSubview:view1];
    [self.view addSubview:view1];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    
}


@end




