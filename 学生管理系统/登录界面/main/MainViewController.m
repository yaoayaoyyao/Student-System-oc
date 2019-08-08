//
//  MainViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/7.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "MainViewController.h"
#import "AddViewController.h"
#import "DeleteViewController.h"
#import "ModifyViewController.h"
#import "SeekViewController.h"
#import "AllViewController.h"
#import "StudentNSO.h"

@interface MainViewController ()<AddViewControllerDelegate,DeleteViewControllerDelegate,ModifyViewControllerDelegate>

@property NSMutableArray *nameMutableArray;
@property NSMutableArray *numberMutableArray;
@property NSMutableArray *classMutableArray;
@property NSMutableArray *ageMutableArray;
@property NSMutableArray *gradeMutableArray;

@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong)UIButton *deleteButton;
@property (nonatomic, strong)UIButton *modifyButton;
@property (nonatomic, strong)UIButton *seekButton;
@property (nonatomic, strong)UIButton *allButton;
@property (nonatomic, strong)UIButton *backButton;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
// 值
    _nameMutableArray = [NSMutableArray arrayWithObjects:@"贺朝", @"谢俞", @"魏无羡", @"蓝忘机", nil];
    _numberMutableArray = [NSMutableArray arrayWithObjects:@"04183001", @"04183002", @"04183003", @"04183004", nil];
    _classMutableArray = [NSMutableArray arrayWithObjects:@"软件1801", @"软件1801", @"软件1802", @"软件1802", nil];
    _ageMutableArray = [NSMutableArray arrayWithObjects:@"18", @"17", @"16", @"17", nil];
    _gradeMutableArray = [NSMutableArray arrayWithObjects:@"100", @"100", @"100", @"100", nil];
    _studentMutableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [_nameMutableArray count]; i++) {
        StudentNSO *stuNSO = [[StudentNSO alloc]init];
        stuNSO.nameStu = _nameMutableArray[i];
        stuNSO.numberStu = _numberMutableArray[i];
        stuNSO.classStu = _classMutableArray[i];
        stuNSO.ageStu = _ageMutableArray[i];
        stuNSO.gradeStu = _gradeMutableArray[i];
        [_studentMutableArray addObject:stuNSO];
    }
    
// 界面
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"button.png"];
    [self.view addSubview:backImageView];
    
    
    _addButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 160, 101, 50)];
    [self.view addSubview:_addButton];
    [_addButton setTitle:@" 添加" forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"plus2.png"] forState:UIControlStateNormal];
    _addButton.layer.borderWidth = 1;
    _addButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _addButton.layer.cornerRadius = 10;
    _addButton.layer.masksToBounds = YES;
    _addButton.backgroundColor = [UIColor colorWithRed:0.27f green:0.54f blue:0.55f alpha:1.00f];
    [_addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake( 50, 287, 101, 50)];
    [self.view addSubview:_deleteButton];
    [_deleteButton setTitle:@" 删除" forState:UIControlStateNormal];
    [_deleteButton setImage:[UIImage imageNamed:@"delete2.png"] forState:UIControlStateNormal];
    _deleteButton.layer.borderWidth = 1;
    _deleteButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _deleteButton.layer.cornerRadius = 10;
    _deleteButton.layer.masksToBounds = YES;
    _deleteButton.backgroundColor = [UIColor colorWithRed:0.27f green:0.54f blue:0.55f alpha:1.00f];
    [_deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    _modifyButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 417, 101, 50)];
    [self.view addSubview:_modifyButton];
    [_modifyButton setTitle:@" 修改" forState:UIControlStateNormal];
    [_modifyButton setImage:[UIImage imageNamed:@"xiugai2.png"] forState:UIControlStateNormal];
    _modifyButton.layer.borderWidth = 1;
    _modifyButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _modifyButton.layer.cornerRadius = 10;
    _modifyButton.layer.masksToBounds = YES;
    _modifyButton.backgroundColor = [UIColor colorWithRed:0.27f green:0.54f blue:0.55f alpha:1.00f];
    [_modifyButton addTarget:self action:@selector(modifyClick) forControlEvents:UIControlEventTouchUpInside];
    
    _seekButton = [[UIButton alloc]initWithFrame:CGRectMake(224, 290, 101, 50)];
    [self.view addSubview:_seekButton];
    [_seekButton setTitle:@" 查询" forState:UIControlStateNormal];
    [_seekButton setImage:[UIImage imageNamed:@"chaxun2.png"] forState:UIControlStateNormal];
    _seekButton.layer.borderWidth = 1;
    _seekButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _seekButton.layer.cornerRadius = 10;
    _seekButton.layer.masksToBounds = YES;
    _seekButton.backgroundColor = [UIColor colorWithRed:0.27f green:0.54f blue:0.55f alpha:1.00f];
    [_seekButton addTarget:self action:@selector(seekClick) forControlEvents:UIControlEventTouchUpInside];
    
    _allButton = [[UIButton alloc]initWithFrame:CGRectMake(224, 420, 101, 50)];
    [self.view addSubview:_allButton];
    [_allButton setTitle:@" 全部" forState:UIControlStateNormal];
    [_allButton setImage:[UIImage imageNamed:@"all.png"] forState:UIControlStateNormal];
    _allButton.layer.borderWidth = 1;
    _allButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _allButton.layer.cornerRadius = 10;
    _allButton.layer.masksToBounds = YES;
    _allButton.backgroundColor = [UIColor colorWithRed:0.27f green:0.54f blue:0.55f alpha:1.00f];
    [_allButton addTarget:self action:@selector(allClick) forControlEvents:UIControlEventTouchUpInside];
    
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(224, 550, 101, 50)];
    [self.view addSubview:_backButton];
    [_backButton setTitle:@" 退出" forState:UIControlStateNormal];
    [_backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    _backButton.layer.borderWidth = 1;
    _backButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _backButton.layer.cornerRadius = 10;
    _backButton.layer.masksToBounds = YES;
    _backButton.backgroundColor = [UIColor colorWithRed:0.27f green:0.54f blue:0.55f alpha:1.00f];
    [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35, 520, 150, 150)];
    headImageView.image = [UIImage imageNamed:@"head.png"];
    [self.view addSubview:headImageView];
}

#pragma mark -- 按钮点击事件
- (void)addClick{
    AddViewController *addViewController = [[AddViewController alloc]init];
    addViewController.addMutableArray = _studentMutableArray;
    addViewController.delegate = self;
    addViewController.view.backgroundColor = [UIColor whiteColor];
    addViewController.title = @"添加";
    addViewController.navigationController.navigationBar.translucent = NO;
    UINavigationController *addNavigationController = [[UINavigationController alloc]initWithRootViewController:addViewController];
    [self presentViewController:addNavigationController animated:YES completion:nil];
}
- (void)deleteClick{
    DeleteViewController *deleteViewController = [[DeleteViewController alloc]init];
    deleteViewController.deleteMutableArray = _studentMutableArray;
    deleteViewController.delegate = self;
    deleteViewController.view.backgroundColor = [UIColor whiteColor];
    deleteViewController.title = @"删除";
    deleteViewController.navigationController.navigationBar.translucent = NO;
    UINavigationController *deleteNavigationController = [[UINavigationController alloc]initWithRootViewController:deleteViewController];
    [self presentViewController:deleteNavigationController animated:YES completion:nil];
}
- (void)modifyClick{
    ModifyViewController *modifyViewController = [[ModifyViewController alloc]init];
    modifyViewController.modifyMutableArray = _studentMutableArray;
    modifyViewController.delegate = self;
    modifyViewController.view.backgroundColor = [UIColor whiteColor];
    modifyViewController.title = @"修改";
    modifyViewController.navigationController.navigationBar.translucent = NO;
    UINavigationController *modifyNavigationController = [[UINavigationController alloc]initWithRootViewController:modifyViewController];
    [self presentViewController:modifyNavigationController animated:YES completion:nil];
}
- (void)seekClick{
    SeekViewController *seekViewController = [[SeekViewController alloc]init];
    seekViewController.seekMutableArray = _studentMutableArray;
    seekViewController.view.backgroundColor = [UIColor whiteColor];
    seekViewController.title = @"查询";
    seekViewController.navigationController.navigationBar.translucent = NO;
    UINavigationController *seekNavigationController = [[UINavigationController alloc]initWithRootViewController:seekViewController];
    [self presentViewController:seekNavigationController animated:YES completion:nil];
}
- (void)allClick{
    AllViewController *allViewController = [[AllViewController alloc]init];
    allViewController.allMutableArray = _studentMutableArray;
    allViewController.view.backgroundColor = [UIColor whiteColor];
    allViewController.title = @"全部信息";
    allViewController.navigationController.navigationBar.translucent = NO;
    UINavigationController *allNavigationController = [[UINavigationController alloc]initWithRootViewController:allViewController];
    [self presentViewController:allNavigationController animated:YES completion:nil];
}
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
