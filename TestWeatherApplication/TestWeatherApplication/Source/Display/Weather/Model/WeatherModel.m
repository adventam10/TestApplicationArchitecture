//
//  WeatherModel.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherModel.h"

//=======================================================
// 天気画面用Model
//=======================================================

@implementation WeatherModel

#pragma mark - Request
/**
 天気情報取得処理
 
 @param cityId 対象都道府県ID
 @param success 通信成功時の処理
 @param failure 通信失敗時の処理
 @return タスク
 */
- (NSURLSessionDataTask *)requestWeatherWithCityId:(NSString *)cityId
                                           success:(void (^)(void))success
                                           failure:(void (^)(NSString *message, NSError *error))failure
{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task =
    [WeatherNetworkManager requestWeatherWithCityId:cityId
                                            success:^(NSDictionary *json)
    {
        weakSelf.weatherResponse = [[WeatherResponse alloc] initWithDictionary:json];
        if (success) {
            
            success();
        }
    }
                                            failure:failure];
    
    return task;
}

@end
