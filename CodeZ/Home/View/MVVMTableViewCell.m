//
//  MVVMTableViewCell.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MVVMTableViewCell.h"

@implementation MVVMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.textLabel.text = title;
}


@end
