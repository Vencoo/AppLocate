//
//  ALCollectViewCell.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-14.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALCollectViewCell.h"

@implementation ALCollectViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ALCollectViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        
        self.imageView.layer.borderWidth = 0.3;

    }
    return self;
}


@end
