//
//	WeatherResponseTemperature.h
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "WeatherResponseMax.h"
#import "WeatherResponseMax.h"

@interface WeatherResponseTemperature : NSObject

@property (nonatomic, strong) WeatherResponseMax * max;
@property (nonatomic, strong) WeatherResponseMax * min;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
