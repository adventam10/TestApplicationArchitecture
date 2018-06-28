//
//	WeatherResponseMax.h
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface WeatherResponseMax : NSObject

@property (nonatomic, strong) NSString * celsius;
@property (nonatomic, strong) NSString * fahrenheit;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
