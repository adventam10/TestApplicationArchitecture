//
//  NetworkManager.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/24.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NWMJsonSuccess)(NSDictionary *json);
typedef void (^NWMJsonFailure)(NSString *message, NSError *error);

@interface NetworkManager : NSObject

+ (NSURLSessionDataTask *)requestJsonDataWithBaseURLText:(NSString *)baseUrlText
                                               parameter:(NSDictionary <NSString *, NSString *> *)parameter
                                                 success:(NWMJsonSuccess)success
                                                 failure:(NWMJsonFailure)failure;
@end
