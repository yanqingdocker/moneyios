//
//  CGMyProfileViewController.m
//  pay
//
//  Created by v2 on 2018/8/22.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGMyProfileViewController.h"

@interface CGMyProfileViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UITableView *_tableView;
    NSDictionary *_dataArray;
    UIImageView *_headImgView;
}

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@end

@implementation CGMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestForm];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] getuserWithserverSuccessFn:^(id dict) {
                if(dict){
                    
                    _dataArray = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    
//                    _dataArray = result[6];
                    NSLog(@"%@",_dataArray);

                    [_tableView reloadData];
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        });
    });
    
}
- (void)initNav{
    self.navigationItem.title = @"我的资料";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 0, SCREEN_WIDTH,294);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
        return 3;
//    }
//    else{
//        return 3;
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;//section头部高度
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGMyProfileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = @"头像";
            
            _headImgView = [[UIImageView alloc] init];
            _headImgView.frame = CGRectMake(SCREEN_WIDTH - 30 - 40, 2, 40, 40);
            //圆形图片
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_headImgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_headImgView.bounds.size];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            //设置大小
            maskLayer.frame = _headImgView.bounds;
            //设置图形样子
            maskLayer.path = maskPath.CGPath;
            _headImgView.layer.mask = maskLayer;
            
            if(_dataArray){
                NSData *data=[[NSData alloc] initWithBase64EncodedString:[_dataArray objectForKey:@"img"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                _headImgView.image = [UIImage imageWithData:data];
                
            }else{
                _headImgView.image = [UIImage imageNamed:@"_headImgView"];
            }
            
            [cell addSubview:_headImgView];
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"用户名";
            if(_dataArray){
                cell.detailTextLabel.text = [_dataArray objectForKey:@"username"];
            }else{
                cell.detailTextLabel.text = @"未设置";
            }
        }
        if(indexPath.row == 2){
            cell.textLabel.text = @"手机号";
            if(_dataArray){
                cell.detailTextLabel.text = [_dataArray objectForKey:@"phone"];
            }else{
                cell.detailTextLabel.text = @"未设置";
            }
        }
    }
    if (indexPath.section == 1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"地区";
            if(_dataArray){
                cell.detailTextLabel.text = [_dataArray objectForKey:@"address"];
            }else{
                cell.detailTextLabel.text = @"未设置";
            }
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"实名认证";
            if(_dataArray){
                if([[_dataArray objectForKey:@"isauthentication"] integerValue] == 1){
                    cell.detailTextLabel.text = @"已认证";
                }else{
                    cell.detailTextLabel.text = @"未认证";
                }
            }else{
                cell.detailTextLabel.text = @"未认证";
            }
            
            
        }
        if(indexPath.row == 2){
            cell.textLabel.text = @"电子邮箱";
            if(_dataArray){
                cell.detailTextLabel.text = [_dataArray objectForKey:@"email"];
            }else{
                cell.detailTextLabel.text = @"未设置";
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        if(indexPath.row == 0){
            //            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
            //            [self pushViewControllerHiddenTabBar:txvc animated:YES];
            [self headClick];
        }
        if(indexPath.row == 1){
            //            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
            //            [self pushViewControllerHiddenTabBar:txvc animated:YES];
            
        }
        if(indexPath.row == 2){
            //            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
            //            [self pushViewControllerHiddenTabBar:txvc animated:YES];
            
        }
    }
    if (indexPath.section == 1){
        if(indexPath.row == 0){
            //            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
            //            [self pushViewControllerHiddenTabBar:txvc animated:YES];
            
        }
        if(indexPath.row == 1){
            //            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
            //            [self pushViewControllerHiddenTabBar:txvc animated:YES];
            
        }
        if(indexPath.row == 2){
            //            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
            //            [self pushViewControllerHiddenTabBar:txvc animated:YES];
            
        }
    }
    
}

#pragma mark -头像UIImageview的点击事件-
- (void)headClick {
    //自定义消息框
    //    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    //    sheet.tag = 2550;
    //    //显示消息框
    //    [sheet showInView:self.view];
    
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

//获取选择的图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    [_headImgView setImage:image forState:UIControlStateNormal];
    _headImgView.image = image;
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //上传头像代码写下面

    [[CGAFHttpRequest shareRequest] uploadimgAllWithimg:encodedImageStr serverSuccessFn:^(id dict) {
        if(dict){
            
            _dataArray = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            
            NSLog(@"%@",_dataArray);
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"error:%@",error);
        }
    }];
}


//从相机或者相册界面弹出
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
