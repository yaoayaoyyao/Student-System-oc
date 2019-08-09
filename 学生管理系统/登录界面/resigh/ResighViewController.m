//
//  ResighViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "ResighViewController.h"
#import "UserNSO.h"

@interface ResighViewController ()<UITextFieldDelegate>

@property UITextField *resighNameTextField;
@property UITextField *resighPasswordTextField;
@property UIButton *resighButton;



@end

@implementation ResighViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"login.png"];
    [self.view addSubview:backImageView];
    
#pragma mark -- 登录
    _resighNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 200, 301, 40)];
    [self.view addSubview:_resighNameTextField];
    _resighNameTextField.delegate = self;
    _resighNameTextField.placeholder = @"请输入用户名";
    _resighNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _resighNameTextField.layer.borderWidth = 1;
    _resighNameTextField.layer.cornerRadius = 10;
    _resighNameTextField.layer.masksToBounds = YES;
    _resighNameTextField.layer.borderColor = [[UIColor blackColor]CGColor];
#pragma mark -- 密码
    _resighPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 300, 301, 40)];
    [self.view addSubview:_resighPasswordTextField];
    _resighPasswordTextField.delegate = self;
    _resighPasswordTextField.placeholder = @"请输入密码";
    _resighPasswordTextField.secureTextEntry = YES;
    _resighPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _resighPasswordTextField.layer.borderWidth = 1;
    _resighPasswordTextField.layer.cornerRadius = 10;
    _resighPasswordTextField.layer.masksToBounds = YES;
    _resighPasswordTextField.layer.borderColor = [[UIColor blackColor]CGColor];
#pragma mark -- 注册按钮
    _resighButton = [[UIButton alloc]initWithFrame:CGRectMake(137, 400, 101, 40)];
    [_resighButton setTitle:@"确认注册" forState:UIControlStateNormal];
    [_resighButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _resighButton.backgroundColor = [UIColor whiteColor];
    [_resighButton.layer setBorderWidth:1];
    [_resighButton.layer setBorderColor:[UIColor blackColor].CGColor];
    _resighButton.layer.cornerRadius = 10;
    _resighButton.layer.masksToBounds = YES;
    [self.view addSubview:_resighButton];
    [_resighButton addTarget:self action:@selector(resighclick) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark -- 键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_resighNameTextField resignFirstResponder];
    [_resighPasswordTextField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -- 按钮事件
-(void)resighclick{
    
    [_resighNameTextField resignFirstResponder];
    [_resighPasswordTextField resignFirstResponder];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认注册" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self->_resighNameTextField.text isEqualToString:@""] || [self->_resighPasswordTextField.text isEqualToString:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"不可添加空学生" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAlert];
        }
        else{
            [self pdUser];
        }
    }];
    [alert addAction:defaultAction];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
}
- (void)pdUser{
    int i;
    UserNSO *userNew = [[UserNSO alloc]init];
    for (i = 0; i < [_resighMutableArray count]; i++) {
        UserNSO *user = [[UserNSO alloc]init];
        user = _resighMutableArray[i];
        if ([user.nameUser isEqualToString:_resighNameTextField.text]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此账号已存在" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAlert];
            break;
        }
    }
    if (i == [_resighMutableArray count]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"信息添加成功！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.5];
        [self dismissViewControllerAnimated:YES completion:nil];
        userNew.nameUser = _resighNameTextField.text;
        userNew.passwordUser = _resighPasswordTextField.text;
        [_resighMutableArray addObject:userNew];
    }
}
- (void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self->_resighDelegate respondsToSelector:@selector(pass:pass1:andpassArray:)]) {
        [self->_resighDelegate pass:self->_resighNameTextField.text pass1:self->_resighPasswordTextField.text andpassArray:_resighMutableArray];
    }
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
