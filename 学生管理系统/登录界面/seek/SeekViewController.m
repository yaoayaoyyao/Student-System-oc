//
//  SeekViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "SeekViewController.h"
#import "SJYTableViewCell.h"
#import "StudentNSO.h"

static NSString *strCell = @"SJYCell";
@interface SeekViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITextField *seekTextField;
@property (nonatomic, strong)UIButton *seekButton;
@property (nonatomic, strong)UIButton *seButton;
@property (nonatomic, strong)UITableView *seekTableView;
@property SJYView *seekSJYView;

@end

@implementation SeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 界面
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"2.png"];
    [self.view addSubview:backImageView];
//导航栏
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_img.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    leftButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    _seButton = [[UIButton alloc]initWithFrame:CGRectMake( 137, 812, 101, 40)];
    [self.view addSubview:_seButton];
    [_seButton setTitle:@"重新查找" forState:UIControlStateNormal];
    [_seButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _seButton.layer.borderWidth = 1;
    _seButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _seButton.layer.cornerRadius = 10;
    _seButton.layer.masksToBounds = YES;
    [_seButton addTarget:self action:@selector(alertChange) forControlEvents:UIControlEventTouchUpInside];
    
    _seekSJYView = [[SJYView alloc]init];
    _seekSJYView.frame = CGRectMake(375, 912, 0, 0);
    _seekSJYView.nameTextField.delegate = self;
    _seekSJYView.numberTextField.delegate = self;
    _seekSJYView.classTextField.delegate = self;
    _seekSJYView.ageTextField.delegate = self;
    _seekSJYView.gradeTextField.delegate = self;
    [self.view addSubview:_seekSJYView];
    
//单元格
    _seekTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, 375, 400) style:UITableViewStylePlain];
    [self.view addSubview:_seekTableView];
    [_seekTableView registerClass:[SJYTableViewCell class] forCellReuseIdentifier:strCell];
    _seekTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _seekTableView.backgroundColor = [UIColor clearColor];
    _seekTableView.delegate = self;
    _seekTableView.dataSource = self;
    
//界面
    _seekTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 680, 315, 40)];
    [self.view addSubview:_seekTextField];
    _seekTextField.delegate = self;
    _seekTextField.tag = 110;
    _seekTextField.placeholder = @"请输入要查找的学生学号";
    _seekTextField.keyboardType = UIKeyboardTypeNumberPad;
    _seekTextField.layer.borderWidth = 1;
    _seekTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    _seekTextField.layer.cornerRadius = 10;
    _seekTextField.layer.masksToBounds = YES;
    _seekTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"radio_button_search.png"]];
    _seekTextField.leftViewMode = UITextFieldViewModeAlways;
    
    _seekButton = [[UIButton alloc]initWithFrame:CGRectMake( 137, 750, 101, 40)];
    [_seekButton setTitle:@"查找" forState:UIControlStateNormal];
    [_seekButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _seekButton.layer.borderWidth = 1;
    _seekButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _seekButton.layer.cornerRadius = 10;
    _seekButton.layer.masksToBounds = YES;
    [_seekButton addTarget:self action:@selector(seekClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_seekButton];
    
    
    
}

- (void)seekClick {
    
    [_seekTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    
    StudentNSO *stu = [[StudentNSO alloc]init];
    int i;
    for (i = 0; i < [_seekMutableArray count]; i++) {
        stu = _seekMutableArray[i];
        if ([_seekTextField.text isEqualToString:stu.numberStu]) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self->_seekSJYView.frame = CGRectMake( 0, 600, 375, 140);
                self->_seekTextField.frame = CGRectMake(0, 812, 0, 0);
                self->_seekButton.frame = CGRectMake(375, 812, 0, 0);
                self->_seButton.frame = CGRectMake( 137, 750, 101, 40);
                self->_seButton.tag = i;
            }];
            
            _seekSJYView.numberTextField.text = stu.numberStu;
            _seekSJYView.nameTextField.text = stu.nameStu;
            _seekSJYView.classTextField.text = stu.classStu;
            _seekSJYView.ageTextField.text = stu.ageStu;
            _seekSJYView.gradeTextField.text = stu.gradeStu;
            
            
            break;
        }
    }
    if (i == [_seekMutableArray count]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"不存在这个学生" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
    }
}
- (void)backClick {
    [_seekTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- 单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_seekMutableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentNSO *stuNSO = [[StudentNSO alloc]init];
    stuNSO = _seekMutableArray[indexPath.row];
    
    SJYTableViewCell *sjyCell = [_seekTableView dequeueReusableCellWithIdentifier:strCell forIndexPath:indexPath];
    sjyCell.selectionStyle = UITableViewCellEditingStyleNone;
    
    sjyCell.cellView.nameTextField.text = stuNSO.nameStu;
    sjyCell.cellView.numberTextField.text = stuNSO.numberStu;
    sjyCell.cellView.classTextField.text = stuNSO.classStu;
    sjyCell.cellView.ageTextField.text = stuNSO.ageStu;
    sjyCell.cellView.gradeTextField.text = stuNSO.gradeStu;
    
    sjyCell.backgroundColor = [UIColor clearColor];
    return sjyCell;
}

#pragma mark -- 键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag != 110) {
        return NO;
    }
    CGFloat offset = -290;
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_seekTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
}

- (void)alertChange{
    [UIView animateWithDuration:0.3 animations:^{
        self->_seekSJYView.frame = CGRectMake(375, 912, 0, 0);
        self->_seekTextField.frame = CGRectMake(30, 680, 315, 40);
        self->_seekButton.frame = CGRectMake( 137, 750, 101, 40);
        self->_seButton.frame = CGRectMake( 137, 812, 101, 40);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
