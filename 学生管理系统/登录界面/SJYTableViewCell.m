//
//  SJYTableViewCell.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "SJYTableViewCell.h"

@implementation SJYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _cellView = [[SJYView alloc]init];
    [self.contentView addSubview:_cellView];
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _cellView.frame = CGRectMake( 0, 0, [UIScreen mainScreen].bounds.size.width, 140);
    
    _cellView.nameTextField.enabled = NO;
    _cellView.numberTextField.enabled = NO;
    _cellView.classTextField.enabled = NO;
    _cellView.ageTextField.enabled = NO;
    _cellView.gradeTextField.enabled = NO;
    
}



@end
