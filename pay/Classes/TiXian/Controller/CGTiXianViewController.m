//
//  CGTiXianViewController.m
//  pay
//
//  Created by v2 on 2018/8/2.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTiXianViewController.h"
#import "MBProgressHUD.h"
#import "CGBounceView.h"
#import "CGTiXianTiKuanViewController.h"

@interface CGTiXianViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
//    UITableView *_tableview;
//    UITextField *_cardID;
    UITextField *_name;
    UITextField *_zhihang;
    
    NSArray *_nameArray;
    NSString *_moneyType;
    UIView *_okornoView;
    NSInteger currentIndex;
    CGBounceView *_tuanNumView;
}
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) NSString *bank;
@property (strong, nonatomic) UITextField *cardID;
@end

@implementation CGTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UI
- (void)initNav {
    self.navigationItem.title = @"提现";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-0);
    _tableview=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.bounces = NO;
    _tableview.estimatedRowHeight = 0;
    _tableview.estimatedSectionHeaderHeight = 0;
    _tableview.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableview];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(20, 0+ 45*5 + 20, SCREEN_WIDTH-20*2, 44);
    nextBtn.tag = 1010;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [nextBtn setBackgroundImage:[UIImage imageNamed:@"ldb"] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 10.0;
    nextBtn.backgroundColor = [UIColor colorWithHexString:@"f7c36d"];
    [nextBtn addTarget:self action:@selector(nextTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    UILabel *tiXianTip = [[UILabel alloc] initWithFrame:CGRectMake(0, nextBtn.frame.origin.y + 2 + 44, SCREEN_WIDTH, 30)];
    tiXianTip.text = @"新卡直接录入，系统将自动保存";
    tiXianTip.font = [UIFont systemFontOfSize:14];
    tiXianTip.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tiXianTip];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-160, self.view.frame.size.width, 160)];
    
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.hidden = YES;
    self.pickerView.delegate = self;
    
    self.pickerView.dataSource = self;
    
    [self.view addSubview:self.pickerView];
    
    _okornoView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-160-30, self.view.frame.size.width, 30)];
    _okornoView.hidden = YES;
    _okornoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_okornoView];
    UIButton *button=[[UIButton alloc]init];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    button.frame=CGRectMake(20, 5, 40, 30);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [_okornoView addSubview:button];
    UIButton *button1=[[UIButton alloc]init];
    button1.titleLabel.font=[UIFont systemFontOfSize:14];
    button1.frame=CGRectMake(SCREEN_WIDTH - 60, 5, 40, 30);
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [_okornoView addSubview:button1];
    
    [self.pickerView reloadAllComponents];//刷新UIPickerView
    
    
    
    _nameArray = [NSArray arrayWithObjects:@"USD",@"CNY",nil];
}

- (void) finish{
    _okornoView.hidden = YES;
    self.pickerView.hidden = YES;
    
    if(_moneyType == nil){
        _moneyType = [NSString stringWithFormat:@"%@(0.00)",[_nameArray objectAtIndex:0]];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.text = _moneyType;
    cell.detailTextLabel.text = @"";
    [_tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
//退出登陆
-(void)nextTap:(id)sender
{
    //非空判断
//    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
//    hud.mode = MBProgressHUDModeText;
//    hud.animationType = MBProgressHUDAnimationZoom;
//
//    [self.view addSubview:hud];
//    if(_cardID.text.length == 0){
//        hud.labelText = @"请输入卡号";
//        [hud show:YES];
//        [hud hide:YES afterDelay:2.f];
//        return;
//    }else if(_name.text.length == 0) {
//        hud.labelText = @"请输入姓名";
//        [hud show:YES];
//        [hud hide:YES afterDelay:2.f];
//        return;
//    }else if(_zhihang.text.length == 0){
//        hud.labelText = @"请输入支行";
//        [hud show:YES];
//        [hud hide:YES afterDelay:2.f];
//        return;
//    }
//
//    hud.labelText = [NSString stringWithFormat:@"卡号:%@,姓名:%@,支行:%@,银行:%@",_cardID.text,_name.text,_zhihang.text,_bank];
//    [hud show:YES];
//    [hud hide:YES afterDelay:2.f];
    
    CGTiXianTiKuanViewController *txtkvc = [[CGTiXianTiKuanViewController alloc] init];
    [self pushViewControllerHiddenTabBar:txtkvc animated:YES];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else{
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;//section头部高度
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGTiXianCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0){
        if(_moneyType == nil){
            _moneyType = @"CNY(0.00)";
        }
        cell.textLabel.text = _moneyType;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"卡号";
                _cardID = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, SCREEN_WIDTH-90-50, 34)];
                _cardID.placeholder = [NSString stringWithFormat:@"%@",@"请选择或输入卡号"];
                UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 2, 40, 40)];
                [iconBtn setImage:[UIImage imageNamed:@"bankcard"] forState:UIControlStateNormal];
                [iconBtn addTarget:self action:@selector(selectbankcard) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:iconBtn];
                [cell addSubview:_cardID];
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"姓名";
                _name = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, SCREEN_WIDTH-90-50, 34)];
                _name.placeholder = [NSString stringWithFormat:@"%@",@"持卡人姓名"];
                [cell addSubview:_name];
                
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"银行";
                if(_bank == nil){
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@"请选择银行"];
                }else{
                    cell.detailTextLabel.text = _bank;
                }
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"支行";
                _zhihang = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, SCREEN_WIDTH-90-50, 34)];
                _zhihang.placeholder = [NSString stringWithFormat:@"%@",@"银行开户支行"];
                [cell addSubview:_zhihang];
                
            }
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        _moneyType = nil;
        currentIndex = indexPath.row;
        self.pickerView.hidden = NO;
        _okornoView.hidden = NO;
    }
    if (indexPath.section == 1){
        if(indexPath.row == 2){
            
        }
    }
}

#pragma mark pickerview function



//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
//    if (component==0) {
//
//        return  5;
//
//    } else if(component==1){
//
//
//
//        return  [_nameArray count];
//
//    }
    
    return [_nameArray count];
    
}

//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 50.0f;
    
}

//返回指定列的宽度

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
//    if (component==0) {//iOS6边框占10+10
//
//        return  self.view.frame.size.width/3;
//
//    } else if(component==1){
//
//        return  self.view.frame.size.width/3;
//
//    }
    
    return  self.view.frame.size.width;
    
}



// 自定义指定列的每行的视图，即指定列的每行的视图行为一致

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (!view){
        
        view = [[UIView alloc]init];
        
    }
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    text.textAlignment = NSTextAlignmentCenter;
    
    text.text = [_nameArray objectAtIndex:row];
    
    [view addSubview:text];
    
    //隐藏上下直线
    
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    
    return view;
    
}

//显示的标题

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_nameArray objectAtIndex:row];
    
    return str;
    
}

//显示的标题字体、颜色等属性

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_nameArray objectAtIndex:row];
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    
    
    return AttributedString;
    
}//NS_AVAILABLE_IOS(6_0);



//被选择的行

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _moneyType = [NSString stringWithFormat:@"%@(0.00)",[_nameArray objectAtIndex:row]];
}


//
- (void)selectbankcard{
    _tuanNumView = [[CGBounceView alloc]init];
    _tuanNumView.BVtitle = @"选择储值银行卡";
    _tuanNumView.tuanModel = _nameArray;
    [_tuanNumView showInView:self.view];
    //            __weak __typeof(self)wself = self;
    __block CGTiXianViewController *  blockSelf = self;
    _tuanNumView.selectbankcardblock = ^(NSString *str){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        
//        UITableViewCell *cell = [blockSelf.tableview cellForRowAtIndexPath:indexPath];
        blockSelf.cardID.text = str;
        
        [blockSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
}
@end
