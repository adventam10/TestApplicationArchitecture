//
//	WeatherResponseLocation.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseLocation.h"

NSString *const kWeatherResponseLocationArea = @"area";
NSString *const kWeatherResponseLocationCity = @"city";
NSString *const kWeatherResponseLocationPrefecture = @"prefecture";

@interface WeatherResponseLocation ()
@end
@implementation WeatherResponseLocation




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseLocationArea] isKindOfClass:[NSNull class]]){
		self.area = dictionary[kWeatherResponseLocationArea];
	}	
	if(![dictionary[kWeatherResponseLocationCity] isKindOfClass:[NSNull class]]){
		self.city = dictionary[kWeatherResponseLocationCity];
	}	
	if(![dictionary[kWeatherResponseLocationPrefecture] isKindOfClass:[NSNull class]]){
		self.prefecture = dictionary[kWeatherResponseLocationPrefecture];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.area != nil){
		dictionary[kWeatherResponseLocationArea] = self.area;
	}
	if(self.city != nil){
		dictionary[kWeatherResponseLocationCity] = self.city;
	}
	if(self.prefecture != nil){
		dictionary[kWeatherResponseLocationPrefecture] = self.prefecture;
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
	if(self.area != nil){
		[aCoder encodeObject:self.area forKey:kWeatherResponseLocationArea];
	}
	if(self.city != nil){
		[aCoder encodeObject:self.city forKey:kWeatherResponseLocationCity];
	}
	if(self.prefecture != nil){
		[aCoder encodeObject:self.prefecture forKey:kWeatherResponseLocationPrefecture];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.area = [aDecoder decodeObjectForKey:kWeatherResponseLocationArea];
	self.city = [aDecoder decodeObjectForKey:kWeatherResponseLocationCity];
	self.prefecture = [aDecoder decodeObjectForKey:kWeatherResponseLocationPrefecture];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseLocation *copy = [WeatherResponseLocation new];

	copy.area = [self.area copy];
	copy.city = [self.city copy];
	copy.prefecture = [self.prefecture copy];

	return copy;
}
@end
