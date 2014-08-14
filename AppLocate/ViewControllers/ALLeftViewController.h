//
//  ALLeftViewController.h
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-11.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALBaseViewController.h"

@protocol leftViewControllerDelegate <NSObject>

- (void)presentSettingViewController;
- (void)presentCollectViewController;

@end

@interface ALLeftViewController : ALBaseViewController

@property(nonatomic,assign)id<leftViewControllerDelegate>delegate;

@end
