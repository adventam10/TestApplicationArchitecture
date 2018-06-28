//
//	WeatherResponseLocation.h
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface WeatherResponseLocation : NSObject

@property (nonatomic, strong) NSString * area;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * prefecture;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
