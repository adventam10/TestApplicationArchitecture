//
//  WeatherViewModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherViewController.h"
#import "WeatherModel.h"

@interface WeatherViewModel : NSObject

@property (nonatomic) WeatherModel *model;

@property (nonatomic, weak) WeatherViewController *viewController;

/**
 画面初期表示時の処理
 */
- (void)setupData;

#pragma mark - User Action
/**
 再読み込みボタン押した時の処理
 */
- (void)didTapRefreshButton;

@end
