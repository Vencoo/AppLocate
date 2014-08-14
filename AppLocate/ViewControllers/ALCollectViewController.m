//
//  ALCollectViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-14.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALCollectViewController.h"
#import "ALCollectViewCell.h"

@interface ALCollectViewController ()
{
    UILabel *_label;
    UICollectionView *_collectView;
}
@end

@implementation ALCollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?20:0, kDeviceWidth, 50)];
    _label.text = @"收藏界面";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_label];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _label.bottom, kDeviceWidth, KDeviceHeight) collectionViewLayout:flowLayout];
    _collectView.dataSource = self;
    _collectView.delegate = self;
    _collectView.backgroundColor = [UIColor whiteColor];
    [_collectView registerClass:[ALCollectViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:_collectView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 120);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALCollectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.label.text = @"欧美顶级品牌直销店★特价88元LV顶级皮具皮革清洗";
    cell.label.font = [UIFont systemFontOfSize:10];
    cell.label.lineBreakMode = NSLineBreakByWordWrapping;
    cell.label.lineBreakMode = NSLineBreakByTruncatingMiddle;
    cell.label.numberOfLines = 0;
    
    return cell;

}

@end
