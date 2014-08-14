//
//  ALSettingViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-14.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALSettingViewController.h"


@interface ALSettingViewController ()
{
    UITableView *_tableView;
    
    NSArray *_dataArray;
    
    UIButton *_backButton;
    
    UILabel *_label;
}

@end

@implementation ALSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [[NSArray alloc]initWithObjects:@"账号", @"个人资料",@"界面",@"安全和隐私",@"已收藏",@"辅助功能",@"帮组与反馈",@"关于",nil];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?20:0, kDeviceWidth, 50)];
    _label.text = @"设置界面";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_label];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?20+50:0+50, kDeviceWidth, KDeviceHeight-150)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = [UIColor redColor];
    _backButton.layer.masksToBounds = YES;
    _backButton.layer.cornerRadius = 5;
    _backButton.frame = CGRectMake(10, _tableView.bottom+10, kDeviceWidth-20, 40);
    [_backButton setTitle:@"退出" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
}

- (void)buttonClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableView Delegate & DataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



@end
