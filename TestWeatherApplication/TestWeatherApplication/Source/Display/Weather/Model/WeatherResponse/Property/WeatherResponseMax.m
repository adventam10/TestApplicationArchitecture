//
//	WeatherResponseMax.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseMax.h"

NSString *const kWeatherResponseMaxCelsius = @"celsius";
NSString *const kWeatherResponseMaxFahrenheit = @"fahrenheit";

@interface WeatherResponseMax ()
@end
@implementation WeatherResponseMax




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseMaxCelsius] isKindOfClass:[NSNull class]]){
		self.celsius = dictionary[kWeatherResponseMaxCelsius];
	}	
	if(![dictionary[kWeatherResponseMaxFahrenheit] isKindOfClass:[NSNull class]]){
		self.fahrenheit = dictionary[kWeatherResponseMaxFahrenheit];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.celsius != nil){
		dictionary[kWeatherResponseMaxCelsius] = self.celsius;
	}
	if(self.fahrenheit != nil){
		dictionary[kWeatherResponseMaxFahrenheit] = self.fahrenheit;
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
	if(self.celsius != nil){
		[aCoder encodeObject:self.celsius forKey:kWeatherResponseMaxCelsius];
	}
	if(self.fahrenheit != nil){
		[aCoder encodeObject:self.fahrenheit forKey:kWeatherResponseMaxFahrenheit];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.celsius = [aDecoder decodeObjectForKey:kWeatherResponseMaxCelsius];
	self.fahrenheit = [aDecoder decodeObjectForKey:kWeatherResponseMaxFahrenheit];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseMax *copy = [WeatherResponseMax new];

	copy.celsius = [self.celsius copy];
	copy.fahrenheit = [self.fahrenheit copy];

	return copy;
}
@end
