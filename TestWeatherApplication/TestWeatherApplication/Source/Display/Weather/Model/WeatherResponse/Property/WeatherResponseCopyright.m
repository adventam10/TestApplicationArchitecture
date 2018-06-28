//
//	WeatherResponseCopyright.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseCopyright.h"

NSString *const kWeatherResponseCopyrightImage = @"image";
NSString *const kWeatherResponseCopyrightLink = @"link";
NSString *const kWeatherResponseCopyrightProvider = @"provider";
NSString *const kWeatherResponseCopyrightTitle = @"title";

@interface WeatherResponseCopyright ()
@end
@implementation WeatherResponseCopyright




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseCopyrightImage] isKindOfClass:[NSNull class]]){
		self.image = [[WeatherResponseImage alloc] initWithDictionary:dictionary[kWeatherResponseCopyrightImage]];
	}

	if(![dictionary[kWeatherResponseCopyrightLink] isKindOfClass:[NSNull class]]){
		self.link = dictionary[kWeatherResponseCopyrightLink];
	}	
	if(dictionary[kWeatherResponseCopyrightProvider] != nil && [dictionary[kWeatherResponseCopyrightProvider] isKindOfClass:[NSArray class]]){
		NSArray * providerDictionaries = dictionary[kWeatherResponseCopyrightProvider];
		NSMutableArray * providerItems = [NSMutableArray array];
		for(NSDictionary * providerDictionary in providerDictionaries){
			WeatherResponseProvider * providerItem = [[WeatherResponseProvider alloc] initWithDictionary:providerDictionary];
			[providerItems addObject:providerItem];
		}
		self.provider = providerItems;
	}
	if(![dictionary[kWeatherResponseCopyrightTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kWeatherResponseCopyrightTitle];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.image != nil){
		dictionary[kWeatherResponseCopyrightImage] = [self.image toDictionary];
	}
	if(self.link != nil){
		dictionary[kWeatherResponseCopyrightLink] = self.link;
	}
	if(self.provider != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(WeatherResponseProvider * providerElement in self.provider){
			[dictionaryElements addObject:[providerElement toDictionary]];
		}
		dictionary[kWeatherResponseCopyrightProvider] = dictionaryElements;
	}
	if(self.title != nil){
		dictionary[kWeatherResponseCopyrightTitle] = self.title;
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
	if(self.image != nil){
		[aCoder encodeObject:self.image forKey:kWeatherResponseCopyrightImage];
	}
	if(self.link != nil){
		[aCoder encodeObject:self.link forKey:kWeatherResponseCopyrightLink];
	}
	if(self.provider != nil){
		[aCoder encodeObject:self.provider forKey:kWeatherResponseCopyrightProvider];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kWeatherResponseCopyrightTitle];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.image = [aDecoder decodeObjectForKey:kWeatherResponseCopyrightImage];
	self.link = [aDecoder decodeObjectForKey:kWeatherResponseCopyrightLink];
	self.provider = [aDecoder decodeObjectForKey:kWeatherResponseCopyrightProvider];
	self.title = [aDecoder decodeObjectForKey:kWeatherResponseCopyrightTitle];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseCopyright *copy = [WeatherResponseCopyright new];

	copy.image = [self.image copy];
	copy.link = [self.link copy];
	copy.provider = [self.provider copy];
	copy.title = [self.title copy];

	return copy;
}
@end
