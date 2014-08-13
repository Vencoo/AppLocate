//
//  ALLeftViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-11.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALLeftViewController.h"
#define kWidth  self.view.bounds.size.width
@interface ALLeftViewController ()
{
    UIButton *_searchButton;
    UIButton *_favoriteButton;
    UIButton *_settingButton;
}
@end

@implementation ALLeftViewController

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
    
    //float width = self.view.bounds.size.width;
    float height = (self.view.bounds.size.height-40-64)/3.0;
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.frame = CGRectMake(0, 0, 100, 100);
    [_searchButton setImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
    _searchButton.center = CGPointMake(75, 20+height/2.0);
    [self.view addSubview:_searchButton];
    
    _favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _favoriteButton.frame = CGRectMake(0, 0, 100, 100);
    [_favoriteButton setImage:[UIImage imageNamed:@"btn_favorite.png"] forState:UIControlStateNormal];
    _favoriteButton.center = CGPointMake(75, 20+height+height/2.0);
    [self.view addSubview:_favoriteButton];
    
    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingButton.frame = CGRectMake(0, 0, 100, 100);
    [_settingButton setImage:[UIImage imageNamed:@"btn_setting.png"] forState:UIControlStateNormal];
    _settingButton.center = CGPointMake(75, 20+height+height+height/2.0);
    [self.view addSubview:_settingButton];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
