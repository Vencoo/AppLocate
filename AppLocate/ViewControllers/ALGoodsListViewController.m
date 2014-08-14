//
//  ALGoodsListViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-11.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALGoodsListViewController.h"
#import "ALGoodsListTableViewCell.h"
#import "CycleScrollView.h"

@interface ALGoodsListViewController ()
{
    UITableView *_tableView;
    UIImageView *_popImageView;
    UITapGestureRecognizer *_tap;
    
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSMutableArray *_images;
    
}


@end

@implementation ALGoodsListViewController

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
    
    _images = [[NSMutableArray alloc] init];
    [_images addObject:@"店铺缩略图.png"];
    [_images addObject:@"image1.png"];
    [_images addObject:@"image2.png"];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, IOSVersion>=7.0?20:0, kDeviceWidth, 120)];
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    for (int i = 0;i<_images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kDeviceWidth+kDeviceWidth,0,kDeviceWidth,_scrollView.frame.size.height)];
        imageView.image = [UIImage imageNamed:[_images objectAtIndex:i]];
        [_scrollView addSubview:imageView];
    }
     // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_images objectAtIndex:([_images count]-1)]]];
    imageView.frame = CGRectMake(0, 0, kDeviceWidth, _scrollView.frame.size.height); // 添加最后1页在首页 循环
    [_scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_images objectAtIndex:0]]];
    imageView.frame = CGRectMake((kDeviceWidth * ([_images count] + 1)) , 0, kDeviceWidth, _scrollView.frame.size.height); // 添加第1页在最后 循环
    [_scrollView addSubview:imageView];
    
    [_scrollView setContentSize:CGSizeMake(320 * ([_images count] + 2), _scrollView.frame.size.height)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(320,0,kDeviceWidth,120) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页

    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,0,100,20)];
    _pageControl.center = CGPointMake(_scrollView.frame.size.width/2.0,IOSVersion>=7.0?_scrollView.frame.size.height+10:_scrollView.frame.size.height-10);
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _images.count;
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _scrollView.bottom,kDeviceWidth,480)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];

}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = _pageControl.currentPage; // 获取当前的page
    [_scrollView scrollRectToVisible:CGRectMake(kDeviceWidth*(page+1),0,kDeviceWidth,_scrollView.frame.size.height) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = _pageControl.currentPage; // 获取当前的page
    page++;
    page = page > (_images.count-1) ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pagewidth/([_images count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    _pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = _scrollView.frame.size.width;
    int currentPage = floor((_scrollView.contentOffset.x - pagewidth/ ([_images count]+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [_scrollView scrollRectToVisible:CGRectMake(320 * [_images count],0,320,460) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([_images count]+1))
    {
        [_scrollView scrollRectToVisible:CGRectMake(320,0,320,460) animated:NO]; // 最后+1,循环第1页
    }
}

#pragma mark - UITableView Delegate & DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    ALGoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ALGoodsListTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_popImageView == nil) {
         _popImageView = [[UIImageView alloc] init];
    }
    _popImageView.image = [UIImage imageNamed:@"店铺弹出消息.png"];
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];    
    animation.values = values;
    [_popImageView.layer addAnimation:animation forKey:nil];
    [self.view addSubview:_popImageView];
    _popImageView.frame = CGRectMake(0, 0, 200, 150);
    _popImageView.center = self.view.center;
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:_tap];
}

- (void)tap
{
    [_popImageView removeFromSuperview];
    [self.view removeGestureRecognizer:_tap];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}


@end
