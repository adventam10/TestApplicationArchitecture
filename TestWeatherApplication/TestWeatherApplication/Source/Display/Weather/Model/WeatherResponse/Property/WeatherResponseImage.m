//
//	WeatherResponseImage.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponseImage.h"

NSString *const kWeatherResponseImageHeight = @"height";
NSString *const kWeatherResponseImageLink = @"link";
NSString *const kWeatherResponseImageTitle = @"title";
NSString *const kWeatherResponseImageUrl = @"url";
NSString *const kWeatherResponseImageWidth = @"width";

@interface WeatherResponseImage ()
@end
@implementation WeatherResponseImage




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseImageHeight] isKindOfClass:[NSNull class]]){
		self.height = [dictionary[kWeatherResponseImageHeight] integerValue];
	}

	if(![dictionary[kWeatherResponseImageLink] isKindOfClass:[NSNull class]]){
		self.link = dictionary[kWeatherResponseImageLink];
	}	
	if(![dictionary[kWeatherResponseImageTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kWeatherResponseImageTitle];
	}	
	if(![dictionary[kWeatherResponseImageUrl] isKindOfClass:[NSNull class]]){
		self.url = dictionary[kWeatherResponseImageUrl];
	}	
	if(![dictionary[kWeatherResponseImageWidth] isKindOfClass:[NSNull class]]){
		self.width = [dictionary[kWeatherResponseImageWidth] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kWeatherResponseImageHeight] = @(self.height);
	if(self.link != nil){
		dictionary[kWeatherResponseImageLink] = self.link;
	}
	if(self.title != nil){
		dictionary[kWeatherResponseImageTitle] = self.title;
	}
	if(self.url != nil){
		dictionary[kWeatherResponseImageUrl] = self.url;
	}
	dictionary[kWeatherResponseImageWidth] = @(self.width);
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
	[aCoder encodeObject:@(self.height) forKey:kWeatherResponseImageHeight];	if(self.link != nil){
		[aCoder encodeObject:self.link forKey:kWeatherResponseImageLink];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kWeatherResponseImageTitle];
	}
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:kWeatherResponseImageUrl];
	}
	[aCoder encodeObject:@(self.width) forKey:kWeatherResponseImageWidth];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.height = [[aDecoder decodeObjectForKey:kWeatherResponseImageHeight] integerValue];
	self.link = [aDecoder decodeObjectForKey:kWeatherResponseImageLink];
	self.title = [aDecoder decodeObjectForKey:kWeatherResponseImageTitle];
	self.url = [aDecoder decodeObjectForKey:kWeatherResponseImageUrl];
	self.width = [[aDecoder decodeObjectForKey:kWeatherResponseImageWidth] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponseImage *copy = [WeatherResponseImage new];

	copy.height = self.height;
	copy.link = [self.link copy];
	copy.title = [self.title copy];
	copy.url = [self.url copy];
	copy.width = self.width;

	return copy;
}
@end
