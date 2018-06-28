//
//	CityDataList.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CityDataList.h"

NSString *const kCityDataListArea = @"area";
NSString *const kCityDataListCityId = @"cityId";
NSString *const kCityDataListName = @"name";

@interface CityDataList ()
@end
@implementation CityDataList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCityDataListArea] isKindOfClass:[NSNull class]]){
		self.area = dictionary[kCityDataListArea];
	}	
	if(![dictionary[kCityDataListCityId] isKindOfClass:[NSNull class]]){
		self.cityId = dictionary[kCityDataListCityId];
	}	
	if(![dictionary[kCityDataListName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kCityDataListName];
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
		dictionary[kCityDataListArea] = self.area;
	}
	if(self.cityId != nil){
		dictionary[kCityDataListCityId] = self.cityId;
	}
	if(self.name != nil){
		dictionary[kCityDataListName] = self.name;
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
		[aCoder encodeObject:self.area forKey:kCityDataListArea];
	}
	if(self.cityId != nil){
		[aCoder encodeObject:self.cityId forKey:kCityDataListCityId];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kCityDataListName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.area = [aDecoder decodeObjectForKey:kCityDataListArea];
	self.cityId = [aDecoder decodeObjectForKey:kCityDataListCityId];
	self.name = [aDecoder decodeObjectForKey:kCityDataListName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CityDataList *copy = [CityDataList new];

	copy.area = [self.area copy];
	copy.cityId = [self.cityId copy];
	copy.name = [self.name copy];

	return copy;
}
@end
