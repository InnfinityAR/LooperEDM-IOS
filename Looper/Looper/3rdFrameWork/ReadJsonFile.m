//
//  ReadJsonFile.m
//  Eleven_frame
//
//  Created by lujiawei on 6/24/16.
//  Copyright © 2016 eleven. All rights reserved.
//

#import "ReadJsonFile.h"

@implementation ReadJsonFile


+(NSMutableDictionary*)readFile:(NSString*)filePath{

    
    NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
    
    NSString *path=[mainBundleDirectory stringByAppendingPathComponent:filePath];
    
    NSURL *url=[NSURL fileURLWithPath:path];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    NSString* aStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *jsonData = [aStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];


    return dic;

    
}

@end
