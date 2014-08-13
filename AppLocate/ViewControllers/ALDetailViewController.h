//
//  ALDetailViewController.h
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-11.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALBaseViewController.h"

@protocol detailViewControllerDelegate <NSObject>

- (void)presentGoodsListViewController;

@end

@interface ALDetailViewController : ALBaseViewController

@property(nonatomic,assign)id<detailViewControllerDelegate>delegate;

@end
