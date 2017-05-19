//
//  SerachViewModel.m
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SimpleChatViewModel.h"
#import "SimpleChatViewController.h"
#import "SimpleChatView.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "RongCloudManger.h"
#import "NIMCloudMander.h"
#import "DataHander.h"


@implementation SimpleChatViewModel{

    NSDictionary *targetDic;
    
    
    
}

@synthesize obj = _obj;
@synthesize  SimpleChatV = _SimpleChatV;
@synthesize targetID = _targetID;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (SimpleChatViewController*)controller;
        [self createSimpleChatV];
    }
    return  self;
}

-(void)createSimpleChatV{
  //  [[RongCloudManger sharedManager] joinCharRoom:self];
    
    [[NIMCloudMander sharedManager] joinCharRoom:self];
    _SimpleChatV = [[SimpleChatView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view]addSubview:_SimpleChatV];

}


-(void)popController{

    
    [_obj dismissViewControllerAnimated:YES completion:nil];
    
    
    [[_obj navigationController] popViewControllerAnimated:YES];

}


-(void)removeSimpleAction{

    [_SimpleChatV removeAllAction];
}


-(void)ReceiveMessageArray:(NSArray*)data{

    
     [_SimpleChatV addChatObjWith:data];

}


-(void)setTargetIDChat:(NSDictionary*)targetDic{

    _targetID = [targetDic objectForKey:@"userid"];

     [_SimpleChatV updateWithTargetView:targetDic];

    [[NIMCloudMander sharedManager] fetchMessageHistory:0 andTargetId:_targetID];

}


-(void)sendMessage:(NSString*)messageStr{
    
    
    if([messageStr length]!=0){

      [[NIMCloudMander sharedManager] sendMessage:messageStr andType:0 andTargetId:_targetID];
    
    }else{
    
        [[DataHander sharedDataHander] showViewWithStr:@"输入的不能为空" andTime:1 andPos:CGPointZero];
    
    }
}


-(void)ReceiveMessage:(NSDictionary*)data{
    
    NSLog(@"%@",data);
    
    [_SimpleChatV addChatObj:data];
    
    


}





@end


