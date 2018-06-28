//
//  WeatherInfoBaseView.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherResponse.h"

@interface WeatherInfoBaseView : UIView

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *subDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *telopLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxCelsiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *minCelsiusLabel;

#pragma mark - Display Data
/**
 天気情報を表示する
 
 @param forecast 天気情報
 @param subDateText 日付文字列（yyyy/MM/dd(E)形式）
 */
- (void)displayForecast:(WeatherResponseForecast *)forecast
            subDateText:(NSString *)subDateText;

@end
