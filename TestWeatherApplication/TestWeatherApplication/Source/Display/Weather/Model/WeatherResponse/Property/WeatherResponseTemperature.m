//
//	WeatherResponseTemperature.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseTemperature.h"

NSString *const kWeatherResponseTemperatureMax = @"max";
NSString *const kWeatherResponseTemperatureMin = @"min";

@interface WeatherResponseTemperature ()
@end
@implementation WeatherResponseTemperature




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseTemperatureMax] isKindOfClass:[NSNull class]]){
		self.max = [[WeatherResponseMax alloc] initWithDictionary:dictionary[kWeatherResponseTemperatureMax]];
	}

	if(![dictionary[kWeatherResponseTemperatureMin] isKindOfClass:[NSNull class]]){
		self.min = [[WeatherResponseMax alloc] initWithDictionary:dictionary[kWeatherResponseTemperatureMin]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.max != nil){
		dictionary[kWeatherResponseTemperatureMax] = [self.max toDictionary];
	}
	if(self.min != nil){
		dictionary[kWeatherResponseTemperatureMin] = [self.min toDictionary];
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
	if(self.max != nil){
		[aCoder encodeObject:self.max forKey:kWeatherResponseTemperatureMax];
	}
	if(self.min != nil){
		[aCoder encodeObject:self.min forKey:kWeatherResponseTemperatureMin];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.max = [aDecoder decodeObjectForKey:kWeatherResponseTemperatureMax];
	self.min = [aDecoder decodeObjectForKey:kWeatherResponseTemperatureMin];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseTemperature *copy = [WeatherResponseTemperature new];

	copy.max = [self.max copy];
	copy.min = [self.min copy];

	return copy;
}
@end
