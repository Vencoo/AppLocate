//
//  ALAppDelegate.h
//  AppLocate
//
//  Created by Vencoo on 14-8-11.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface ALAppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property CLLocationManager *locationManager;

@end
