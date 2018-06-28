//
//	CityData.h
//
//	Create by am10 on 28/6/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "CityDataList.h"

@interface CityData : NSObject

@property (nonatomic, strong) NSArray <CityDataList *> * cityDataList;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
