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

@end
