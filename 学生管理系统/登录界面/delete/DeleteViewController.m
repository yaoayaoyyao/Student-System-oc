//
//  DeleteViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "DeleteViewController.h"
#import "SJYTableViewCell.h"
#import "StudentNSO.h"

static NSString *strCell = @"SJYCell";
@interface DeleteViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *deleteTableView;
@property UITextField *deleteTextField;
@property UIButton *deleteButton;

@end

@implementation DeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 界面
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"2.png"];
    [self.view addSubview:backImageView];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_img.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    leftButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
//单元格
    _deleteTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, 375, 400) style:UITableViewStylePlain];
    [self.view addSubview:_deleteTableView];
    [_deleteTableView registerClass:[SJYTableViewCell class] forCellReuseIdentifier:strCell];
    _deleteTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _deleteTableView.backgroundColor = [UIColor clearColor];
    _deleteTableView.delegate = self;
    _deleteTableView.dataSource = self;
    
//界面
    _deleteTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 680, 315, 40)];
    [self.view addSubview:_deleteTextField];
    _deleteTextField.delegate = self;
    _deleteTextField.placeholder = @"请输入要删除的学生学号";
    _deleteTextField.keyboardType = UIKeyboardTypeNumberPad;
    _deleteTextField.layer.borderWidth = 1;
    _deleteTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    _deleteTextField.layer.cornerRadius = 10;
    _deleteTextField.layer.masksToBounds = YES;
    _deleteTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"radio_button_search.png"]];
    _deleteTextField.leftViewMode = UITextFieldViewModeAlways;
    
    _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake( 137, 750, 101, 40)];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _deleteButton.layer.borderWidth = 1;
    _deleteButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _deleteButton.layer.cornerRadius = 10;
    _deleteButton.layer.masksToBounds = YES;
    [_deleteButton addTarget:self action:@selector(pressdelete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteButton];
    
    
    
}


- (void)pressdelete{
    
    [_deleteTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteStu];
    }];
    [alert addAction:okAlert];
    
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAlert];
}
- (void)deleteStu{
    StudentNSO *stuNSO = [[StudentNSO alloc]init];
    int i;
    for (i = 0; i < [_deleteMutableArray count]; i++) {
        stuNSO = _deleteMutableArray[i];
        if ([stuNSO.numberStu isEqualToString:_deleteTextField.text]) {
            [_deleteMutableArray removeObject:stuNSO];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"信息已成功删除！" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.5];
            if ([_delegate respondsToSelector:@selector(array:)]) {
                [_delegate array:_deleteMutableArray];
            }
            [_deleteTableView reloadData];
            break;
        }
    }
    if (i == [_deleteMutableArray count]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此同学不存在！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAlert];
    }
}
- (void)dismiss:(UIAlertController *)alert{
    [_deleteTextField resignFirstResponder];
    [alert dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    [_deleteTextField resignFirstResponder];
}

- (void)backClick{
    [_deleteTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//弹出键盘时，输入框上移至不被隐藏
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    return YES;
}
#pragma mark -- 单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_deleteMutableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentNSO *stuNSO = [[StudentNSO alloc]init];
    stuNSO = _deleteMutableArray[indexPath.row];
    
    SJYTableViewCell *sjyCell = [_deleteTableView dequeueReusableCellWithIdentifier:strCell forIndexPath:indexPath];
    sjyCell.selectionStyle = UITableViewCellEditingStyleNone;
    
    sjyCell.cellView.nameTextField.text = stuNSO.nameStu;
    sjyCell.cellView.numberTextField.text = stuNSO.numberStu;
    sjyCell.cellView.classTextField.text = stuNSO.classStu;
    sjyCell.cellView.ageTextField.text = stuNSO.ageStu;
    sjyCell.cellView.gradeTextField.text = stuNSO.gradeStu;
    
    sjyCell.backgroundColor = [UIColor clearColor];
    return sjyCell;
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
