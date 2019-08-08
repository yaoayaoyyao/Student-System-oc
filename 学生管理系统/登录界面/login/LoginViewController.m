//
//  LoginViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "LoginViewController.h"
#import "ResighViewController.h"
#import "MainViewController.h"
#import "UserNSO.h"

@interface LoginViewController ()<UITextFieldDelegate,ResighViewControllerDelegate>

@property UITextField *userNameTextField;
@property UITextField *userPasswordTextField;
@property UIButton *loginButton;
@property UIButton *resighButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"123", nil];
    NSArray *passwordArray = [NSArray arrayWithObjects:@"123", nil];
    _loginUserMutableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [nameArray count]; i++) {
        UserNSO *loginUser = [[UserNSO alloc]init];
        loginUser.nameUser = nameArray[i];
        loginUser.passwordUser = passwordArray[i];
        [_loginUserMutableArray addObject:loginUser];
    }
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"login.png"];
    [self.view addSubview:backImageView];
    
#pragma mark -- 登录
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 200, 301, 40)];
    [self.view addSubview:_userNameTextField];
    _userNameTextField.delegate = self;
    _userNameTextField.placeholder = @"请输入用户名";
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.layer.borderWidth = 1;
    _userNameTextField.layer.cornerRadius = 10;
    _userNameTextField.layer.masksToBounds = YES;
    _userNameTextField.layer.borderColor = [[UIColor blackColor]CGColor];
#pragma mark -- 密码
    _userPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 300, 301, 40)];
    [self.view addSubview:_userPasswordTextField];
    _userPasswordTextField.delegate = self;
    _userPasswordTextField.placeholder = @"请输入密码";
    _userPasswordTextField.secureTextEntry = YES;
    _userPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userPasswordTextField.layer.borderWidth = 1;
    _userPasswordTextField.layer.cornerRadius = 10;
    _userPasswordTextField.layer.masksToBounds = YES;
    _userPasswordTextField.layer.borderColor = [[UIColor blackColor]CGColor];
#pragma mark -- 登录按钮
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(62, 400, 100, 40)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor whiteColor];
    [_loginButton.layer setBorderWidth:1];
    [_loginButton.layer setBorderColor:[UIColor blackColor].CGColor];
    _loginButton.layer.cornerRadius = 10;
    _loginButton.layer.masksToBounds = YES;
    [self.view addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(loginclick) forControlEvents:UIControlEventTouchUpInside];
#pragma mark -- 注册按钮
    _resighButton = [[UIButton alloc]initWithFrame:CGRectMake(213, 400, 100, 40)];
    [self.view addSubview:_resighButton];
    [_resighButton setTitle:@"注册" forState:UIControlStateNormal];
    [_resighButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _resighButton.backgroundColor = [UIColor whiteColor];
    [_resighButton.layer setBorderWidth:1];
    [_resighButton.layer setBorderColor:[UIColor blackColor].CGColor];
    _resighButton.layer.cornerRadius = 10;
    _resighButton.layer.masksToBounds = YES;
    [_resighButton addTarget:self action:@selector(resighclick) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -- 键盘收回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_userNameTextField resignFirstResponder];
    [_userPasswordTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -- 按钮事件
- (void)loginclick{
    int i;
    for (i = 0; i < [_loginUserMutableArray count]; i++) {
        UserNSO *user = [[UserNSO alloc]init];
        user = _loginUserMutableArray[i];
        if ([user.nameUser isEqualToString:_userNameTextField.text] && [user.passwordUser isEqualToString:_userPasswordTextField.text]) {
            
            [_userNameTextField resignFirstResponder];
            [_userPasswordTextField resignFirstResponder];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.5];
            break;
        }
    }
    if (i == [_loginUserMutableArray count]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
    }
}
- (void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
    MainViewController *mainViewController = [[MainViewController alloc]init];
    [self presentViewController:mainViewController animated:YES completion:nil];
}

- (void)resighclick{
    ResighViewController *resighViewController = [[ResighViewController alloc]init];
    resighViewController.resighDelegate = self;
    resighViewController.resighMutableArray = _loginUserMutableArray;
    [self presentViewController:resighViewController animated:YES completion:nil];
}

- (void)pass:(NSString *)str pass1:(nonnull NSString *)str1 andpassArray:(nonnull NSMutableArray *)array{
    _userNameTextField.text = str;
    _userPasswordTextField.text = str1;
    _loginUserMutableArray = array;
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
