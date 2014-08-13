//
//  ALDetailViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-11.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALDetailViewController.h"

#define listButton      201
#define favoeiteButton  202
#define shareButton     203

@interface ALDetailViewController ()
{
    UIButton *_listButton;
    UIButton *_favoriteButton;
    UIButton *_shareButton;
}
@end

@implementation ALDetailViewController

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
    
    _listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _listButton.frame = CGRectMake(0, 0, 30, 30);
    [_listButton setImage:[UIImage imageNamed:@"btn_right_list.png"] forState:UIControlStateNormal];
    _listButton.center = CGPointMake(35, 40);
    _listButton.tag = listButton;
    [_listButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_listButton];
    
    _favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _favoriteButton.frame = CGRectMake(0, 0, 30, 30);
    [_favoriteButton setImage:[UIImage imageNamed:@"btn_right_fav.png"] forState:UIControlStateNormal];
    _favoriteButton.center = CGPointMake(35, 40+60);
    _favoriteButton.tag = favoeiteButton;
    [_favoriteButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_favoriteButton];
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton.frame = CGRectMake(0, 0, 30, 30);
    [_shareButton setImage:[UIImage imageNamed:@"btn_right_share.png"] forState:UIControlStateNormal];
    _shareButton.center = CGPointMake(35, 40+60+60);
    _shareButton.tag = shareButton;
    [_shareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareButton];
}

- (void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case listButton:
        {
            [self.delegate presentGoodsListViewController];
        }
            
            break;
            
        default:
            break;
    }
}


@end
