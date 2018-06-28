//
//	WeatherResponseForecast.h
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "WeatherResponseImage.h"
#import "WeatherResponseTemperature.h"

@interface WeatherResponseForecast : NSObject

@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * dateLabel;
@property (nonatomic, strong) WeatherResponseImage * image;
@property (nonatomic, strong) NSString * telop;
@property (nonatomic, strong) WeatherResponseTemperature * temperature;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
