//
//  ALLocateViewController.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-15.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALLocateViewController.h"
#import "APLDefaults.h"
@import CoreLocation;

@interface ALLocateViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    UITableView *_tableView;
    
    UILabel *_label;
}

@property NSMutableDictionary *beacons;
@property CLLocationManager *locationManager;
@property NSMutableDictionary *rangedRegions;

@property BOOL isFindLocate;

@end

@implementation ALLocateViewController

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
    _isFindLocate = YES;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?20:0, kDeviceWidth, 50)];
    _label.text = @"搜索界面";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_label];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOSVersion>=7.0?20+50:0+50, kDeviceWidth, KDeviceHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
 
    
    }

- (void)beaconsStart
{
    NSLog(@"start");
    if (self.beacons == nil) {
        self.beacons = [[NSMutableDictionary alloc] init];
    }
    // This location manager will be used to demonstrate how to range beacons.
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    // Populate the regions we will range once.
    if (self.rangedRegions == nil) {
        self.rangedRegions = [[NSMutableDictionary alloc] init];
    }
    for (NSUUID *uuid in [APLDefaults sharedDefaults].supportedProximityUUIDs)
    {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:[uuid UUIDString]];
        self.rangedRegions[region] = [NSArray array];
    }
    for (CLBeaconRegion *region in self.rangedRegions)
    {
        NSLog(@"22");
        [self.locationManager startRangingBeaconsInRegion:region];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Start ranging when the view appears.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Stop ranging when the view goes away.
    for (CLBeaconRegion *region in self.rangedRegions)
    {
        [self.locationManager stopRangingBeaconsInRegion:region];
    }
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    /*
     CoreLocation will call this delegate method at 1 Hz with updated range information.
     Beacons will be categorized and displayed by proximity.  A beacon can belong to multiple
     regions.  It will be displayed multiple times if that is the case.  If that is not desired,
     use a set instead of an array.
     */
    NSLog(@"start2");
    //找到RangeBeacons返回yes
    _isFindLocate = YES;
    
    self.rangedRegions[region] = beacons;
    [self.beacons removeAllObjects];
    
    NSMutableArray *allBeacons = [NSMutableArray array];
    
    for (NSArray *regionResult in [self.rangedRegions allValues])
    {
        [allBeacons addObjectsFromArray:regionResult];
    }
    
    for (NSNumber *range in @[@(CLProximityUnknown), @(CLProximityImmediate), @(CLProximityNear), @(CLProximityFar)])
    {
        NSArray *proximityBeacons = [allBeacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity = %d", [range intValue]]];
        if([proximityBeacons count])
        {
            self.beacons[range] = proximityBeacons;
        }
    }
    
    if (self.beacons != nil) {
        NSNumber *sectionKey = [[self.beacons allKeys] firstObject];
        if (sectionKey == nil) {
            NSLog(@"sectionKey == nil");
            _isFindLocate = NO;
        }
        CLBeacon *beacon = [self.beacons[sectionKey] firstObject];
        NSString *formatString = NSLocalizedString(@"距离最近店铺: %.2fm", @"Format string for ranging table cells.");
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:formatString, beacon.accuracy] forKey:@"beacon"];
    }

    [_tableView reloadData];
}

- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error
{
     NSLog(@"startError");
    _isFindLocate = NO;
    [[NSUserDefaults standardUserDefaults]setObject:@"未搜索到目标..." forKey:@"beacon"];
    [_tableView reloadData];
}



#pragma mark - UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ( _isFindLocate == NO) {
        return 1;
    }
    return self.beacons.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if ( _isFindLocate == NO) {
        return 1;
    }
    NSArray *sectionValues = [self.beacons allValues];
    return [sectionValues[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ( _isFindLocate == NO) {
        return @"未知";
    }
    NSString *title;
    NSArray *sectionKeys = [self.beacons allKeys];
    
    // The table view will display beacons by proximity.
    NSNumber *sectionKey = sectionKeys[section];
    
    switch([sectionKey integerValue])
    {
        case CLProximityImmediate:
            title = NSLocalizedString(@"附近", @"Immediate section header title");
            break;
            
        case CLProximityNear:
            title = NSLocalizedString(@"附近", @"Near section header title");
            break;
            
        case CLProximityFar:
            title = NSLocalizedString(@"稍远", @"Far section header title");
            break;
            
        default:
            title = NSLocalizedString(@"未知", @"Unknown section header title");
            break;
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView");
    if ( _isFindLocate == NO) {
         UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = @"未搜索到目标...";
        return cell;
    }
 
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    // Display the UUID, major, minor and accuracy for each beacon.
    NSNumber *sectionKey = [self.beacons allKeys][indexPath.section];
    CLBeacon *beacon = self.beacons[sectionKey][indexPath.row];
    
    NSString* plistfile = [[NSBundle mainBundle]pathForResource:@"UUIDPlist" ofType:@"plist"];
    NSDictionary* data = [[NSDictionary alloc]initWithContentsOfFile:plistfile];
    NSDictionary *dic = [data objectForKey:[beacon.proximityUUID UUIDString]];
    if (dic != NULL)
    {
        cell.textLabel.text = [dic objectForKey:@"Name"];
    }
    else
    {
        cell.textLabel.text = [beacon.proximityUUID UUIDString];
    }
    NSString *formatString = NSLocalizedString(@"距离最近店铺: %.2fm", @"Format string for ranging table cells.");
    cell.detailTextLabel.text = [NSString stringWithFormat:formatString, beacon.accuracy];
    if (indexPath.row == 0 && indexPath.section ==0) {
        [[NSUserDefaults standardUserDefaults]setObject:[beacon.proximityUUID UUIDString] forKey:@"UUID"];
    }
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
