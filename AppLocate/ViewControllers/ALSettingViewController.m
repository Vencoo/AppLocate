//
//  ALSettingViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-14.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALSettingViewController.h"
#import "APLDefaults.h"
@import CoreLocation;

@interface ALSettingViewController ()<CLLocationManagerDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    
    NSArray *_dataArray;
    
    UILabel *_label;
}

@property (nonatomic, retain)  UISwitch *enabledSwitch;
@property (nonatomic, retain)  UITextField *uuidTextField;
@property (nonatomic, retain)  UITextField *majorTextField;
@property (nonatomic, retain)  UITextField *minorTextField;

@property (nonatomic, retain)  UISwitch *notifyOnEntrySwitch;
@property (nonatomic, retain)  UISwitch *notifyOnExitSwitch;
@property (nonatomic, retain)  UISwitch *notifyOnDisplaySwitch;

@property BOOL enabled;
@property NSUUID *uuid;
@property NSNumber *major;
@property NSNumber *minor;
@property BOOL notifyOnEntry;
@property BOOL notifyOnExit;
@property BOOL notifyOnDisplay;

@property UIButton *doneButton;

@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) CLLocationManager *locationManager;

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
    
    _dataArray = [[NSArray alloc]initWithObjects:@"启用", @"UUID",@"Major",@"Minor",@"通知进入",@"通知退出",@"通知显示",nil];
    
    //创建开关按钮
     _enabledSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth-60, 5, 40, 20)];
    [_enabledSwitch addTarget:self action:@selector(enabled:) forControlEvents:UIControlEventValueChanged];
     _notifyOnEntrySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth-60, 5, 40, 20)];
    [_notifyOnEntrySwitch addTarget:self action:@selector(notifyOnEntry:) forControlEvents:UIControlEventValueChanged];
     _notifyOnExitSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth-60, 5, 40, 20)];
    [_notifyOnExitSwitch addTarget:self action:@selector(notifyOnExit:) forControlEvents:UIControlEventValueChanged];
     _notifyOnDisplaySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth-60, 5, 40, 20)];
    [_notifyOnDisplaySwitch addTarget:self action:@selector(notifyOnDisplay:) forControlEvents:UIControlEventValueChanged];
    
    _uuidTextField = [[UITextField alloc]initWithFrame:CGRectMake(kDeviceWidth-250, 5, 240, 30)];
    _uuidTextField.placeholder = @"UUID";
    _uuidTextField.userInteractionEnabled = NO;
    _uuidTextField.textAlignment = NSTextAlignmentRight;
    
    _majorTextField = [[UITextField alloc]initWithFrame:CGRectMake(kDeviceWidth-250, 5, 240, 30)];
    _majorTextField.placeholder = @"Major";
    _majorTextField.delegate = self;
    _majorTextField.textAlignment = NSTextAlignmentRight;
    
    _minorTextField = [[UITextField alloc]initWithFrame:CGRectMake(kDeviceWidth-250, 5, 240, 30)];
    _minorTextField.placeholder = @"Minor";
    _minorTextField.delegate = self;
    _minorTextField.textAlignment = NSTextAlignmentRight;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?20:0, kDeviceWidth, 50)];
    _label.text = @"设置界面";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_label];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?20+50:0+50, kDeviceWidth, KDeviceHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:BeaconIdentifier];
    region = [self.locationManager.monitoredRegions member:region];
    if(region)
    {
        self.enabled = YES;
        self.uuid = region.proximityUUID;
        self.major = region.major;
        self.majorTextField.text = [self.major stringValue];
        self.minor = region.minor;
        self.minorTextField.text = [self.minor stringValue];
        self.notifyOnEntry = region.notifyOnEntry;
        self.notifyOnExit = region.notifyOnExit;
        self.notifyOnDisplay = region.notifyEntryStateOnDisplay;

    }
    else
    {
        // Default settings.
        self.enabled = NO;
        self.uuid = [APLDefaults sharedDefaults].defaultProximityUUID;
        self.major = self.minor = nil;
        self.notifyOnEntry = self.notifyOnExit = YES;
        self.notifyOnDisplay = NO;
    }
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doneButton.frame = CGRectMake(kDeviceWidth-70, 10, 50, 30);
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(doneEditing:) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton.hidden = YES;
    [_label addSubview:self.doneButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.uuidTextField.text = [self.uuid UUIDString];
    self.enabledSwitch.on = self.enabled;
    self.notifyOnEntrySwitch.on = self.notifyOnEntry;
    self.notifyOnExitSwitch.on = self.notifyOnExit;
    self.notifyOnDisplaySwitch.on = self.notifyOnDisplay;
}

#pragma mark - Text editing

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == self.uuidTextField)
    {
        [self performSegueWithIdentifier:@"selectUUID" sender:self];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.doneButton.hidden = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.majorTextField)
    {
        self.major = [self.numberFormatter numberFromString:textField.text];
    }
    else if(textField == self.minorTextField)
    {
        self.minor = [self.numberFormatter numberFromString:textField.text];
    }
    
    self.doneButton.hidden = YES;
    
    [self updateMonitoredRegion];
}

- (void)updateMonitoredRegion
{
    // if region monitoring is enabled, update the region being monitored
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:BeaconIdentifier];
    
    if(region != nil)
    {
        [self.locationManager stopMonitoringForRegion:region];
    }
    
    if(self.enabled)
    {
        region = nil;
        if(self.uuid && self.major && self.minor)
        {
            region = [[CLBeaconRegion alloc] initWithProximityUUID:self.uuid major:[self.major shortValue] minor:[self.minor shortValue] identifier:BeaconIdentifier];
        }
        else if(self.uuid && self.major)
        {
            region = [[CLBeaconRegion alloc] initWithProximityUUID:self.uuid major:[self.major shortValue]  identifier:BeaconIdentifier];
        }
        else if(self.uuid)
        {
            region = [[CLBeaconRegion alloc] initWithProximityUUID:self.uuid identifier:BeaconIdentifier];
        }
        
        if(region)
        {
            region.notifyOnEntry = self.notifyOnEntry;
            region.notifyOnExit = self.notifyOnExit;
            region.notifyEntryStateOnDisplay = self.notifyOnDisplay;

            [self.locationManager startMonitoringForRegion:region];
        }
    }
    else
    {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:BeaconIdentifier];
        [self.locationManager stopMonitoringForRegion:region];
    }
}



#pragma mark - actions

- (void)enabled:(UISwitch *)sender
{
    self.enabled = sender.on;
    
    [self updateMonitoredRegion];
}

- (void)doneEditing:(id)sender
{
    [self.majorTextField resignFirstResponder];
    [self.minorTextField resignFirstResponder];
    
    [_tableView reloadData];
}

- (void)notifyOnEntry:(UISwitch *)sender
{
    self.notifyOnEntry = sender.on;
    [self updateMonitoredRegion];
}

- (void)notifyOnExit:(UISwitch *)sender
{
    self.notifyOnExit = sender.on;
    [self updateMonitoredRegion];
}

- (void)notifyOnDisplay:(UISwitch *)sender
{
    self.notifyOnDisplay = sender.on;
    [self updateMonitoredRegion];
}

#pragma mark - UITableView Delegate & DataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"区域监控";
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row == 0) {
        [cell.contentView addSubview:_enabledSwitch];
    }
    else if (indexPath.row == 4) {
        [cell.contentView addSubview:_notifyOnEntrySwitch];
    }
    else if (indexPath.row == 5) {
        [cell.contentView addSubview:_notifyOnExitSwitch];
    }
    else if (indexPath.row == 6) {
        [cell.contentView addSubview:_notifyOnDisplaySwitch];
    }
    else if (indexPath.row == 1)
    {
        [cell.contentView addSubview:_uuidTextField];
    }
    else if (indexPath.row == 2)
    {
        [cell.contentView addSubview:_majorTextField];
    }
    else if (indexPath.row == 3)
    {
        [cell.contentView addSubview:_minorTextField];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UIResponder Methods
//文本框结束编辑，点击空白处，键盘收回
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
