//
//  FDAreaPicker.h
//  FDAreaPicker
//
//  Created by 朱运 on 2018/1/15.
//  Copyright © 2018年 zhuyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol FDAreaDelegate;
@interface FDAreaPicker : NSObject
@property(nonatomic,weak)id<FDAreaDelegate>delegate;
-(void)showAreaView;
@end

@protocol FDAreaDelegate <NSObject>
@optional
/**
 省-市

 @param area 省市选择
 */
-(void)selectArea:(NSString *)area;
-(void)cancelAction;
@end
@interface ProviceModel: NSObject
@property(nonatomic,strong)NSString *proviceNameString;
@property(nonatomic,strong)NSMutableArray *cityArray;
@end

@interface CityModel :NSObject
@property(nonatomic,strong)NSString *cityNameString;
@end
