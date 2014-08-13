//
//  ALMainViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-11.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALMainViewController.h"
#import "ALToolBarView.h"
#import "ALLeftViewController.h"
#import "ALDetailViewController.h"
#import "ALGoodsListViewController.h"

#define btnListOpen   101
#define btnListClose  110
#define btnNav    102
#define btnUp     103
#define btnDown   130
#define btnBack   104

@interface ALMainViewController ()
{
    ALLeftViewController *_leftVC;
    ALDetailViewController *_detailVC;
    ALGoodsListViewController *_goodsListVC;
    
    ALToolBarView *_toolBarView;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *listButton;
@property (strong, nonatomic) IBOutlet UIButton *navButton;
@property (strong, nonatomic) IBOutlet UIButton *upButton;

@end

@implementation ALMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)loadView
//{
//     _backgroundImageView.frame = CGRectMake(20,52, 225, 215);
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _toolBarView = [[ALToolBarView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:_toolBarView];
    
    _imageView.image = [UIImage imageNamed:@"bg_dowm.png"];
    //创建按钮
    [_listButton setImage:[UIImage imageNamed:@"btn_list.png"] forState:UIControlStateNormal];
    [_listButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _listButton.tag = btnListOpen;
    
    [_navButton setImage:[UIImage imageNamed:@"btn_nav.png"] forState:UIControlStateNormal];
    [_navButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navButton.tag = btnNav;
    
    [_upButton setImage:[UIImage imageNamed:@"btn_up.png"] forState:UIControlStateNormal];
    [_upButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _upButton.tag = btnUp;
    // Do any additional setup after loading the view.
}

- (void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case btnListOpen:
        {   //展开左侧边栏
            button.userInteractionEnabled = NO;
            if (_leftVC == nil) {
                 _leftVC = [[ALLeftViewController alloc]init];
            }
            _leftVC.view.alpha = 0.7;
            _leftVC.view.backgroundColor = [UIColor darkGrayColor];
            _leftVC.view.frame = CGRectMake(-150,IOSVersion>=7.0?20:0, 150, KDeviceHeight-20-64);
            [self.view addSubview:_leftVC.view];
            [self.view bringSubviewToFront:_navButton];
            [UIView animateWithDuration:0.2 animations:^{
                _leftVC.view.frame = CGRectMake(0, IOSVersion>=7.0?20:0, 150, KDeviceHeight-20-64);
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = YES;
                button.tag = btnListClose;
            }];
        }
            break;
            
        case btnListClose:
        {
            //收起左侧边栏
            button.userInteractionEnabled = NO;
            if (_leftVC == nil) {
                _leftVC = [[ALLeftViewController alloc]init];
            }
            [UIView animateWithDuration:0.2 animations:^{
                _leftVC.view.frame = CGRectMake(-150, IOSVersion>=7.0?20:0, 150, KDeviceHeight-20-64);
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = YES;
                button.tag = btnListOpen;
            }];
        }
            break;
            
        case btnUp:
        {
            //展开右侧边栏
            [button setImage:[UIImage imageNamed:@"btn_dowm.png"] forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
            if (_detailVC == nil) {
                _detailVC = [[ALDetailViewController alloc]init];
                _detailVC.delegate = self;

            }
            _detailVC.view.alpha = 0.7;
            _detailVC.view.backgroundColor = [UIColor darkGrayColor];
            _detailVC.view.frame = CGRectMake(kDeviceWidth, IOSVersion>=7.0?KDeviceHeight-64-200:KDeviceHeight-64-220, 70, 200);
            //_detailVC.view.frame = CGRectMake(kDeviceWidth-70, KDeviceHeight, 70, 200);
            [self.view addSubview:_detailVC.view];
            [UIView animateWithDuration:0.2 animations:^{
                _detailVC.view.frame = CGRectMake(kDeviceWidth-70, IOSVersion>=7.0?KDeviceHeight-64-200:KDeviceHeight-64-220, 70,200);
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = YES;
                button.tag = btnDown;
            }];
        }
            break;
            
        case btnDown:
        {
            //收起右侧边栏
            [button setImage:[UIImage imageNamed:@"btn_up.png"] forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
            if (_detailVC == nil) {
                _detailVC = [[ALDetailViewController alloc]init];
            }
            [UIView animateWithDuration:0.2 animations:^{
                _detailVC.view.frame = CGRectMake(kDeviceWidth, IOSVersion>=7.0?KDeviceHeight-64-200:KDeviceHeight-64-220, 70, 200);
            } completion:^(BOOL finished) {
                button.userInteractionEnabled = YES;
                button.tag = btnUp;
            }];
        }
            break;
        case btnNav:
        {
            //改变背景图片
            static int i = 1;
            NSString *imageStrng = [NSString stringWithFormat:@"%d.jpg",i];
            _backgroundImageView.image = [UIImage imageNamed:imageStrng];
            i++;
            if (i == 3) {
                i = 1;
            }
        }
            break;
            
        case btnBack:
        {
            //回到首页

            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            break;
            
            
        default:
            break;
    }
}

- (void)presentGoodsListViewController
{
    if (_goodsListVC == nil) {
      
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _goodsListVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ALGoodsListViewController"];
        UIImageView *bgDownImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?KDeviceHeight-64:KDeviceHeight-64-20, kDeviceWidth, 64)];
        bgDownImageView.userInteractionEnabled = YES;
        bgDownImageView.image = [UIImage imageNamed:@"bg_dowm.png"];
        [_goodsListVC.view addSubview:bgDownImageView];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        backButton.frame = CGRectMake(10,12 , 40, 40);
        backButton.tag = btnBack;
        [backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgDownImageView addSubview:backButton];
        

    }
    [_goodsListVC tap];
    [self presentViewController:_goodsListVC animated:YES completion:^{
    
    
    }];
}



@end
