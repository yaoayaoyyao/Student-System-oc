//
//  ModifyViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "ModifyViewController.h"
#import "SJYTableViewCell.h"
#import "StudentNSO.h"
#import "SJYView.h"

static NSString *strCell = @"SJYCell";
@interface ModifyViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property UITableView *modifyTableView;
@property SJYView *modifySJYView;
@property UITextField *modifyTextField;
@property UIButton *modifyButton;
@property UIButton *moButton;

@end

@implementation ModifyViewController

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
    
    _moButton = [[UIButton alloc]initWithFrame:CGRectMake( 137, 812, 101, 40)];
    [self.view addSubview:_moButton];
    [_moButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [_moButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _moButton.layer.borderWidth = 1;
    _moButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _moButton.layer.cornerRadius = 10;
    _moButton.layer.masksToBounds = YES;
    [_moButton addTarget:self action:@selector(alertChange:) forControlEvents:UIControlEventTouchUpInside];
    
    _modifySJYView = [[SJYView alloc]init];
    _modifySJYView.frame = CGRectMake(375, 912, 0, 0);
    _modifySJYView.nameTextField.delegate = self;
    _modifySJYView.numberTextField.delegate = self;
    _modifySJYView.classTextField.delegate = self;
    _modifySJYView.ageTextField.delegate = self;
    _modifySJYView.gradeTextField.delegate = self;
    [self.view addSubview:_modifySJYView];
    
    //单元格
    _modifyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, 375, 400) style:UITableViewStylePlain];
    [self.view addSubview:_modifyTableView];
    [_modifyTableView registerClass:[SJYTableViewCell class] forCellReuseIdentifier:strCell];
    _modifyTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _modifyTableView.backgroundColor = [UIColor clearColor];
    _modifyTableView.delegate = self;
    _modifyTableView.dataSource = self;
    
    //界面
    _modifyTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 680, 315, 40)];
    [self.view addSubview:_modifyTextField];
    _modifyTextField.delegate = self;
    _modifyTextField.placeholder = @"请输入要修改的学生学号";
    _modifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _modifyTextField.layer.borderWidth = 1;
    _modifyTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    _modifyTextField.layer.cornerRadius = 10;
    _modifyTextField.layer.masksToBounds = YES;
    _modifyTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"radio_button_search.png"]];
    _modifyTextField.leftViewMode = UITextFieldViewModeAlways;
    
    _modifyButton = [[UIButton alloc]initWithFrame:CGRectMake( 137, 750, 101, 40)];
    [_modifyButton setTitle:@"修改" forState:UIControlStateNormal];
    [_modifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _modifyButton.layer.borderWidth = 1;
    _modifyButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _modifyButton.layer.cornerRadius = 10;
    _modifyButton.layer.masksToBounds = YES;
    [_modifyButton addTarget:self action:@selector(pressmodify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_modifyButton];
    
    
    
}

- (void)pressmodify{
    
    [_modifyTextField resignFirstResponder];
    [_modifySJYView.nameTextField resignFirstResponder];
    [_modifySJYView.numberTextField resignFirstResponder];
    [_modifySJYView.classTextField resignFirstResponder];
    [_modifySJYView.ageTextField resignFirstResponder];
    [_modifySJYView.gradeTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    
    StudentNSO *stu = [[StudentNSO alloc]init];
    int i;
    for (i = 0; i < [_modifyMutableArray count]; i++) {
        stu = _modifyMutableArray[i];
        if ([stu.numberStu isEqualToString:_modifyTextField.text]) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self->_modifySJYView.frame = CGRectMake( 0, 600, 375, 140);
                self->_modifyTextField.frame = CGRectMake(0, 812, 0, 0);
                self->_modifyButton.frame = CGRectMake(375, 812, 0, 0);
                self->_moButton.frame = CGRectMake( 137, 750, 101, 40);
                self->_moButton.tag = i;
            }];
            _modifySJYView.numberTextField.text = stu.numberStu;
            _modifySJYView.numberTextField.tag = 101;
            
            _modifySJYView.nameTextField.text = stu.nameStu;
            _modifySJYView.classTextField.text = stu.classStu;
            _modifySJYView.ageTextField.text = stu.ageStu;
            _modifySJYView.gradeTextField.text = stu.gradeStu;
            
            break;
        }
    }
    if (i == [_modifyMutableArray count]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此同学不存在！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAlert];
    }
}
- (void)alertChange:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认修改" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self modifyCount:btn.tag];
    }];
    [alert addAction:defaultAction];
}
- (void)modifyCount:(int)count{
    StudentNSO *stuNew = [[StudentNSO alloc]init];
    
    stuNew.nameStu = _modifySJYView.nameTextField.text;
    stuNew.numberStu = _modifySJYView.numberTextField.text;
    stuNew.classStu = _modifySJYView.classTextField.text;
    stuNew.ageStu = _modifySJYView.ageTextField.text;
    stuNew.gradeStu = _modifySJYView.gradeTextField.text;
    [_modifyMutableArray replaceObjectAtIndex:count withObject:stuNew];
    
    if ([_delegate respondsToSelector:@selector(array)]) {
        [_delegate array:_modifyMutableArray];
    }
    [_modifyTableView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        self->_modifySJYView.frame = CGRectMake(375, 912, 0, 0);
        self->_modifyTextField.frame = CGRectMake(30, 680, 315, 40);
        self->_modifyButton.frame = CGRectMake( 137, 750, 101, 40);
        self->_moButton.frame = CGRectMake( 137, 812, 101, 40);
    }];
}
- (void)backClick{
    [_modifyTextField resignFirstResponder];
    
    [_modifySJYView.nameTextField resignFirstResponder];
    [_modifySJYView.numberTextField resignFirstResponder];
    [_modifySJYView.classTextField resignFirstResponder];
    [_modifySJYView.ageTextField resignFirstResponder];
    [_modifySJYView.gradeTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_modifyMutableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentNSO *stuNSO = [[StudentNSO alloc]init];
    stuNSO = _modifyMutableArray[indexPath.row];
    
    SJYTableViewCell *sjyCell = [_modifyTableView dequeueReusableCellWithIdentifier:strCell forIndexPath:indexPath];
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
    if (textField.tag == 101) {
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
    [_modifyTextField resignFirstResponder];
    
    [_modifySJYView.nameTextField resignFirstResponder];
    [_modifySJYView.numberTextField resignFirstResponder];
    [_modifySJYView.classTextField resignFirstResponder];
    [_modifySJYView.ageTextField resignFirstResponder];
    [_modifySJYView.gradeTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
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
