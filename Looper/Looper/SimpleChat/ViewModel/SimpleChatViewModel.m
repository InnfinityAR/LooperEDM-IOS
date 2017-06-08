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
#import "DataHander.h"
#import "LocalDataMangaer.h"


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
    [[RongCloudManger sharedManager] joinCharRoom:self];
    
  //  [[NIMCloudMander sharedManager] joinCharRoom:self];
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

    
    NSMutableArray *chatArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    
    for (int i=0;i<[data count];i++){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        
        [dic setValue:[[data objectAtIndex:i] objectForKey:@"creationdate"] forKey:@"sentTime"];
       
        [dic setValue:[[data objectAtIndex:i] objectForKey:@"messagecontent"] forKey:@"text"];
        [dic setValue:[[data objectAtIndex:i] objectForKey:@"userid"] forKey:@"senderUserId"];
        

 
        [dic setValue:[[data objectAtIndex:i] objectForKey:@"userimage"] forKey:@"HeadImageUrl"];

        [chatArray addObject:dic];
    
    }
    
    [_SimpleChatV addChatObjWith:chatArray];

}



-(void)getHistoryList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:_targetID forKey:@"targetId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getChatMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            
            [self ReceiveMessageArray:responseObject[@"data"]];
            
        }else{
           
        }
    }fail:^{
        
    }];

}


-(void)setTargetIDChat:(NSDictionary*)targetDic{

    _targetID = [targetDic objectForKey:@"userid"];

     [_SimpleChatV updateWithTargetView:targetDic];

    
    [self getHistoryList];
    
  //  [[NIMCloudMander sharedManager] fetchMessageHistory:0 andTargetId:_targetID];
   // [[RongCloudManger sharedManager] getRomotoHistoryMessage:0 andTargetId:_targetID andRecordTime:0 andMessageCount:100];
    
}


-(void)sendMessage:(NSString*)messageStr{
    
    
    if([messageStr length]!=0){

     // [[NIMCloudMander sharedManager] sendMessage:messageStr andType:0 andTargetId:_targetID];
        
        [[RongCloudManger sharedManager] sendMessage:messageStr andType:0 andTargetId:_targetID andRealTarget:nil andReplyMessageId:nil andReplyMessageText:nil];
        
    
    }else{
    
        [[DataHander sharedDataHander] showViewWithStr:@"输入的不能为空" andTime:1 andPos:CGPointZero];
    
    }
}


-(void)ReceiveMessage:(NSDictionary*)data{
    
    NSLog(@"%@",data);
    
    [_SimpleChatV addChatObj:data];
    
    


}





@end


