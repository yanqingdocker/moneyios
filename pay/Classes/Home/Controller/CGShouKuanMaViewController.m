//
//  CGShouKuanMaViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/24.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGShouKuanMaViewController.h"
#import "HMScannerController.h"

@interface CGShouKuanMaViewController ()

@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation CGShouKuanMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData *data=[[NSData alloc] initWithBase64EncodedString:[GlobalSingleton Instance].currentUser.img options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *cardName = [GlobalSingleton Instance].currentUser.username;
    
    UIImage *avatar;
    if(data == nil){
        avatar = [UIImage imageNamed:@"headImg"];
    }else{
        avatar = [UIImage imageWithData:data];
    }
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:_imageView];
    
    [HMScannerController cardImageWithCardName:cardName avatar:avatar scale:0.2 completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
