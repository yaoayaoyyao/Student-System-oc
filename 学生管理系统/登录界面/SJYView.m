//
//  SJYView.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/6.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "SJYView.h"

@implementation SJYView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    _nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    
    _numberLabel = [[UILabel alloc]init];
    [self addSubview:_numberLabel];
    
    _classLabel = [[UILabel alloc]init];
    [self addSubview:_classLabel];
    
    _ageLabel = [[UILabel alloc]init];
    [self addSubview:_ageLabel];
    
    _gradeLabel = [[UILabel alloc]init];
    [self addSubview:_gradeLabel];
    
    _nameTextField = [[UITextField alloc]init];
    [self addSubview:_nameTextField];
    
    _numberTextField = [[UITextField alloc]init];
    [self addSubview:_numberTextField];
    
    _classTextField = [[UITextField alloc]init];
    [self addSubview:_classTextField];
    
    _ageTextField = [[UITextField alloc]init];
    [self addSubview:_ageTextField];
    
    _gradeTextField = [[UITextField alloc]init];
    [self addSubview:_gradeTextField];
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake( 5, 5, 60, 40);
    _nameLabel.text = @"姓名：";
    
    _numberLabel.frame = CGRectMake(200, 5, 60, 40);
    _numberLabel.text = @"学号：";
    
    _classLabel.frame = CGRectMake(5, 50, 60, 40);
    _classLabel.text = @"班级：";
    
    _ageLabel.frame = CGRectMake(200, 50, 60, 40);
    _ageLabel.text = @"年龄：";
    
    _gradeLabel.frame = CGRectMake(5, 95, 60, 40);
    _gradeLabel.text = @"成绩：";
    
    _nameTextField.frame = CGRectMake( 65, 5, 130, 40);
    
    _numberTextField.frame = CGRectMake(260, 5, 100, 40);
    
    _classTextField.frame = CGRectMake(65, 50, 130, 40);
    
    _ageTextField.frame = CGRectMake(260, 50, 100, 40);
    
    _gradeTextField.frame = CGRectMake(65, 95, 100, 40);
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
