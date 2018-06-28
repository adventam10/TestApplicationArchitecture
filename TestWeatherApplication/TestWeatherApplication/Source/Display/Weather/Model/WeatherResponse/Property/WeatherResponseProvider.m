//
//	WeatherResponseProvider.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseProvider.h"

NSString *const kWeatherResponseProviderLink = @"link";
NSString *const kWeatherResponseProviderName = @"name";

@interface WeatherResponseProvider ()
@end
@implementation WeatherResponseProvider




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseProviderLink] isKindOfClass:[NSNull class]]){
		self.link = dictionary[kWeatherResponseProviderLink];
	}	
	if(![dictionary[kWeatherResponseProviderName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kWeatherResponseProviderName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.link != nil){
		dictionary[kWeatherResponseProviderLink] = self.link;
	}
	if(self.name != nil){
		dictionary[kWeatherResponseProviderName] = self.name;
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
	if(self.link != nil){
		[aCoder encodeObject:self.link forKey:kWeatherResponseProviderLink];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kWeatherResponseProviderName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.link = [aDecoder decodeObjectForKey:kWeatherResponseProviderLink];
	self.name = [aDecoder decodeObjectForKey:kWeatherResponseProviderName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseProvider *copy = [WeatherResponseProvider new];

	copy.link = [self.link copy];
	copy.name = [self.name copy];

	return copy;
}
@end
