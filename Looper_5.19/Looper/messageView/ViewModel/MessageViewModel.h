//
//  MessageViewModel.h
//  Looper
//
//  Created by lujiawei on 29/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageViewModel : NSObject{

    id obj;
    

}
@property (nonatomic )id obj;
@property (nonatomic )NSDictionary *messageData;

-(id)initWithController:(id)controller;
-(void)popController;
@end
