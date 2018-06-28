//
//  WeatherView.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherInfoLargeView.h"
#import "WeatherInfoSmallView.h"

@interface WeatherView : UIView

@property (weak, nonatomic) IBOutlet WeatherInfoLargeView *todayView;
@property (weak, nonatomic) IBOutlet WeatherInfoSmallView *tommorowView;
@property (weak, nonatomic) IBOutlet WeatherInfoSmallView *dayAfterTommorowView;

#pragma mark - Display Data
/**
 天気を表示する（今日・明日・明後日の３日分）
 
 @param forecasts 天気情報一覧
 */
- (void)displayForecasts:(NSArray <WeatherResponseForecast *> *)forecasts;

@end
