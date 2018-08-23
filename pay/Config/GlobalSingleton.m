//
//  GlobalSingleton.m
//  pay
//
//  Created by v2 on 2018/8/21.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "GlobalSingleton.h"
@implementation GlobalSingleton

static GlobalSingleton *_instance=nil;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        
        _instance.currentUser=[[UserModel alloc] initWihtDefaultData];
        
    });
    return _instance;
}


+ (GlobalSingleton *)Instance
{
    _instance =[[self alloc]init];
    return _instance;
}


-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

//+ (GlobalSingleton *)Instance
//{
//    static GlobalSingleton *_instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[GlobalSingleton alloc] init];
//
//        _instance.currentUser=[[UserModel alloc]init];
//
//
//    });
//    return _instance;
//}

#pragma mark - APP基础参数

/**
 *  获取APP版本号
 *
 */
- (NSString *)clientVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)deviceType {
    return [NSString stringWithFormat:@"%d", 1];
}

/**
 *  获取APP BUILD
 */
- (NSString *)build {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *) kCFBundleVersionKey];
}

/**
 *  获取版本号+BUILD
 */

- (NSString *)versionBuild
{
    NSString *version = [self clientVersion];
    NSString *build = [self build];
    
    NSString *versionBuild = [NSString stringWithFormat:@"v%@", version];
    
    if (![version isEqualToString:build]) {
        
        versionBuild = [NSString stringWithFormat:@"%@(%@)", versionBuild, build];
        
    }
    
    return versionBuild;
}


/**
 *  当前版本APP是否第一次运行
 *
 *  @return 如果当前版本是第一次运行则返回YES，否则则返回NO
 */
- (BOOL)isFirstRun
{
    //TODO 添加逻辑
    NSString *key = [@"HasLaunchedOnce" stringByAppendingString:[self versionBuild]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key])
    {
        // app already launched
        return NO;
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // This is the first launch ever
        return YES;
    }
}

#pragma mark - 用户

/**
 *  判断当前是否有登陆用户
 *
 *  @return 如果已登录则返回YES，未登录返回NO
 */
- (BOOL)hasLogin
{
    return self.currentUser.is_Login;
}

- (BOOL)netWorkFine
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

//退出或多设备顶号
-(void)removeAll
{
    [GlobalSingleton Instance].currentUser = nil;
    [GlobalSingleton Instance].currentUser =[[UserModel alloc]initWihtDefaultData];
    
//    [CacheHelper removeCacheForKey:CURRENT_USER_KEY];
}

//#pragma mark - md5加密
//- (NSString *)md5:(NSString *)str {
//    const char *cStr = [str UTF8String];
//    unsigned char result[32];
//    CC_MD5( cStr, strlen(cStr), result );
//    NSString *temp = [NSString stringWithFormat:
//                      @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//                      result[0], result[1], result[2], result[3],
//                      result[4], result[5], result[6], result[7],
//                      result[8], result[9], result[10], result[11],
//                      result[12], result[13], result[14], result[15]
//                      ];
//    return [temp lowercaseString];
//}

#pragma mark ----随机生成24位key----
-(NSString *)ret24bitString{
    
    NSArray *dex = @[
                     @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
                     @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",
                     @"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",
                     @"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",
                     @"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",
                     @"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"
                     ];
    NSLog(@"%ld",dex.count);
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 24; i++) {
        int number = arc4random() % 62;
        NSString *tempString = [NSString stringWithFormat:@"%@", dex[number]];
        string = [string stringByAppendingString:tempString];
    }
    NSLog(@"%@", string);
    
    return string;
}
@end
