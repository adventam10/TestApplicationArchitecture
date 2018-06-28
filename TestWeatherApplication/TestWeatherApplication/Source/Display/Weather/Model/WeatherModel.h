//
//  WeatherModel.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherResponse.h"
#import "CityData.h"

@interface WeatherModel : NSObject

@property (nonatomic) WeatherResponse *weatherResponse;

@property (nonatomic) CityDataList *prefectureInfo;

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
                                           failure:(void (^)(NSString *message, NSError *error))failure;

@end