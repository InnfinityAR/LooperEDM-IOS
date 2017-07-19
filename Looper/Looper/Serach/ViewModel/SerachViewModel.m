//
//  SerachViewModel.m
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SerachViewModel.h"
#import "SerachViewController.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "AFNetworkTool.h"
#import "looperViewController.h"
#import "DataHander.h"
#import "MainViewController.h"
#import "SimpleChatViewController.h"


@implementation SerachViewModel{


    NSMutableArray *serachArray;

}

@synthesize obj = _obj;
@synthesize SerachV = _SerachV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (SerachViewController*)controller;
        [self initView];
    }
    return  self;
}


-(void)initView{    

    

    _SerachV = [[SerachView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:_SerachV];

}


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(void)serachStr:(NSString*)setachStr{
    
    
    if([self isBlankString:setachStr]==false){
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:setachStr forKey:@"name"];
    
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"searchLoop" parameters:dic  success:^(id responseObject) {

        if([responseObject[@"status"] intValue]==0){
            serachArray = [responseObject[@"data"] objectForKey:@"Loop"];
            [_SerachV reloadTableData:serachArray andUserArray:[responseObject[@"data"] objectForKey:@"User"]];
            
            if([serachArray count]==0){
                
            
                [[DataHander sharedDataHander] showViewWithStr:@"找不到喔，自己创建一个吧~" andTime:1 andPos:CGPointZero];
            }
        }
    }fail:^{
        
    }];
    }else{
    
         [[DataHander sharedDataHander] showViewWithStr:@"写点东西再来搜吧" andTime:1 andPos:CGPointZero];
    
    }
}

-(void)createUserView:(NSDictionary *)userData{

    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:userData];
    [[_obj navigationController]  pushViewController:simpleC animated:NO];


}



-(void)movelooperPos:(NSDictionary *)loopData{
    //[_obj dismissViewControllerAnimated:YES completion:nil];
    looperViewController *looperV = [[looperViewController alloc] init];
    
    [looperV initWithData:loopData];
    
    [[_obj navigationController]  pushViewController:looperV animated:YES];
    
}



-(void)popController{
    
  
   //   [_obj dismissViewControllerAnimated:YES completion:nil];
    [[_obj navigationController] popViewControllerAnimated:NO];
    
 //[_obj presentViewController:serachV animated:YES completion:nil];
    
}



@end


