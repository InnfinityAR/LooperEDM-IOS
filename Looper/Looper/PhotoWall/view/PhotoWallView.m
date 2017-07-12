//
//  PhotoWallView.m
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhotoWallView.h"
#import "PhotoWallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "PhotoWallCollectionViewCell.h"

@implementation PhotoWallView{


    UICollectionView *photoWallCollectionV;

    NSMutableDictionary *dataSource;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{


    if (self = [super initWithFrame:frame]) {
        self.obj = (PhotoWallViewModel*)idObject;
        
        
        [self initView];
    }
    return self;
    

}


-(void)createColloectionView{
    
    UICollectionViewFlowLayout *viewFlowLayOut = [[UICollectionViewFlowLayout alloc] init];
    
    photoWallCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) collectionViewLayout:viewFlowLayOut];
    
    [photoWallCollectionV registerClass:[PhotoWallCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    [photoWallCollectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewID"];
    photoWallCollectionV.dataSource = self;
    photoWallCollectionV.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    photoWallCollectionV.delegate = self;
    photoWallCollectionV.alwaysBounceVertical = YES;
    
    photoWallCollectionV.scrollsToTop =YES;
    photoWallCollectionV.scrollEnabled = YES;
    photoWallCollectionV.showsVerticalScrollIndicator = FALSE;
    photoWallCollectionV.showsHorizontalScrollIndicator = FALSE;
    [photoWallCollectionV setBackgroundColor:[UIColor clearColor]];
    [self addSubview:photoWallCollectionV];
}


-(void)createHeaderView{
    
    


}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderViewID" forIndexPath:indexPath];
        //添加头视图的内容
        
        [self createHeaderView];
        
        return header;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(DEF_SCREEN_WIDTH, 590*DEF_Adaptation_Font*0.5);
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  CGSizeMake(DEF_SCREEN_WIDTH, 400*DEF_Adaptation_Font*0.5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


//设置每个item与上左下右四个方向的间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(0,0, 2, 2);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"HomeCellView";
    PhotoWallCollectionViewCell * cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [cell setBackgroundColor:[UIColor blueColor]];
    
    return  cell;
}


-(void)createHudView{
    
    



}


-(void)initView{

    [self setBackgroundColor: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];

    [self createColloectionView];
    
    [self createHudView];



}


@end
