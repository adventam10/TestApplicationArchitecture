//
//	WeatherResponse.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherResponse.h"

NSString *const kWeatherResponseCopyright = @"copyright";
NSString *const kWeatherResponseDescriptionField = @"description";
NSString *const kWeatherResponseForecasts = @"forecasts";
NSString *const kWeatherResponseLink = @"link";
NSString *const kWeatherResponseLocation = @"location";
NSString *const kWeatherResponsePinpointLocations = @"pinpointLocations";
NSString *const kWeatherResponsePublicTime = @"publicTime";
NSString *const kWeatherResponseTitle = @"title";

@interface WeatherResponse ()
@end
@implementation WeatherResponse




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherResponseCopyright] isKindOfClass:[NSNull class]]){
		self.copyright = [[WeatherResponseCopyright alloc] initWithDictionary:dictionary[kWeatherResponseCopyright]];
	}

	if(![dictionary[kWeatherResponseDescriptionField] isKindOfClass:[NSNull class]]){
		self.descriptionField = [[WeatherResponseDescription alloc] initWithDictionary:dictionary[kWeatherResponseDescriptionField]];
	}

	if(dictionary[kWeatherResponseForecasts] != nil && [dictionary[kWeatherResponseForecasts] isKindOfClass:[NSArray class]]){
		NSArray * forecastsDictionaries = dictionary[kWeatherResponseForecasts];
		NSMutableArray * forecastsItems = [NSMutableArray array];
		for(NSDictionary * forecastsDictionary in forecastsDictionaries){
			WeatherResponseForecast * forecastsItem = [[WeatherResponseForecast alloc] initWithDictionary:forecastsDictionary];
			[forecastsItems addObject:forecastsItem];
		}
		self.forecasts = forecastsItems;
	}
	if(![dictionary[kWeatherResponseLink] isKindOfClass:[NSNull class]]){
		self.link = dictionary[kWeatherResponseLink];
	}	
	if(![dictionary[kWeatherResponseLocation] isKindOfClass:[NSNull class]]){
		self.location = [[WeatherResponseLocation alloc] initWithDictionary:dictionary[kWeatherResponseLocation]];
	}

	if(dictionary[kWeatherResponsePinpointLocations] != nil && [dictionary[kWeatherResponsePinpointLocations] isKindOfClass:[NSArray class]]){
		NSArray * pinpointLocationsDictionaries = dictionary[kWeatherResponsePinpointLocations];
		NSMutableArray * pinpointLocationsItems = [NSMutableArray array];
		for(NSDictionary * pinpointLocationsDictionary in pinpointLocationsDictionaries){
			WeatherResponseProvider * pinpointLocationsItem = [[WeatherResponseProvider alloc] initWithDictionary:pinpointLocationsDictionary];
			[pinpointLocationsItems addObject:pinpointLocationsItem];
		}
		self.pinpointLocations = pinpointLocationsItems;
	}
	if(![dictionary[kWeatherResponsePublicTime] isKindOfClass:[NSNull class]]){
		self.publicTime = dictionary[kWeatherResponsePublicTime];
	}	
	if(![dictionary[kWeatherResponseTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kWeatherResponseTitle];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.copyright != nil){
		dictionary[kWeatherResponseCopyright] = [self.copyright toDictionary];
	}
	if(self.descriptionField != nil){
		dictionary[kWeatherResponseDescriptionField] = [self.descriptionField toDictionary];
	}
	if(self.forecasts != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(WeatherResponseForecast * forecastsElement in self.forecasts){
			[dictionaryElements addObject:[forecastsElement toDictionary]];
		}
		dictionary[kWeatherResponseForecasts] = dictionaryElements;
	}
	if(self.link != nil){
		dictionary[kWeatherResponseLink] = self.link;
	}
	if(self.location != nil){
		dictionary[kWeatherResponseLocation] = [self.location toDictionary];
	}
	if(self.pinpointLocations != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(WeatherResponseProvider * pinpointLocationsElement in self.pinpointLocations){
			[dictionaryElements addObject:[pinpointLocationsElement toDictionary]];
		}
		dictionary[kWeatherResponsePinpointLocations] = dictionaryElements;
	}
	if(self.publicTime != nil){
		dictionary[kWeatherResponsePublicTime] = self.publicTime;
	}
	if(self.title != nil){
		dictionary[kWeatherResponseTitle] = self.title;
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
	if(self.copyright != nil){
		[aCoder encodeObject:self.copyright forKey:kWeatherResponseCopyright];
	}
	if(self.descriptionField != nil){
		[aCoder encodeObject:self.descriptionField forKey:kWeatherResponseDescriptionField];
	}
	if(self.forecasts != nil){
		[aCoder encodeObject:self.forecasts forKey:kWeatherResponseForecasts];
	}
	if(self.link != nil){
		[aCoder encodeObject:self.link forKey:kWeatherResponseLink];
	}
	if(self.location != nil){
		[aCoder encodeObject:self.location forKey:kWeatherResponseLocation];
	}
	if(self.pinpointLocations != nil){
		[aCoder encodeObject:self.pinpointLocations forKey:kWeatherResponsePinpointLocations];
	}
	if(self.publicTime != nil){
		[aCoder encodeObject:self.publicTime forKey:kWeatherResponsePublicTime];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kWeatherResponseTitle];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.copyright = [aDecoder decodeObjectForKey:kWeatherResponseCopyright];
	self.descriptionField = [aDecoder decodeObjectForKey:kWeatherResponseDescriptionField];
	self.forecasts = [aDecoder decodeObjectForKey:kWeatherResponseForecasts];
	self.link = [aDecoder decodeObjectForKey:kWeatherResponseLink];
	self.location = [aDecoder decodeObjectForKey:kWeatherResponseLocation];
	self.pinpointLocations = [aDecoder decodeObjectForKey:kWeatherResponsePinpointLocations];
	self.publicTime = [aDecoder decodeObjectForKey:kWeatherResponsePublicTime];
	self.title = [aDecoder decodeObjectForKey:kWeatherResponseTitle];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherResponse *copy = [WeatherResponse new];

	copy.copyright = [self.copyright copy];
	copy.descriptionField = [self.descriptionField copy];
	copy.forecasts = [self.forecasts copy];
	copy.link = [self.link copy];
	copy.location = [self.location copy];
	copy.pinpointLocations = [self.pinpointLocations copy];
	copy.publicTime = [self.publicTime copy];
	copy.title = [self.title copy];

	return copy;
}
@end
