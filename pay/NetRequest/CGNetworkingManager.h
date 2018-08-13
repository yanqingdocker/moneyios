//
//  CGNetworkingManager.h
//  pay
//
//  Created by v2 on 2018/8/9.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef NS_ENUM(NSInteger, RequestSerializerType) {
    
    RequestSerializerTypeForm = 0,//默认
    
    RequestSerializerTypeJSON
};//请求数据格式

typedef NS_ENUM(NSInteger, ResponseSerializerType) {
    
    ResponseSerializerTypeHTTP = 0,//默认
    
    ResponseSerializerTypeJSON
};//服务器返回数据格式

@interface CGNetworkingManager : NSObject
/**请求数据格式*/
@property (nonatomic, assign) RequestSerializerType  requestSerializerType;

/**服务器返回数据格式*/
@property (nonatomic, assign) ResponseSerializerType responseSerializerType;
@property(nonatomic,strong)NSString *myhud;
/**数据请求管理单例*/
+ (instancetype)sharedManager;

/**
 *  JsonGET请求,getJson方法，afn返回数据类型为NSFoundation类型
 *
 *  @param URLString 数据接口
 *  @param params    数据体
 *  @param success   成功回调block
 *  @param failure   失败回调block
 */
- (void)getDataWithURLString:(NSString *)URLString
                  WithParams:(id)params
                     success:(void(^)(id dict))success
                     failure:(void(^)(NSError *error))failure showHUD:(BOOL)showHUD;


/**
 *  JsonPOST请求,post网络请求
 *
 *  @param URLString 数据接口
 *  @param params    数据体
 *  @param success   成功回调block
 *  @param failure   失败回调block
 */
- (void)postDataWithURLString:(NSString *)URLString
                   WithParams:(id)params
                      success:(void(^)(id dict))success
                      failure:(void(^)(NSError *error))failure showHUD:(BOOL)showHUD;

/**
 *  上传文件
 *
 *  @param URLString      数据接口
 *  @param params         数据体
 *  @param data           上传的文件data
 *  @param fileSuffixName 上传的文件后缀名
 *  @param success        成功回调block
 *  @param failure        失败回调block
 */
- (void)uploadFileWithURLString:(NSString *)URLString
                     WithParams:(id)params
                           data:(NSData *)data
                 fileSuffixName:(NSString *)fileSuffixName
                        success:(void(^)(id dict))success
                        failure:(void(^)(NSError *error))failure
              fractionCompleted:(void(^)(double count))fractionCompleted;


/**
 *  下载文件
 *
 *  @param URLString         数据接口
 *  @param success           成功回调block
 *  @param failure           失败回调block
 *  @param fractionCompleted 进度
 */
- (void)downloadFileWithURLString:(NSString *)URLString
                          success:(void(^)(id dict))success
                          failure:(void(^)(NSError *error))failure
                fractionCompleted:(void(^)(double count))fractionCompleted;
/**
 *  取消请求
 */
- (void)cancelRequest;

//网络状态监控
+ (void)successstatus:(void(^)(AFNetworkReachabilityStatus status))success;
@end
