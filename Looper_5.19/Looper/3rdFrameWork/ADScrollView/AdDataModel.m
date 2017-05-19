//
//  AdDataModel.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdDataModel.h"

#define PLISTFILENAME @"AdDataPlist.plist"

#define PATH  [[NSBundle mainBundle]pathForResource:PLISTFILENAME ofType:nil]

@implementation AdDataModel

- (instancetype)initWithImageName:(NSArray*)images
{
    self = [super init];
    if (self)
    {
        //_imageNameArray = [NSArray arrayWithContentsOfFile:PATH][0];
        _imageNameArray = @[@"main_1.png",@"main_2.png",@"main_3.png",@"main_4.png"];
       // _imageNameArray = images;
    }
    return self;
}

- (instancetype)initWithImageNameAndAdTitleArray:(NSArray*)images
{
    _adTitleArray = [NSArray arrayWithContentsOfFile:PATH][1];
    _adTitleArray = @[@"1",@"2",@"3",@"4",@"5",];
    return [self initWithImageName:images];
}

+ (id)adDataModelWithImageName:(NSArray*)images
{
    return [[self alloc]initWithImageName:images];
}

+ (id)adDataModelWithImageNameAndAdTitleArray:(NSArray*)images
{
    return [[self alloc]initWithImageNameAndAdTitleArray:images];
}
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
