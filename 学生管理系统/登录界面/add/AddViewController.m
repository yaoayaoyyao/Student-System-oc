//
//  AddViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "AddViewController.h"
#import "SJYView.h"
#import "StudentNSO.h"
#import "SJYTableViewCell.h"

static NSString *strCell = @"SJYCell";
@interface AddViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong)UITableView *addTableView;
@property SJYView *sjyView;
@property StudentNSO *stuNew;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 界面
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"2.png"];
    [self.view addSubview:backImageView];
    
    
//单元格
    
    _addTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, 375, 400) style:UITableViewStylePlain];
    [self.view addSubview:_addTableView];
    [_addTableView registerClass:[SJYTableViewCell class] forCellReuseIdentifier:strCell];
    _addTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _addTableView.backgroundColor = [UIColor clearColor];
    _addTableView.delegate = self;
    _addTableView.dataSource = self;
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_img.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    leftButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    _sjyView = [[SJYView alloc]initWithFrame:CGRectMake( 0, 600, 375, 140)];
    [self.view addSubview:_sjyView];
    _stuNew = [[StudentNSO alloc]init];
    
    _sjyView.numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _sjyView.classTextField.placeholder = @"格式：软件1801";
    _sjyView.ageTextField.keyboardType = UIKeyboardTypeNumberPad;
    _sjyView.gradeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _sjyView.nameTextField.delegate = self;
    _sjyView.numberTextField.delegate = self;
    _sjyView.classTextField.delegate = self;
    _sjyView.ageTextField.delegate = self;
    _sjyView.gradeTextField.delegate = self;
    
    _addButton = [[UIButton alloc]initWithFrame:CGRectMake( 137, 750, 101, 40)];
    [_addButton setTitle:@"添加" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _addButton.layer.borderWidth = 1;
    _addButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _addButton.layer.cornerRadius = 10;
    _addButton.layer.masksToBounds = YES;
    [_addButton addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    
}

- (void)backClick{
    [_sjyView.nameTextField resignFirstResponder];
    [_sjyView.numberTextField resignFirstResponder];
    [_sjyView.classTextField resignFirstResponder];
    [_sjyView.ageTextField resignFirstResponder];
    [_sjyView.gradeTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressAdd{
    
    [_sjyView.nameTextField resignFirstResponder];
    [_sjyView.numberTextField resignFirstResponder];
    [_sjyView.classTextField resignFirstResponder];
    [_sjyView.ageTextField resignFirstResponder];
    [_sjyView.gradeTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认添加" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addStu];
    }];
    [alert addAction:okAlert];
    
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAlert];
}

- (void)addStu{
    _stuNew.nameStu = _sjyView.nameTextField.text;
    _stuNew.numberStu = _sjyView.numberTextField.text;
    _stuNew.classStu = _sjyView.classTextField.text;
    _stuNew.ageStu = _sjyView.ageTextField.text;
    _stuNew.gradeStu = _sjyView.gradeTextField.text;
    
    StudentNSO *stuNSO = [[StudentNSO alloc]init];
    int i;
    for (i = 0; i < [_addMutableArray count]; i++) {
        stuNSO = _addMutableArray[i];
        if ([stuNSO.numberStu isEqualToString:_stuNew.numberStu]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此同学已存在" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAlert];
            break;
        }
    }
    if (i == [_addMutableArray count]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"信息添加成功！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.5];
        [self dismissViewControllerAnimated:YES completion:nil];
        [_addMutableArray addObject:_stuNew];
        if ([_delegate respondsToSelector:@selector(array:)]) {
            [_delegate array:_addMutableArray];
        }
        [_addTableView reloadData];
    }
}
- (void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    [_sjyView.nameTextField resignFirstResponder];
    [_sjyView.numberTextField resignFirstResponder];
    [_sjyView.classTextField resignFirstResponder];
    [_sjyView.ageTextField resignFirstResponder];
    [_sjyView.gradeTextField resignFirstResponder];
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


#pragma mark -- 单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_addMutableArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentNSO *stuNSO = [[StudentNSO alloc]init];
    stuNSO = _addMutableArray[indexPath.row];
    
    SJYTableViewCell *sjyCell = [_addTableView dequeueReusableCellWithIdentifier:strCell forIndexPath:indexPath];
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
