//
//  ALToolBarView.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-12.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALToolBarView.h"

@implementation ALToolBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, KDeviceHeight-44, kDeviceWidth, 44)];
    [self addSubview:_toolBar];
   
//    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"btn_list.png"] style:UIBarButtonItemStyleDone target:self action:nil];
//    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_up.png"] style:UIBarButtonItemStyleDone target:self action:@selector(classaaa)];
//    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    _toolBar.items = [NSArray arrayWithObjects:item1,spaceItem,item2,nil];
}

@end
