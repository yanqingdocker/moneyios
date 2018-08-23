//
//  CGNetworkingManager.m
//  pay
//
//  Created by v2 on 2018/8/9.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGNetworkingManager.h"
//#import "NSString+Hash.h"
#import "MBProgressHUD.h"
#define BaseUrl [NSURL URLWithString:@""]
#define kWebCachePath [NSTemporaryDirectory() stringByAppendingString:@"cache"]

#ifdef DEBUG
#define SFLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define SFLog(s, ... )
#endif

@interface CGNetworkingManager ()
@property(nonatomic,strong)AFHTTPSessionManager *requestManager;
@property(nonatomic,strong)MBProgressHUD *selfhud;
@end

@implementation CGNetworkingManager
static CGNetworkingManager *manager = nil;
+ (instancetype)sharedManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    }
    return manager;
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return  manager;
}



- (AFHTTPSessionManager *)requestManager
{
    if (!_requestManager) {
        _requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:BaseUrl];
        switch (self.requestSerializerType) {
                
                
            case RequestSerializerTypeForm:
                
                _requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
                
            case RequestSerializerTypeJSON:
                
                _requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
                
            default:
                
                _requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
        }
        
        _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png",@"image/jpeg",@"application/rtf",@"image/gif",@"application/zip",@"audio/x-wav",@"image/tiff",@"     application/x-shockwave-flash",@"application/vnd.ms-powerpoint",@"video/mpeg",@"video/quicktime",@"application/x-javascript",@"application/x-gzip",@"application/x-gtar",@"application/msword",@"text/css",@"video/x-msvideo",@"text/xml",nil];
        _requestManager.requestSerializer.timeoutInterval = 8.f;
    }
    
    return _requestManager;
}

#pragma mark - get请求
- (void)getDataWithURLString:(NSString *)urlString
                  WithParams:(id)params
                     success:(void(^)(id dict))success
                     failure:(void(^)(NSError *error))failure
                     showHUD:(BOOL)showHUD
{
    
    
    if (showHUD==YES) {
        [MBProgressHUD showHUDAddedToView:nil animated:YES];
    }
    [self.requestManager GET:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow  animated:YES];
        }
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow  animated:YES];
        }
        
            if (failure) {
                failure(error);
            }
    }];
    
//    [self.requestManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //        AppLog(@"请求成功参数：%@",params);
//
//        if (showHUD==YES) {
//            [MBProgressHUD hideHUDForView:nil animated:YES];
//        }
//
//        if (success) {
//            success(responseObject);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        SFLog(@"%@",error);
//        //        AppLog(@"请求错误参数：%@",params);
//
//        if (showHUD==YES) {
//            [MBProgressHUD hideHUDForView:nil  animated:YES];
//        }
//
//        if (failure) {
//            failure(error);
//        }
//    }];
}

#pragma mark - post请求
- (void)postDataWithURLString:(NSString *)URLString
                   WithParams:(id)params
                      success:(void(^)(id dic))success
                      failure:(void(^)(NSError *error))failure
                      showHUD:(BOOL)showHUD
{
    
    switch (self.responseSerializerType) {
            
        case ResponseSerializerTypeHTTP:
            
            self.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            
        case ResponseSerializerTypeJSON:
            
            self.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
            
        default:
            
            self.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
    }
    
    switch (self.requestSerializerType) {
            
            
        case RequestSerializerTypeForm:
            
            _requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
            
        case RequestSerializerTypeJSON:
            
            _requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
            
        default:
            
            _requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    
    self.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png",@"image/jpeg",@"application/rtf",@"image/gif",@"application/zip",@"audio/x-wav",@"image/tiff",@"     application/x-shockwave-flash",@"application/vnd.ms-powerpoint",@"video/mpeg",@"video/quicktime",@"application/x-javascript",@"application/x-gzip",@"application/x-gtar",@"application/msword",@"text/css",@"video/x-msvideo",@"text/xml",nil];
    
    //固定上传字段
    //    [params setObject:@"ios" forKey:@"imei"];
    //    [params setObject:@"ios" forKey:@"appcode"];
    //    [params setObject:@"ios" forKey:@"devicetype"];
    
    //    _requestManager.requestSerializer.timeoutInterval = 8.0f;

    
    
    if (self.myhud.length>0) {
        MBProgressHUD *mbhud=[[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
        
        self.selfhud=mbhud;
        
        [self.selfhud show:YES];
        
        
    }
    else{
        if (showHUD==YES)
        {
//            [MBProgressHUD showMessage:@""];
            [MBProgressHUD showHUDAddedToView:nil animated:YES];
        }
        
        
    }
    
    
    self.requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    self.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.requestManager POST:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow  animated:YES];
        }
        if (success) {
            
            //            NSDictionary *dic = [ParamsAES dictToJSON:responseObject];
            //            if ([dic.allKeys containsObject:@"code"]) {
            //                NSString *codestring=[NSString stringWithFormat:@"%@",dic[@"code"]];
            //                if ([codestring isEqualToString:@"Ex9999"]) {
            //                    [HttpHelper isNeedReLoginWithHttpCode:dic[@"code"]];
            //                }
            //            }
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow  animated:YES];
        }
        
        if (failure) {
            failure(error);
        }
    }];
    
//    [self.requestManager POST:URLString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        AppLog(@"请求成功参数：%@",params);
//        if (self.myhud.length>0) {
//
//
//            [self.selfhud  hide:YES];
//
//
//        }
//        else{
//            if (showHUD==YES) {
//                [MBProgressHUD hideHUDForView:nil  animated:YES];
//            }
//
//        }
//
//
//        if (success) {
//
////            NSDictionary *dic = [ParamsAES dictToJSON:responseObject];
////            if ([dic.allKeys containsObject:@"code"]) {
////                NSString *codestring=[NSString stringWithFormat:@"%@",dic[@"code"]];
////                if ([codestring isEqualToString:@"Ex9999"]) {
////                    [HttpHelper isNeedReLoginWithHttpCode:dic[@"code"]];
////                }
////            }
//
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //        SFLog(@"error:%@",error.localizedDescription);
////        AppLog(@"请求错误参数：%@",params);
//
//        if (showHUD==YES) {
//            [MBProgressHUD hideHUDForView:nil  animated:YES];
//        }
//
//        if (failure) {
//            failure(error);
//        }
//    }];
}


#pragma mark -上传
/**
 *  上传文件
 *
 *  @param URLString 数据接口  *  @param params    数据体
 *  @param image     上传的图片
 *  @param name      图片名
 *  @param fileName  图片文件名
 *  @param success   成功回调block
 *  @param failure   失败回调block
 *  @param fractionCompleted 进度
 */

- (void)uploadFileWithURLString:(NSString *)URLString
                     WithParams:(id)params
                           data:(NSData *)data
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                        success:(void(^)(id dict))success
                        failure:(void(^)(NSError *error))failure
              fractionCompleted:(void(^)(double count))fractionComPleted
{
    [self.requestManager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"application/octet-stream"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
//    [self.requestManager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"application/octet-stream"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (fractionComPleted) {
//            fractionComPleted(uploadProgress.fractionCompleted);
//        }
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        SFLog(@"%@",error);
//        if (failure) {
//            failure(error);
//        }
//    }];
}


- (void)uploadFileWithURLString:(NSString *)URLString
                     WithParams:(id)params
                           data:(NSData *)data
                 fileSuffixName:(NSString *)fileSuffixName
                        success:(void(^)(id dict))success
                        failure:(void(^)(NSError *error))failure
              fractionCompleted:(void(^)(double count))fractionCompleted
{
//    NSString *name = [[self getDate] md5String];
//    NSString *fileName = [NSString stringWithFormat:@"%@.%@",name,fileSuffixName];
    NSString *name;
    NSString *fileName;
    [self uploadFileWithURLString:URLString WithParams:params data:data name:name fileName:fileName success:^(id dict) {
        
        if (success) {
            success(dict);
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    } fractionCompleted:^(double count) {
        
        if (fractionCompleted) {
            fractionCompleted(count);
        }
    }];
}


#pragma mark - 下载
/**
 *  下载文件
 *
 *  @param URLString         数据接口
 *  @param fileDownPath      要保存的地址
 *  @param success           成功回调block
 *  @param failure           失败回调block
 *  @param fractionCompleted 进度
 */
- (void)downloadFileWithURLString:(NSString *)URLString
                     fileDownPath:(NSString *)fileDownPath
                          success:(void(^)(id dict))success
                          failure:(void(^)(NSError*error))failure
                fractionCompleted:(void(^)(double count))fractionCompleted
{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
//    NSURLSessionDownloadTask *downloadTask = [self.requestManager downloadTaskWithRequest:request progress:(NSProgress *__autoreleasing *){
//        if (fractionCompleted) {
//            fractionCompleted(downloadProgress.fractionCompleted);
//        }
//    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *doucmentsDirectoryURL =  [NSURL fileURLWithPath:fileDownPath];
//
//        // SFLog(@"%@",doucmentsDirectoryURL);
//
//        return doucmentsDirectoryURL;
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        if (!error) {
//            if (success) {
//                success(filePath);
//            }
//        }else{
//            SFLog(@"%@",error);
//            if (failure) {
//                failure(error);
//            }
//        }
//    }];
    
//    NSURLSessionDownloadTask *downloadTask = [self.requestManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        if (fractionCompleted) {
//            fractionCompleted(downloadProgress.fractionCompleted);
//        }
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//
//        NSURL *doucmentsDirectoryURL =  [NSURL fileURLWithPath:fileDownPath];
//
//        // SFLog(@"%@",doucmentsDirectoryURL);
//
//        return doucmentsDirectoryURL;
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        if (!error) {
//            if (success) {
//                success(filePath);
//            }
//        }else{
//            SFLog(@"%@",error);
//            if (failure) {
//                failure(error);
//            }
//        }
//    }];
//    [downloadTask resume];
}


- (void)downloadFileWithURLString:(NSString *)URLString
                          success:(void(^)(id dict))success
                          failure:(void(^)(NSError *error))failure
                fractionCompleted:(void(^)(double count))fractionCompleted
{
//    NSString *hash = [URLString md5String];
//    NSString *filePath = [self pathForDocumentWithComponent:hash];
    NSString *filePath;
    [self downloadFileWithURLString:URLString fileDownPath:filePath success:^(id dict) {
        if (success) {
            success(dict);
        }
        SFLog(@"%@",filePath);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    } fractionCompleted:^(double count) {
        if (fractionCompleted) {
            fractionCompleted(count);
        }
    }];
}

#pragma mark - 取消请求
- (void)cancelRequest
{
    [self.requestManager.operationQueue cancelAllOperations];
}

// 获取当前时间
- (NSString*)getDate {
    
    NSDate* now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd  HH:mm:ss"];
    
//    AppLog(@"%@",[dateFormatter stringFromDate:now]);
    
    return [dateFormatter stringFromDate:now];
}


// 获取沙盒路径
- (NSString *)pathForDocumentWithComponent:(NSString *)fid {
    
    NSString *fullPath = nil;
    
    if (fid&& [fid length]) {
        
        NSString *path = NSHomeDirectory();
        
        NSString *cacheDiretory= [path stringByAppendingPathComponent:@"Library/Caches/"];
        
        cacheDiretory = [cacheDiretory stringByAppendingPathComponent:@"webCache"];
        
        fullPath = [cacheDiretory stringByAppendingPathComponent:fid];
        
    } else {
        
//        fullPath = kWebCachePath;
        
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:fullPath]) {
        
        NSError *err=nil;
        
        if ([fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&err]) {
            
            return [fullPath stringByAppendingPathComponent:fid];
            
        }else{
            
            [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&err];
            
            return [fullPath stringByAppendingPathComponent:fid];
        }
    }
    
    fullPath = [fullPath stringByAppendingPathComponent:fid];
    
    return fullPath;
}

#pragma mark - 登录
- (void)LoginWithURLString:(NSString *)URLString
                WithParams:(id)params
                   success:(void(^)(id dic))success
                   failure:(void(^)(NSError *error))failure
                   showHUD:(BOOL)showHUD
{
    [self.requestManager POST:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
//    [self.requestManager POST:URLString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //        AppLog(@"请求成功参数：%@",params);
//
//        if (showHUD==YES) {
//            [MBProgressHUD hideHUDForView:nil  animated:YES];
//        }
//
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        SFLog(@"%@",error);
//        //        AppLog(@"请求错误参数：%@",params);
//
//        if (showHUD==YES) {
//            [MBProgressHUD hideHUDForView:nil  animated:YES];
//        }
//
//        if (failure) {
//            failure(error);
//        }
//    }];
}
+ (void)successstatus:(void(^)(AFNetworkReachabilityStatus status))success{
    //监控 管理器
    AFNetworkReachabilityManager *manger=[AFNetworkReachabilityManager sharedManager];
    [ manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        success(status);
    }     ];
    //开始监控
    [manger startMonitoring];
    
}

@end
