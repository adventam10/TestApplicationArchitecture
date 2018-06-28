//
//  WeatherViewController.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherViewController : UIViewController

/**
 プレゼンターの設定
 
 @param model モデル
 */
- (void)setupPresenterWithModel:(WeatherModel *)model;

#pragma mark - Display Data
/**
 タイトルを表示する

 @param title タイトル
 */
- (void)displayTitle:(NSString *)title;

/**
 天気を表示する（今日・明日・明後日の３日分）
 
 @param forecasts 天気情報一覧
 */
- (void)displayForecasts:(NSArray <WeatherResponseForecast *> *)forecasts;

#pragma mark - Show
/**
 「確認」ボタンのみのアラートを表示する
 
 @param title タイトル
 @param message メッセージ
 @param yesBlock 「確認」押した時の処理
 */
- (void)showAlertYesOnlyWithTitle:(NSString *)title
                          message:(NSString *)message
                         yesBlock:(void (^)(void))yesBlock;
@end
