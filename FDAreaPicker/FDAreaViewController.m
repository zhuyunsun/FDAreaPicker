//
//  FDAreaViewController.m
//  FDAreaPicker
//
//  Created by 朱运 on 2018/1/15.
//  Copyright © 2018年 zhuyun. All rights reserved.
//
#define WindowWidth [UIScreen mainScreen].bounds.size.width
#define WindowHeight [UIScreen mainScreen].bounds.size.height

#import "FDAreaViewController.h"
#import "FDAreaPicker.h"
@interface FDAreaViewController ()<FDAreaDelegate>{
    UILabel *_selectLabel;
    FDAreaPicker *_areaPicker;
    
}
@property(nonatomic,strong)UIButton *showButton;
@end

@implementation FDAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"省市的选择器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _showButton.frame = CGRectMake(0, 0, WindowWidth / 6, WindowHeight / 18);
    _showButton.center = CGPointMake(WindowWidth / 2, WindowHeight / 6);
    [_showButton setTitle:@"show" forState:UIControlStateNormal];
    [_showButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _showButton.layer.cornerRadius = 4;
    _showButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _showButton.layer.borderWidth = 0.77;
    [_showButton addTarget:self action:@selector(showButtonAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_showButton];
    
    _selectLabel = [[UILabel alloc]init];
    _selectLabel.frame = CGRectMake(0, 0, WindowWidth / 3, WindowHeight / 15);
    _selectLabel.center = CGPointMake(WindowWidth / 2 , WindowHeight / 6 + WindowHeight / 9);
    _selectLabel.backgroundColor = [UIColor lightGrayColor];
    _selectLabel.textColor = [UIColor whiteColor];
    _selectLabel.layer.cornerRadius = 3;
    _selectLabel.clipsToBounds = YES;
    _selectLabel.font = [UIFont systemFontOfSize:13];
    _selectLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_selectLabel];

    _areaPicker = [[FDAreaPicker alloc]init];
    _areaPicker.delegate = self;
}
-(void)showButtonAction{
    NSLog(@"action ");
    [_areaPicker showAreaView];
}
#pragma mark -- ======== delegate =========
-(void)cancelAction{
    NSLog(@"cancel");
}
-(void)selectArea:(NSString *)area{
    _selectLabel.text = area;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
