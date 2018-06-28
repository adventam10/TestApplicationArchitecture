//
//	WeatherResponseDescription.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseDescription.h"

NSString *const kWeatherResponseDescriptionPublicTime = @"publicTime";
NSString *const kWeatherResponseDescriptionText = @"text";

@interface WeatherResponseDescription ()
@end
@implementation WeatherResponseDescription




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseDescriptionPublicTime] isKindOfClass:[NSNull class]]){
		self.publicTime = dictionary[kWeatherResponseDescriptionPublicTime];
	}	
	if(![dictionary[kWeatherResponseDescriptionText] isKindOfClass:[NSNull class]]){
		self.text = dictionary[kWeatherResponseDescriptionText];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.publicTime != nil){
		dictionary[kWeatherResponseDescriptionPublicTime] = self.publicTime;
	}
	if(self.text != nil){
		dictionary[kWeatherResponseDescriptionText] = self.text;
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
	if(self.publicTime != nil){
		[aCoder encodeObject:self.publicTime forKey:kWeatherResponseDescriptionPublicTime];
	}
	if(self.text != nil){
		[aCoder encodeObject:self.text forKey:kWeatherResponseDescriptionText];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.publicTime = [aDecoder decodeObjectForKey:kWeatherResponseDescriptionPublicTime];
	self.text = [aDecoder decodeObjectForKey:kWeatherResponseDescriptionText];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseDescription *copy = [WeatherResponseDescription new];

	copy.publicTime = [self.publicTime copy];
	copy.text = [self.text copy];

	return copy;
}
@end
