//
//  WeatherNetworkManager.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/24.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@interface WeatherNetworkManager : NSObject

/**
 天気情報を取得する
 
 @param cityId 対象都市ID
 @param success 通信成功時の処理
 @param failure 通信失敗時の処理
 @return タスク
 */
+ (NSURLSessionDataTask *)requestWeatherWithCityId:(NSString *)cityId
                                           success:(NWMJsonSuccess)success
                                           failure:(NWMJsonFailure)failure;
@end
