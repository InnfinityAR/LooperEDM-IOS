//
//  MessageViewModel.m
//  Looper
//
//  Created by lujiawei on 29/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MessageViewModel.h"
#import "messageViewController.h"
#import "nMessageView.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"

@implementation MessageViewModel{

    nMessageView *messageV;


}

@synthesize messageData = _messageData;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (messageViewController*)controller;
        [self requestData];
    }
    return  self;
}

-(void)initView{

    messageV = [[nMessageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:messageV];

}

-(void)popController{

    [[_obj navigationController] popViewControllerAnimated:NO];
}




-(void)requestData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getNotification" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            _messageData = responseObject;
        
            [self initView];
        }
    }fail:^{
        
    }];

}




@end
