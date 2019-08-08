//
//  AllViewController.m
//  登录界面
//
//  Created by 沈君瑶 on 2019/8/5.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "AllViewController.h"
#import "SJYTableViewCell.h"
#import "StudentNSO.h"

@interface AllViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *allTableView;
@property NSInteger flag;

@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _flag = 0;
    
// 界面
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"2.png"];
    [self.view addSubview:backImageView];
    
    
// 导航栏
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_img.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    leftButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
// 单元格
    _allTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //注册
    [self.allTableView registerClass:[SJYTableViewCell class] forCellReuseIdentifier:@"SJYTableViewCell"];
    _allTableView.delegate = self;
    _allTableView.dataSource = self;
    _allTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_allTableView];
    _allTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 单元格
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_allMutableArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StudentNSO *stuNSO = [[StudentNSO alloc]init];
    stuNSO = _allMutableArray[indexPath.row];
    
    
    static NSString *SJYCell = @"SJYTableViewCell";
    SJYTableViewCell *sjyCell = [_allTableView dequeueReusableCellWithIdentifier:SJYCell forIndexPath:indexPath];
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
