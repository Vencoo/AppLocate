//
//  ALGoodsListTableViewCell.m
//  AppLocate
//
//  Created by Vencoo-Mac1 on 14-8-13.
//  Copyright (c) 2014年 Vencoo. All rights reserved.
//

#import "ALGoodsListTableViewCell.h"

@implementation ALGoodsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _titleLabel.text = @"欧美顶级品牌直销店★特价88元LV顶级皮具皮革清洗";
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 0;
    
    _priceLabel.text = @"￥88.00";
    
    _sellLabel.text = @"月售 3 笔";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
