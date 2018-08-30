//
//  CGEmailContentView.m
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGEmailContentView.h"

@interface CGEmailContentView (){
    UIView *_contentView;
}

@end

@implementation CGEmailContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContent];
}

- (void)setupContent {
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (_contentView == nil) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 290)/2, 92, 290, 300)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
        
        //title
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, _contentView.frame.size.width, 17)];
        titleLabel.text = _titleStr;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:titleLabel];
        
        UILabel *line = [[UILabel alloc] init];
        line.frame = CGRectMake(0, 51, _contentView.frame.size.width, 1);
        line.backgroundColor = RGB(217,221,240,0.8);
        [_contentView addSubview:line];
        
        UILabel *contentLab = [[UILabel alloc] init];
        contentLab.frame = CGRectMake(40, 66, _contentView.frame.size.width - 40*2 , 218);
        contentLab.text = _content;
        contentLab.font = [UIFont systemFontOfSize:12];
        contentLab.numberOfLines = 0;
        [_contentView addSubview:contentLab];
        
    }
    
    
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self.view];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.alpha = 1.0;
        
        [_contentView setFrame:CGRectMake((SCREEN_WIDTH - 290)/2, 92, 290, 300)];
        
    } completion:nil];
}
- (void)disMissView {
    
    [_contentView setFrame:CGRectMake((SCREEN_WIDTH - 290)/2, 92, 290, 300)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.view.alpha = 0.0;
                         
                         [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300)];
                     }
                     completion:^(BOOL finished){
                         
                         [self.view removeFromSuperview];
                         [_contentView removeFromSuperview];
                         
                     }];
    
}


@end
