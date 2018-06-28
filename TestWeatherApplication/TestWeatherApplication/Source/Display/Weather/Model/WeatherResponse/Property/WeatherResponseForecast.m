//
//	WeatherResponseForecast.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseForecast.h"

NSString *const kWeatherResponseForecastDate = @"date";
NSString *const kWeatherResponseForecastDateLabel = @"dateLabel";
NSString *const kWeatherResponseForecastImage = @"image";
NSString *const kWeatherResponseForecastTelop = @"telop";
NSString *const kWeatherResponseForecastTemperature = @"temperature";

@interface WeatherResponseForecast ()
@end
@implementation WeatherResponseForecast




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseForecastDate] isKindOfClass:[NSNull class]]){
		self.date = dictionary[kWeatherResponseForecastDate];
	}	
	if(![dictionary[kWeatherResponseForecastDateLabel] isKindOfClass:[NSNull class]]){
		self.dateLabel = dictionary[kWeatherResponseForecastDateLabel];
	}	
	if(![dictionary[kWeatherResponseForecastImage] isKindOfClass:[NSNull class]]){
		self.image = [[WeatherResponseImage alloc] initWithDictionary:dictionary[kWeatherResponseForecastImage]];
	}

	if(![dictionary[kWeatherResponseForecastTelop] isKindOfClass:[NSNull class]]){
		self.telop = dictionary[kWeatherResponseForecastTelop];
	}	
	if(![dictionary[kWeatherResponseForecastTemperature] isKindOfClass:[NSNull class]]){
		self.temperature = [[WeatherResponseTemperature alloc] initWithDictionary:dictionary[kWeatherResponseForecastTemperature]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.date != nil){
		dictionary[kWeatherResponseForecastDate] = self.date;
	}
	if(self.dateLabel != nil){
		dictionary[kWeatherResponseForecastDateLabel] = self.dateLabel;
	}
	if(self.image != nil){
		dictionary[kWeatherResponseForecastImage] = [self.image toDictionary];
	}
	if(self.telop != nil){
		dictionary[kWeatherResponseForecastTelop] = self.telop;
	}
	if(self.temperature != nil){
		dictionary[kWeatherResponseForecastTemperature] = [self.temperature toDictionary];
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.date != nil){
		[aCoder encodeObject:self.date forKey:kWeatherResponseForecastDate];
	}
	if(self.dateLabel != nil){
		[aCoder encodeObject:self.dateLabel forKey:kWeatherResponseForecastDateLabel];
	}
	if(self.image != nil){
		[aCoder encodeObject:self.image forKey:kWeatherResponseForecastImage];
	}
	if(self.telop != nil){
		[aCoder encodeObject:self.telop forKey:kWeatherResponseForecastTelop];
	}
	if(self.temperature != nil){
		[aCoder encodeObject:self.temperature forKey:kWeatherResponseForecastTemperature];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.date = [aDecoder decodeObjectForKey:kWeatherResponseForecastDate];
	self.dateLabel = [aDecoder decodeObjectForKey:kWeatherResponseForecastDateLabel];
	self.image = [aDecoder decodeObjectForKey:kWeatherResponseForecastImage];
	self.telop = [aDecoder decodeObjectForKey:kWeatherResponseForecastTelop];
	self.temperature = [aDecoder decodeObjectForKey:kWeatherResponseForecastTemperature];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseForecast *copy = [WeatherResponseForecast new];

	copy.date = [self.date copy];
	copy.dateLabel = [self.dateLabel copy];
	copy.image = [self.image copy];
	copy.telop = [self.telop copy];
	copy.temperature = [self.temperature copy];

	return copy;
}
@end
