//
//	WeatherResponseCopyright.h
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "WeatherResponseImage.h"
#import "WeatherResponseProvider.h"

@interface WeatherResponseCopyright : NSObject

@property (nonatomic, strong) WeatherResponseImage * image;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSArray <WeatherResponseProvider *> * provider;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
