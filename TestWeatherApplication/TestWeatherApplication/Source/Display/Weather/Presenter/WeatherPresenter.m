//
//  WeatherPresenter.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherPresenter.h"

@implementation WeatherPresenter

/**
 画面初期表示時の処理
 */
- (void)setupData
{
    [self.viewController displayTitle:self.model.prefectureInfo.name];
    [self.viewController displayForecasts:self.model.weatherResponse.forecasts];
}


#pragma mark - User Action
/**
 再読み込みボタン押した時の処理
 */
- (void)didTapRefreshButton
{
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [self.model requestWeatherWithCityId:self.model.prefectureInfo.cityId
                                 success:^
     {
         [SVProgressHUD dismiss];
         [weakSelf.viewController displayForecasts:weakSelf.model.weatherResponse.forecasts];
         
     }
                                 failure:^(NSString *message, NSError *error)
     {
         [SVProgressHUD dismiss];
         [weakSelf.viewController showAlertYesOnlyWithTitle:@""
                                                    message:message
                                                   yesBlock:nil];
     }];
}

@end
