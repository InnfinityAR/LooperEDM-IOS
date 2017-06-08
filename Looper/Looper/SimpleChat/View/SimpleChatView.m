//
//  SimpleChatView.m
//  Looper
//
//  Created by lujiawei on 2/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SimpleChatView.h"
#import "SimpleChatViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "SimpleChatCollectionViewCell.h"
#import "XDRefresh.h"

@implementation SimpleChatView{
    
    UITextField* text;
    UICollectionView *_collectView;
    NSMutableArray *chatArray;
    
    XDRefreshHeader *_header;
    XDRefreshFooter *_footer;

    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (SimpleChatViewModel*)idObject;
        [self initView];
    }
    return self;
}



-(void)removeAllAction{

    _header=nil;
    _footer=nil;
    [_collectView removeFromSuperview];

    

}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag == 200){
        
        [self removeAllAction];
        [_obj popController];
    
    }else if(button.tag==2001){
        [_obj sendMessage:text.text];
        
        [self endEditing:YES];
        
        text.text = @"";

    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"%f",scrollView.contentOffset.y);

}



-(void)addChatObjWith:(NSArray *)chatDataArray{
    
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([[obj1 objectForKey:@"sentTime"] intValue] > [[obj2 objectForKey:@"sentTime"] intValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([[obj1 objectForKey:@"sentTime"] intValue] < [[obj2 objectForKey:@"sentTime"] intValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [chatArray addObjectsFromArray:chatDataArray];
        chatArray=[[NSMutableArray alloc] initWithArray:[(NSArray*)chatArray sortedArrayUsingComparator:cmptr]];
        [_collectView reloadData];
        [self performSelector:@selector(updataCollectView) withObject:nil afterDelay:0.1];
    });

}

-(void)updataCollectView{

    if(_collectView.contentSize.height>DEF_SCREEN_HEIGHT){
    
    
        [_collectView setContentOffset:CGPointMake(0, _collectView.contentSize.height - _collectView.frame.size.height) animated:NO];

    }
    
    

}

-(void)addChatObj:(NSDictionary *)chatData{

    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([[obj1 objectForKey:@"sentTime"] intValue] > [[obj2 objectForKey:@"sentTime"] intValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([[obj1 objectForKey:@"sentTime"] intValue] < [[obj2 objectForKey:@"sentTime"] intValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };

    dispatch_async(dispatch_get_main_queue(), ^{
        [chatArray addObject:chatData];
        
        chatArray=[[NSMutableArray alloc] initWithArray:[(NSArray*)chatArray sortedArrayUsingComparator:cmptr]];
        [_collectView reloadData];
    });
}

- (void)scrollTap:(id)sender {
    [self endEditing:YES];
}

-(void)createColloctionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,131*0.5*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-131*0.5*DEF_Adaptation_Font-98/2) collectionViewLayout:layout];
    [_collectView registerClass:[SimpleChatCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    _collectView.dataSource = self;
    _collectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectView.delegate = self;
    _collectView.scrollsToTop =YES;
    _collectView.scrollEnabled = YES;
    _collectView.showsVerticalScrollIndicator = FALSE;
    _collectView.showsHorizontalScrollIndicator = FALSE;
    //[_collectView setBackgroundColor:[UIColor clearColor]];
    
    [_collectView setBackgroundColor:[UIColor colorWithRed:55/255.0 green:49/255.0 blue:80/255.0 alpha:1.0]];
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [_collectView addGestureRecognizer:myTap];
    
    [self addFooterAndHeader];

    [self addSubview:_collectView];
}

-(void)addFooterAndHeader{
    
    __weak typeof(self) weakSelf = self;
    
    // 下拉加载数据的方法
    _header =  [XDRefreshHeader headerOfScrollView:_collectView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_footer resetNoMoreData];
                [_header endRefreshing];
            });
        });
    }];
    
    [_header beginRefreshing];
    
    _footer = [XDRefreshFooter footerOfScrollView:_collectView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_footer endRefreshing];
            });
        });
    }];
    
}



-(int)getYWithForContentStr:(NSString*)contentStr{
    
    float num_x =0;
    NSString *perchar;
    int alength = [contentStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [contentStr characterAtIndex:i];
        NSString *temp = [contentStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            num_x = num_x+26*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>64)&&(commitChar<91)){
            num_x = num_x +23*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>96)&&(commitChar<123)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>47)&&(commitChar<58)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else{
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }
    }
    int num_y = num_x/(330*DEF_Adaptation_Font_x*0.5);
    
    if(num_x>(330*DEF_Adaptation_Font_x*0.5)){
        return num_y+1;
        
    }else{
        return 1;
    }
    return num_y+1;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self endEditing:true];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [chatArray objectAtIndex:[indexPath row]];
    
    bool isHasTime=false;
    if([indexPath row]==0){
    
        isHasTime = true;
    }else{
        if([[dic objectForKey:@"sentTime"] intValue]>[[[chatArray objectAtIndex:([indexPath row]-1)] objectForKey:@"sentTime"] intValue]+300){
            isHasTime = true;
        }
    }
    int num_y = [self getYWithForContentStr:[dic objectForKey:@"text"]];

    if(isHasTime==true){
         return CGSizeMake(DEF_SCREEN_WIDTH,(80+32*num_y)*DEF_Adaptation_Font*0.5+54*DEF_Adaptation_Font*0.5);
    }else{
         return CGSizeMake(DEF_SCREEN_WIDTH,(80+32*num_y)*DEF_Adaptation_Font*0.5);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
 }

//设置每个item与上左下右四个方向的间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(0,0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


#pragma UICollectionViewDataSource  代理方法----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [chatArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HomeCellView";
    SimpleChatCollectionViewCell * cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[SimpleChatCollectionViewCell alloc]init];
    }else{
        
    }
    NSDictionary *dic = [chatArray objectAtIndex:[indexPath row]];
    
    bool isHasTime=false;
    if([indexPath row]==0){
        
        isHasTime = true;
    }else{
        if([[dic objectForKey:@"sentTime"] intValue]>[[[chatArray objectAtIndex:([indexPath row]-1)] objectForKey:@"sentTime"] intValue]+300){
            isHasTime = true;
        }
    }
    [cell initCellWithData:dic and:self and:isHasTime];
    return cell;
}


-(void)updateWithTargetView:(NSDictionary*)targetDic{
    
    UILabel *targetName = [LooperToolClass createLableView:CGPointMake(294*DEF_Adaptation_Font_x*0.5, 56*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(233*DEF_Adaptation_Font_x*0.5, 29*DEF_Adaptation_Font_x*0.5) andText:@"聊天" andFontSize:14 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
    [self addSubview:targetName];
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.frame = CGRectMake(0, -frame.size.height, self.frame.size.width, self.frame.size.height);
}

-(void)keyboardWillHidden:(NSNotification *)notification
{
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)initView{
    
    chatArray  = [[NSMutableArray alloc] initWithCapacity:50];
    
    [self setBackgroundColor:[UIColor colorWithRed:55/255.0 green:49/255.0 blue:80/255.0 alpha:1.0]];
    
    UIButton *backBtn =[LooperToolClass createBtnImageName:@"btn_simple_back.png" andRect:CGPointMake(16, 46) andTag:200 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: backBtn];
    
    UIImageView *line=[LooperToolClass createImageView:@"new_line_up.png" andRect:CGPointMake(0, 127) andTag:100 andSize:CGSizeMake(632*DEF_Adaptation_Font_x*0.5, 2*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:line];
    
    UIImageView * bkView = [[UIImageView alloc] initWithFrame:CGRectMake(0,DEF_SCREEN_HEIGHT-98/2,DEF_SCREEN_WIDTH,98/2)];
    [bkView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [self addSubview:bkView];
    
    
    UIImageView *downline=[LooperToolClass createImageViewReal:@"donw_line_simple.png" andRect:CGPointMake(0,DEF_SCREEN_HEIGHT-98/2) andTag:100 andSize:CGSizeMake(632*DEF_Adaptation_Font_x*0.5, 2*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    
    [self addSubview:downline];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
    UIImageView *downBk=[LooperToolClass createImageView:@"bk_chat.png" andRect:CGPointMake(0, 1053) andTag:100 andSize:CGSizeMake(632*DEF_Adaptation_Font_x*0.5, 2*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:downBk];

    
    UIButton *sendMessage =[LooperToolClass createBtnImageName:@"btn_sendMessage.png" andRect:CGPointMake(505, 1066) andTag:2001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: sendMessage];
    

    text=[self createTextField:@"  聊点什么呢" andImg:@"new_text.png" andRect:CGRectMake(25*DEF_Adaptation_Font*0.5,1066*DEF_Adaptation_Font*0.5,464*DEF_Adaptation_Font*0.5,63*DEF_Adaptation_Font*0.5) andTag:1001];
    
    
    [self createColloctionView];

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self endEditing:true];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_obj sendMessage:textField.text];

    [self endEditing:YES];

    textField.text = @"";
    
    return YES;
}


-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    bgView.image = [UIImage imageNamed:image];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(3,0,  rect.size.width, rect.size.height)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor colorWithRed:195/255.0 green:119/255.0 blue:211/255.0 alpha:1.0];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    textField.enablesReturnKeyAutomatically = YES;
    textField.returnKeyType = UIReturnKeySend;
    
    
    textField.delegate = self;
    [bgView  addSubview:textField];
    
    return textField;
}


@end
