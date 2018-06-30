//
//  NSUserDefaults+ReadWrite.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/30.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "NSUserDefaults+ReadWrite.h"

@implementation NSUserDefaults(ReadWrite)

/**
 端末内に保存されたオブジェクトをKeyを元に取り出します。
 
 @param key 指定のキー
 @return 対象オブジェクト
 */
+ (id)readObjectWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults dataForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}


/**
 端末内にKeyを元にオブジェクトを保存します。
 
 @param object 対象オブジェクト
 @param key 指定のキー
 @return 保存成功フラグ
 */
+ (BOOL)writeObject:(id)object
                key:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:key];
    return [userDefaults synchronize];
}

@end
