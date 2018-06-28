//
//  WeatherView.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherView.h"

//=======================================================
// 天気View
//=======================================================

@interface WeatherView()

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation WeatherView

#pragma mark - Initialize
/**
 初期設定を行う
 
 @return インスタンス
 */
- (instancetype)init
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                   owner:self
                                                 options:nil];
    self = array.firstObject;
    if (self) {
    
        [self setupDateFormatter];
    }
    
    return self;
}


#pragma mark - Setup DateFormatter
/**
 DateFormatterの設定を行う
 */
- (void)setupDateFormatter
{
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd(E)";
}


#pragma mark - Display Data
/**
 天気を表示する（今日・明日・明後日の３日分）
 
 @param forecasts 天気情報一覧
 */
- (void)displayForecasts:(NSArray <WeatherResponseForecast *> *)forecasts
{
    [self.todayView displayForecast:nil
                        subDateText:[self.dateFormatter stringFromDate:[NSDate date]]];
    [self.tommorowView displayForecast:nil
                           subDateText:[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24]]];
    [self.dayAfterTommorowView displayForecast:nil
                                   subDateText:[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*2]]];
    
    for (NSInteger i = 0; i < forecasts.count; i++) {
        
        if (i == 0) {
            
            [self.todayView displayForecast:forecasts[i]
                                subDateText:[self.dateFormatter stringFromDate:[NSDate date]]];
        }
        
        if (i == 1) {
            
            [self.tommorowView displayForecast:forecasts[i]
                                   subDateText:[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24]]];
        }
        
        if (i == 2) {
            
            [self.dayAfterTommorowView displayForecast:forecasts[i]
                                           subDateText:[self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*2]]];
        }
    }
}

@end
