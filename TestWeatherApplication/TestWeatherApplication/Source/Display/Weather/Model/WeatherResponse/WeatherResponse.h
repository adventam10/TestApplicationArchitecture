//
//	WeatherResponse.h
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "WeatherResponseCopyright.h"
#import "WeatherResponseDescription.h"
#import "WeatherResponseForecast.h"
#import "WeatherResponseLocation.h"
#import "WeatherResponseProvider.h"

@interface WeatherResponse : NSObject

@property (nonatomic, strong) WeatherResponseCopyright * copyright;
@property (nonatomic, strong) WeatherResponseDescription * descriptionField;
@property (nonatomic, strong) NSArray <WeatherResponseForecast *> * forecasts;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) WeatherResponseLocation * location;
@property (nonatomic, strong) NSArray <WeatherResponseProvider *> * pinpointLocations;
@property (nonatomic, strong) NSString * publicTime;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
