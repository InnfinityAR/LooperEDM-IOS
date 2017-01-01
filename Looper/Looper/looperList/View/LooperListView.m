//
//  LooperListView.m
//  Looper
//
//  Created by lujiawei on 4/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LooperListView.h"
#import "LooperListViewModel.h"
#import "LooperConfig.h"
#import "looperlistCellCollectionViewCell.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "UICollectionViewLeftAlignedLayout.h"


@implementation LooperListView {


    bool ActionUp;
    UICollectionView *_collectView;
    UIView *tagView;
    
    NSMutableArray *tabBtnArray;
    
    UIView *lableView;
    NSMutableArray *btnArray;

    UILabel *recommendLabel;
    UILabel *newLabel;
    UILabel *otherLabel;
    
    NSMutableArray *ListArray;
    UIImageView *moveline;
    
    float temp_num_y;

    
    int indexNum;
    
}
@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (LooperListViewModel*)idObject;
        [self initView];
       
        
    }
    return self;
    
}


-(void)reloadData{
    ListArray =[[NSMutableArray alloc] initWithCapacity:50];

    for (int i=0;i<=15;i++){
        UIButton *btn = [btnArray objectAtIndex:i];
        btn.alpha=0.0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _collectView.frame = CGRectMake(_collectView.frame.origin.x, 161*DEF_Adaptation_Font*0.5, _collectView.frame.size.width, _collectView.frame.size.height);
        lableView.frame = CGRectMake(0, 100*DEF_Adaptation_Font*0.5, lableView.frame.size.width, lableView.frame.size.height);

       // [tagView setHidden:true];
    }];
    ActionUp=false;
    
    [self integratingData];
    
}


-(void)setAllBtnDefalut{
    for (int i=0; i<[btnArray count]; i++) {
        UIButton *btn = [btnArray objectAtIndex:i];
        [btn setSelected:false];
        
        UILabel *label = (UILabel*)[btn viewWithTag:1000];
        [label setTextColor:[UIColor whiteColor]];
    }
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==200){
    
        [_obj backFrontView];
    
    }else if(button.tag==201){
         [_obj toCreateLooperView];
    
    }else if(button.tag>=0 && button.tag<19){
        [self setAllBtnDefalut];
         [self setDefaultLableColor];
        [button setSelected:true];
        UILabel *label = (UILabel*)[button viewWithTag:1000];
        [label setTextColor:[UIColor blackColor]];
        
        [_obj requestData:label.text andType:1];
        
        [otherLabel setText:label.text];
        [otherLabel setTextColor:[UIColor whiteColor]];
        [self actionMoveDown];
        [moveline setHidden:false];
        [UIView animateWithDuration:0.5 animations:^{
            moveline.frame =CGRectMake(265*0.5*DEF_Adaptation_Font, moveline.frame.origin.y, 45*DEF_Adaptation_Font*0.5*2, moveline.frame.size.height);
        }];
    }
}



-(void)initView{
    temp_num_y  = 0.0f;
    ActionUp = false;
    btnArray =[[NSMutableArray alloc] initWithCapacity:50];

    [self setBackgroundColor:[UIColor colorWithRed:36/255.0 green:30/255.0 blue:43/255.0 alpha:1.0]];
   
    [self createCollectionView];
    
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:200 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];

    UILabel *title = [LooperToolClass createLableView:CGPointMake(247*DEF_Adaptation_Font_x*0.5, 59*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(160*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"LOOP 圈" andFontSize:13 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:title];
    [self createMoveTag];
    
}

-(void)setDefaultLableColor{
    [recommendLabel setTextColor:[UIColor colorWithRed:133/255.0 green:119/255.0 blue:137/255.0 alpha:1.0]];
    [newLabel setTextColor:[UIColor colorWithRed:133/255.0 green:119/255.0 blue:137/255.0 alpha:1.0]];
    [otherLabel setTextColor:[UIColor colorWithRed:133/255.0 green:119/255.0 blue:137/255.0 alpha:1.0]];


}

-(void)onClickLable:(UITapGestureRecognizer *)tap{
    
    [self setDefaultLableColor];
    
    
    UILabel *v = (UILabel*)tap.view;
    
    [v setTextColor:[UIColor whiteColor]];
    
     [self actionMoveDown];
    
    if(tap.view.tag==1){
         [moveline setHidden:false];
        [UIView animateWithDuration:0.5 animations:^{
            
            moveline.frame =CGRectMake(50*0.5*DEF_Adaptation_Font, moveline.frame.origin.y, 45*DEF_Adaptation_Font*0.5, moveline.frame.size.height);
        }];
        [_obj requestData:@"" andType:3];
    }else if(tap.view.tag==2){
         [moveline setHidden:false];
        [UIView animateWithDuration:0.5 animations:^{
            
            moveline.frame =CGRectMake(164*0.5*DEF_Adaptation_Font, moveline.frame.origin.y,  45*DEF_Adaptation_Font*0.5, moveline.frame.size.height);
        }];
        [_obj requestData:@"" andType:2];
        
    }else if(tap.view.tag==3){
         [moveline setHidden:false];
        [UIView animateWithDuration:0.5 animations:^{
            moveline.frame =CGRectMake(265*0.5*DEF_Adaptation_Font, moveline.frame.origin.y, 45*DEF_Adaptation_Font*0.5*2, moveline.frame.size.height);
        }];
        
    }
}



-(UILabel*)createLabelBtn:(NSString*)labelStr and:(CGSize)size andPos:(CGPoint)point andTag:(int)tag{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x*DEF_Adaptation_Font*0.5, point.y*DEF_Adaptation_Font*0.5, size.width*DEF_Adaptation_Font*0.5, size.height*DEF_Adaptation_Font*0.5)];
    [label setText:labelStr];
    [label setTextColor:[UIColor colorWithRed:133/255.0 green:119/255.0 blue:137/255.0 alpha:1.0]];
    
    [label setFont:[UIFont fontWithName:looperFont size:14]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTag:tag];
     label.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickLable:)];
    [label addGestureRecognizer:singleTap];
    
    return label;

}


-(void)createMoveTag{

    tagView = [[UIView alloc] initWithFrame:CGRectMake(0, 80*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 287*DEF_Adaptation_Font*0.5)];
    [self addSubview:tagView];
    NSMutableArray *tagDate=[_obj tagData];
    for (int i=0;i<[tagDate count];i++){
        
        int num = i +1;
        int num_x = num%4;
        int num_y = ceil(num/4.0);
        if(num_x==0){
            num_x=4;
        }
        UIButton *selBtn =[LooperToolClass createBtnImageName:@"btn_looper_sel.png" andRect:CGPointMake(23+(162*(num_x-1)), 0+((num_y-1)*72)) andTag:i andSelectImage:@"btn_looper_select.png" andClickImage:nil andTextStr:[tagDate objectAtIndex:i] andSize:CGSizeZero andTarget:self];
        [selBtn setAlpha:0.0];
        [tagView addSubview: selBtn];
        
        [btnArray addObject:selBtn];
        
        
    }
    
    lableView = [[UIView alloc]initWithFrame:CGRectMake(0, 100*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 64*DEF_Adaptation_Font*0.5)];
    [self addSubview:lableView];
   

    recommendLabel=[self createLabelBtn:@"推荐" and:CGSizeMake(70, 24)andPos:CGPointMake(40, 25)andTag:1];
    [lableView addSubview:recommendLabel];
    newLabel=[self createLabelBtn:@"最新" and:CGSizeMake(120, 24)andPos:CGPointMake(130, 25 )andTag:2];
    [lableView addSubview:newLabel];
    otherLabel=[self createLabelBtn:@"" and:CGSizeMake(120, 24)andPos:CGPointMake(250, 25) andTag:3];
    [lableView addSubview:otherLabel];
    
    
    [recommendLabel setTextColor:[UIColor whiteColor]];
    
    moveline=[LooperToolClass createImageView:@"movelineV1.png" andRect:CGPointMake(50, 59) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    moveline.frame=CGRectMake(50*DEF_Adaptation_Font*0.5,59*DEF_Adaptation_Font*0.5, 45*DEF_Adaptation_Font*0.5,3*DEF_Adaptation_Font*0.5);
    
    [lableView addSubview:moveline];
    
    
}

-(void)actionMoveUp{
    if(ActionUp==false){
        [UIView animateWithDuration:0.2 animations:^{
            _collectView.frame = CGRectMake(_collectView.frame.origin.x, 161*DEF_Adaptation_Font*0.5+300*DEF_Adaptation_Font*0.5, _collectView.frame.size.width, _collectView.frame.size.height);
            lableView.frame = CGRectMake(0, 397*DEF_Adaptation_Font*0.5, lableView.frame.size.width, lableView.frame.size.height);
           // [tagView setHidden:false];
        }];
        ActionUp=true;
    }
}

-(void)actionMoveDown{
    if(ActionUp==true){
        [UIView animateWithDuration:0.2 animations:^{
            _collectView.frame = CGRectMake(_collectView.frame.origin.x, 161*DEF_Adaptation_Font*0.5, _collectView.frame.size.width, _collectView.frame.size.height);
            lableView.frame = CGRectMake(0, 100*DEF_Adaptation_Font*0.5, lableView.frame.size.width, lableView.frame.size.height);
            //[tagView setHidden:true];
        }];
        ActionUp=false;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float num_y= scrollView.frame.origin.y;
    
    
    if(num_y<161*DEF_Adaptation_Font*0.5+150*DEF_Adaptation_Font*0.5){
        
        [UIView animateWithDuration:0.2 animations:^{
            _collectView.frame = CGRectMake(_collectView.frame.origin.x, 161*DEF_Adaptation_Font*0.5, _collectView.frame.size.width, _collectView.frame.size.height);
            lableView.frame = CGRectMake(0, 100*DEF_Adaptation_Font*0.5, lableView.frame.size.width, lableView.frame.size.height);
        }];
        
        for (int i=0;i<=15;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=0.0;
        }
        
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            _collectView.frame = CGRectMake(_collectView.frame.origin.x,161*DEF_Adaptation_Font*0.5+300*DEF_Adaptation_Font*0.5, _collectView.frame.size.width, _collectView.frame.size.height);
            lableView.frame = CGRectMake(0, 397*DEF_Adaptation_Font*0.5, lableView.frame.size.width, lableView.frame.size.height);
        }];
        
        for (int i=0;i<=15;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=1.0;
        }
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView{
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll %f",scrollView.contentOffset.y);

    
    bool isdirection=false;
    
    if(scrollView.contentOffset.y>temp_num_y){
    
        isdirection= false;
    }else{
    
        isdirection= true;

    }
    
    CGPoint point =  [scrollView.panGestureRecognizer translationInView:self];
    if (point.y > 0 ) {

        if(161*DEF_Adaptation_Font*0.5+300*DEF_Adaptation_Font*0.5>scrollView.frame.origin.y && scrollView.contentOffset.y<=0){
            [self updataScrollView:temp_num_y-scrollView.contentOffset.y];
            [self updateTagView:scrollView.frame.origin.y andPoint:isdirection];
        }
    }else{
        [self updataScrollView:temp_num_y-scrollView.contentOffset.y];
        [self updateTagView:scrollView.frame.origin.y andPoint:isdirection];
    }
    
    temp_num_y = scrollView.contentOffset.y;
    
    
    [self updataTabViewAlpha:isdirection];
}

-(void)updataTabViewAlpha:(bool)isdirection{

    float scrollOffSet_Y = _collectView.frame.origin.y - 116*DEF_Adaptation_Font*0.5;

    float num_y = scrollOffSet_Y/(300*DEF_Adaptation_Font*0.5);

        tagView.frame= CGRectMake(tagView.frame.origin.x, 80*DEF_Adaptation_Font*0.5 +(45*DEF_Adaptation_Font*0.5*num_y), tagView.frame.size.width, tagView.frame.size.height);

}



-(void)updateTagView:(float)scroll_y andPoint:(bool)isdirection{
    
    if((161*DEF_Adaptation_Font*0.5+75*DEF_Adaptation_Font*0.5)>scroll_y && scroll_y>161*DEF_Adaptation_Font*0.5){
        float alpha = (scroll_y-161*DEF_Adaptation_Font*0.5)/75*DEF_Adaptation_Font*0.5;
        for (int i=0;i<=3;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=alpha;
        }
        
        if(isdirection){
            
            
        }else{
            for (int i=4;i<=15;i++){
                UIButton *btn = [btnArray objectAtIndex:i];
                btn.alpha=0.0;
            }
        
        }
        
    }else if(((161*DEF_Adaptation_Font*0.5+150*DEF_Adaptation_Font*0.5)>scroll_y) &&( scroll_y>(161*DEF_Adaptation_Font*0.5+75*DEF_Adaptation_Font*0.5))){
        float alpha = (scroll_y-(161*DEF_Adaptation_Font*0.5+75*DEF_Adaptation_Font*0.5))/75*DEF_Adaptation_Font*0.5;
        for (int i=4;i<=7;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=alpha;
        }
        if(isdirection){
            for (int i=0;i<=3;i++){
                UIButton *btn = [btnArray objectAtIndex:i];
                btn.alpha=1.0;
            }
            
        }else{
            for (int i=8;i<=15;i++){
                UIButton *btn = [btnArray objectAtIndex:i];
                btn.alpha=0.0;
            }
            
        }
        
    }else if((161*DEF_Adaptation_Font*0.5+225*DEF_Adaptation_Font*0.5)>scroll_y && scroll_y>(161*DEF_Adaptation_Font*0.5+150*DEF_Adaptation_Font*0.5)){
        
        float alpha = (scroll_y-(161*DEF_Adaptation_Font*0.5+150*DEF_Adaptation_Font*0.5))/75*DEF_Adaptation_Font*0.5;
        for (int i=8;i<=11;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=alpha;
        }
        
        if(isdirection){
            for (int i=0;i<=7;i++){
                UIButton *btn = [btnArray objectAtIndex:i];
                btn.alpha=1.0;
            }
        }else{
            for (int i=12;i<=15;i++){
                UIButton *btn = [btnArray objectAtIndex:i];
                btn.alpha=0.0;
            }
            
        }
    }else if((161*DEF_Adaptation_Font*0.5+280*DEF_Adaptation_Font*0.5)>scroll_y && scroll_y>(161*DEF_Adaptation_Font*0.5+225*DEF_Adaptation_Font*0.5)){
        float alpha = (scroll_y-(161*DEF_Adaptation_Font*0.5+225*DEF_Adaptation_Font*0.5))/40*DEF_Adaptation_Font*0.5;
        
        if(40*DEF_Adaptation_Font*0.5<(scroll_y-(161*DEF_Adaptation_Font*0.5+225*DEF_Adaptation_Font*0.5))){
            alpha = 1.0;
        }
        for (int i=12;i<=15;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=alpha;
        }
        if(isdirection){
            for (int i=0;i<=11;i++){
                UIButton *btn = [btnArray objectAtIndex:i];
                btn.alpha=1.0;
            }
        }else{
            
            
        }
    }
}


-(void)updataScrollView:(float)point_Y{
    NSLog(@"%f",_collectView.frame.origin.y);
    if(161*DEF_Adaptation_Font*0.5<_collectView.frame.origin.y+point_Y && 161*DEF_Adaptation_Font*0.5+300*DEF_Adaptation_Font*0.5>_collectView.frame.origin.y+point_Y){
         lableView.frame = CGRectMake(0,lableView.frame.origin.y+point_Y,lableView.frame.size.width, lableView.frame.size.height);
        _collectView.frame = CGRectMake(_collectView.frame.origin.x, _collectView.frame.origin.y+point_Y, _collectView.frame.size.width, _collectView.frame.size.height);
    }else if(161*DEF_Adaptation_Font*0.5>_collectView.frame.origin.y+point_Y){
        _collectView.frame = CGRectMake(_collectView.frame.origin.x, 161*DEF_Adaptation_Font*0.5, _collectView.frame.size.width, _collectView.frame.size.height);
        lableView.frame = CGRectMake(0, 100*DEF_Adaptation_Font*0.5, lableView.frame.size.width, lableView.frame.size.height);
        for (int i=0;i<=15;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=0.0;
        }
    }else if (161*DEF_Adaptation_Font*0.5+300*DEF_Adaptation_Font*0.5<=_collectView.frame.origin.y+point_Y){
        _collectView.frame = CGRectMake(_collectView.frame.origin.x,161*DEF_Adaptation_Font*0.5+300*DEF_Adaptation_Font*0.5, _collectView.frame.size.width, _collectView.frame.size.height);
        lableView.frame = CGRectMake(0, 397*DEF_Adaptation_Font*0.5, lableView.frame.size.width, lableView.frame.size.height);

        for (int i=0;i<=15;i++){
            UIButton *btn = [btnArray objectAtIndex:i];
            btn.alpha=1.0;
        }
        
    }
}

-(void)integratingData{
    [ListArray removeAllObjects];
    
    NSArray *array=[[NSArray alloc] initWithArray:[[_obj loopListData] objectForKey:@"data"]];
    
    if([array count]!=0){
        int localNum=[array count];
        indexNum =0;
        while(localNum>3){
            int rand = arc4random() % 2;
            if(rand==0){
                localNum = localNum-3;
                [self addViewObject:3];
            }else if(rand==1){
                localNum = localNum-2;
                [self addViewObject:2];
                
            }
        }
        [self addViewObject:localNum];
    }
    [_collectView reloadData];
    //int dataNum = [array count];
  }

-(void)addViewObject:(int)num{
    
    NSArray *array=[[NSArray alloc] initWithArray:[[_obj loopListData] objectForKey:@"data"]];
    
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithCapacity:50];
    
    for (int i=0;i<num;i++){
        NSDictionary *dic = [array objectAtIndex:indexNum+i];
        [tempArray addObject:dic];
    }
    if(num==3){
        [tempArray addObject:@"3"];
    }else if(num==2){
        [tempArray addObject:@"2"];
    }else if(num==1){
        [tempArray addObject:@"3"];
    }
    
    [ListArray addObject:tempArray];
    indexNum = indexNum +num;
}


- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}


-(void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     layout.minimumInteritemSpacing = 0.0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     layout.sectionInset = UIEdgeInsetsMake(0, 0, 2, 2);
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 161*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-161*DEF_Adaptation_Font*0.5) collectionViewLayout:layout];
    [_collectView registerClass:[looperlistCellCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    _collectView.dataSource = self;
    _collectView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    _collectView.delegate = self;
    _collectView.alwaysBounceVertical = YES;

    _collectView.scrollsToTop =YES;
    _collectView.scrollEnabled = YES;
    _collectView.showsVerticalScrollIndicator = FALSE;
    _collectView.showsHorizontalScrollIndicator = FALSE;
    [_collectView setBackgroundColor:[UIColor clearColor]];

    [self addSubview:_collectView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    NSArray *array = [ListArray objectAtIndex:indexPath.row];

    if([[array objectAtIndex:[array count]-1] intValue]==3){
        return CGSizeMake(DEF_SCREEN_WIDTH, 708*DEF_Adaptation_Font*0.5);
    
    }else if([[array objectAtIndex:[array count]-1] intValue]==2){
        return CGSizeMake(DEF_SCREEN_WIDTH, 532*DEF_Adaptation_Font*0.5);
        
    }else if([array count]==1){
    
    }
    return  CGSizeZero;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
    
}

//设置每个item与上左下右四个方向的间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(0,0, 2, 2);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


-(void)onClickImage:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%d",tap.view.tag);
    
    NSArray *array=[[NSArray alloc] initWithArray:[[_obj loopListData] objectForKey:@"data"]];
    for(int i=0;i<[array count];i++){
    
        NSDictionary *dic = [array objectAtIndex:i];
        
        if([[dic objectForKey:@"n_id"] intValue]==tap.view.tag){
        
             [_obj toLooperView:dic];
            return;
        }
    }
}


#pragma UICollectionViewDataSource  代理方法----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ListArray count];
}


-(UIImageView*)createImageBtn:(NSString*)url andTag:(int)Tag andSize:(CGSize)size andPoint:(CGPoint)point{

    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(point.x,point.y,size.width, size.height)];
    [imageV sd_setImageWithURL:[[NSURL alloc] initWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    imageV.tag =Tag;
    
    imageV.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [imageV addGestureRecognizer:singleTap];
    
    UIImageView *shade = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,size.width, size.height)];
    shade.image = [UIImage imageNamed:@"loopshade.png"];
    [imageV addSubview:shade];

    return imageV;
}


-(UILabel*)createLabel:(NSString*)str andPoint:(CGPoint)point andSize:(CGSize)size andFontSize:(int)fontSize{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x*DEF_Adaptation_Font*0.5, point.y*DEF_Adaptation_Font*0.5, size.width*DEF_Adaptation_Font*0.5, size.height*DEF_Adaptation_Font*0.5)];
    [label setText:str];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:looperFont size:fontSize]];
    label.shadowColor = [UIColor colorWithRed:36/255.0 green:30/255.0 blue:43/255.0 alpha:1.0];
    //阴影偏移  x，y为正表示向右下偏移
    label.shadowOffset = CGSizeMake(1, 1);
    label.numberOfLines=0;
    return label;

}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HomeCellView";
    looperlistCellCollectionViewCell * cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (!cell) {
        cell = [[looperlistCellCollectionViewCell alloc]init];
    }else{
        
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    
   
    NSArray *array =[ListArray objectAtIndex:indexPath.row];
    
    
    int num = [[array objectAtIndex:[array count]-1] intValue];
    
    if(num==2){
        for (int i =0;i<[array count]-1;i++){
            NSDictionary *dic = [array objectAtIndex:i];
            
            if(i==0){
                [cell.contentView addSubview:[self createImageBtn:[dic objectForKey:@"news_img2"] andTag:[[dic objectForKey:@"n_id"] intValue] andSize:CGSizeMake( cell.frame.size.width/2,  cell.frame.size.height) andPoint:CGPointMake(0, 0)]];
                
                [cell.contentView addSubview:[self createLabel:[dic objectForKey:@"news_title"] andPoint:CGPointMake(29, 408) andSize:CGSizeMake(260, 80) andFontSize:15]];
                
                
            }else if(i==1){
                [cell.contentView addSubview:[self createImageBtn:[dic objectForKey:@"news_img2"] andTag:[[dic objectForKey:@"n_id"] intValue] andSize:CGSizeMake( cell.frame.size.width/2,  cell.frame.size.height) andPoint:CGPointMake(cell.frame.size.width/2, 0)]];
                
                [cell.contentView addSubview:[self createLabel:[dic objectForKey:@"news_title"] andPoint:CGPointMake(350, 408) andSize:CGSizeMake(260, 80)  andFontSize:15]];
                
            }
        }
    }else if(num==3){
        if([array count]==2){
            [cell setBackgroundColor:[UIColor clearColor]];
        }
        for (int i =0;i<[array count]-1;i++){
            NSDictionary *dic = [array objectAtIndex:i];
            if(i==0){
                [cell.contentView addSubview:[self createImageBtn:[dic objectForKey:@"news_img2"] andTag:[[dic objectForKey:@"n_id"] intValue] andSize:CGSizeMake(427*DEF_Adaptation_Font*0.5, cell.frame.size.height) andPoint:CGPointMake(0,0)]];
                
                   [cell.contentView addSubview:[self createLabel:[dic objectForKey:@"news_title"] andPoint:CGPointMake(29, 585) andSize:CGSizeMake(386, 72)  andFontSize:18]];
            }else if(i==1){
                [cell.contentView addSubview:[self createImageBtn:[dic objectForKey:@"news_img2"] andTag:[[dic objectForKey:@"n_id"] intValue] andSize:CGSizeMake( 211*DEF_Adaptation_Font*0.5, cell.frame.size.height/2) andPoint:CGPointMake(427*DEF_Adaptation_Font*0.5,0)]];
                
                 [cell.contentView addSubview:[self createLabel:[dic objectForKey:@"news_title"] andPoint:CGPointMake(446, 250) andSize:CGSizeMake(176, 70) andFontSize:13]];
                
            }else if(i==2){
                [cell.contentView addSubview:[self createImageBtn:[dic objectForKey:@"news_img2"] andTag:[[dic objectForKey:@"n_id"] intValue] andSize:CGSizeMake( 211*DEF_Adaptation_Font*0.5, cell.frame.size.height/2) andPoint:CGPointMake(427*DEF_Adaptation_Font*0.5,cell.frame.size.height/2)]];
                
                 [cell.contentView addSubview:[self createLabel:[dic objectForKey:@"news_title"] andPoint:CGPointMake(446, 606) andSize:CGSizeMake(176, 70) andFontSize:13]];
            }
        }
    }
    return cell;
}






@end
