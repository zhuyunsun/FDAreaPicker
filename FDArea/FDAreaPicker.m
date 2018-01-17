//
//  FDAreaPicker.m
//  FDAreaPicker
//
//  Created by 朱运 on 2018/1/15.
//  Copyright © 2018年 zhuyun. All rights reserved.
//

#import "FDAreaPicker.h"

@interface FDAreaPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSMutableArray *_proviceArray;
    NSMutableArray *_cityArray;
    
    NSString *_selectProviceString;
    NSString *_selectCityString;
    NSString *_selectArea;
    
    CGFloat windowWidth;
    CGFloat windowHeight;
    
    UIButton *baseButton;
    UIView *bottomView;
    
    CGFloat bottomViewHeight;

}
@property(nonatomic,strong)UIView *barView;
@property(nonatomic,strong)UIPickerView *areaPickView;
@end
@implementation FDAreaPicker
-(instancetype)init{
    self = [super init];
    if (self) {
        windowWidth = [UIScreen mainScreen].bounds.size.width;
        windowHeight = [UIScreen mainScreen].bounds.size.height;

    }
    return self;
}
-(void)loadMessage{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"city" ofType:@"plist"];
    NSArray *areaArray = [[NSArray alloc]initWithContentsOfFile:path];
    //        NSLog(@"area = %@",areaArray);
    _proviceArray = [[NSMutableArray alloc]init];
    _cityArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < areaArray.count; i++) {
        ProviceModel *model1 = [[ProviceModel alloc]init];
        model1.proviceNameString = areaArray[i][@"State"];
        model1.cityArray = areaArray[i][@"Cities"];
        [_proviceArray addObject:model1];
//        NSLog(@"proviceNameString = %@",model1.proviceNameString);
        
        if (i == 0) {
            for (int j = 0; j < model1.cityArray.count; j ++) {
                CityModel *model2 = [[CityModel alloc]init];
                model2.cityNameString = model1.cityArray[j][@"city"];
                [_cityArray addObject:model2];
            if (j == 0) {
                _selectCityString = model2.cityNameString;
            }
          _selectProviceString = model1.proviceNameString;
        }
      }
   }
//     NSLog(@"默认 = %@-%@",_selectProviceString,_selectCityString);
}
#pragma mark delegate
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //设置字体大小;
    UILabel *lbl = (UILabel *)view;
    if (lbl == nil) {
        lbl = [[UILabel alloc]init];
        //在这里设置字体相关属性
        lbl.font = [UIFont systemFontOfSize:13];
        lbl.textColor = [UIColor grayColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setBackgroundColor:[UIColor clearColor]];
        if (component == 0) {
            lbl.textColor = [UIColor redColor];
        }
    }
    //重新加载lbl的文字内容
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return lbl;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        ProviceModel *moel1 = _proviceArray[row];
        return moel1.proviceNameString;
    }
    if (component == 1) {
        CityModel *model2 = _cityArray[row];
        NSString *cityName = model2.cityNameString;
        if ([cityName isEqualToString:@"香港"] || [cityName isEqualToString:@"澳门"]) {
            return cityName;
        }
        return [NSString stringWithFormat:@"%@市",cityName];
    }
    return @"area";
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _proviceArray.count;
    }
    if (component == 1) {
        return _cityArray.count;
    }
    return 5;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [_cityArray removeAllObjects];
        ProviceModel *moel1 = _proviceArray[row];
        _selectProviceString = moel1.proviceNameString;
        
        for (int i = 0; i < moel1.cityArray.count; i ++) {
            CityModel *model2 = [[CityModel alloc]init];
            model2.cityNameString = moel1.cityArray[i][@"city"];
            [_cityArray addObject:model2];
        }
        [self.areaPickView reloadComponent:1];
        [self.areaPickView selectRow:0 inComponent:1 animated:YES];
        
        CityModel *model3 = _cityArray[0];
        _selectCityString = model3.cityNameString;
    }
    if (component == 1) {
        CityModel *model2 = _cityArray[row];
        _selectCityString = model2.cityNameString;
    }
//    NSLog(@"默认 = %@-%@",_selectProviceString,_selectCityString);
}
-(void)loadView{
    bottomViewHeight = windowHeight / 3;
    CGFloat Y = windowHeight - bottomViewHeight;
    //    Y = windowWidth / 2;
    bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0,Y, windowWidth,bottomViewHeight);
    bottomView.backgroundColor = [UIColor whiteColor];
    
    [self loadBarView];
    
    
    CGRect rect = CGRectMake(0,CGRectGetMaxY(self.barView.frame), windowWidth, bottomViewHeight - CGRectGetHeight(self.barView.frame));
    self.areaPickView = [[UIPickerView alloc]init];
    self.areaPickView.frame = rect;
    self.areaPickView.delegate = self;
    self.areaPickView.dataSource = self;
    //    self.areaPickView.hidden = YES;
    self.areaPickView.showsSelectionIndicator = YES;
    [bottomView addSubview:self.areaPickView];

}
-(void)loadBarView{
    CGFloat width = windowWidth;
    CGFloat height = bottomViewHeight / 6;
    
    self.barView = [[UIView alloc]init];
    self.barView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    self.barView.frame = CGRectMake(0, 0, width, height);
    [bottomView addSubview:self.barView];
    
    //    self.selectDateLabel = [[UILabel alloc]init];
    //    self.selectDateLabel.frame = CGRectMake(width / 3, 0, width / 3, height);
    //    self.selectDateLabel.textColor = [UIColor blackColor];
    //    self.selectDateLabel.textAlignment = NSTextAlignmentCenter;
    //    self.selectDateLabel.font = [UIFont systemFontOfSize:12];
    //    [self.barView addSubview:self.selectDateLabel];
    
    
    CGFloat buttonWidth = width / 6;
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame = CGRectMake(0, 0, buttonWidth, height);
    [selectButton setTitle:@"确定" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectButtonAction) forControlEvents:UIControlEventTouchDown];
    selectButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.barView addSubview:selectButton];
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(width - buttonWidth, 0, buttonWidth, height);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cancleButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchDown];
    [self.barView addSubview:cancleButton];
    
}
-(void)showAreaView{
    [self loadMessage];
    [self loadView];
    
    UIColor *color = [UIColor blackColor];
    baseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baseButton.frame = CGRectMake(0, 0, windowWidth, windowHeight);
    baseButton.backgroundColor = [color colorWithAlphaComponent:0.35];
    baseButton.alpha = 0;
//    [baseButton addTarget:picker action:@selector(baseButtonAction) forControlEvents:UIControlEventTouchDown];
    
    [baseButton addSubview:bottomView];

    [[UIApplication sharedApplication].keyWindow addSubview:baseButton];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
    [UIView animateWithDuration:0.33 animations:^{
        baseButton.alpha = 1;
    } completion:^(BOOL finished) {
        baseButton.backgroundColor = [color colorWithAlphaComponent:0.35];
    }];

}
-(void)cancleAction{
    [self.delegate cancelAction];
    [self removeBaseButton];
}
-(void)removeBaseButton{
    [UIView animateWithDuration:0.22 animations:^{
        baseButton.alpha = 0;
    } completion:^(BOOL finished) {
        [baseButton removeFromSuperview];
    }];
}
-(void)selectButtonAction{
    NSString *area = [NSString stringWithFormat:@"%@-%@",_selectProviceString,_selectCityString];
    [self.delegate selectArea:area];
    [self removeBaseButton];
}

@end

@implementation ProviceModel
@end


@implementation CityModel
@end
