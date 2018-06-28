//
//	CityData.m
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CityData.h"

NSString *const kCityDataCityDataList = @"cityDataList";

@interface CityData ()
@end
@implementation CityData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kCityDataCityDataList] != nil && [dictionary[kCityDataCityDataList] isKindOfClass:[NSArray class]]){
		NSArray * cityDataListDictionaries = dictionary[kCityDataCityDataList];
		NSMutableArray * cityDataListItems = [NSMutableArray array];
		for(NSDictionary * cityDataListDictionary in cityDataListDictionaries){
			CityDataList * cityDataListItem = [[CityDataList alloc] initWithDictionary:cityDataListDictionary];
			[cityDataListItems addObject:cityDataListItem];
		}
		self.cityDataList = cityDataListItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.cityDataList != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(CityDataList * cityDataListElement in self.cityDataList){
			[dictionaryElements addObject:[cityDataListElement toDictionary]];
		}
		dictionary[kCityDataCityDataList] = dictionaryElements;
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
	if(self.cityDataList != nil){
		[aCoder encodeObject:self.cityDataList forKey:kCityDataCityDataList];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cityDataList = [aDecoder decodeObjectForKey:kCityDataCityDataList];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CityData *copy = [CityData new];

	copy.cityDataList = [self.cityDataList copy];

	return copy;
}
@end
