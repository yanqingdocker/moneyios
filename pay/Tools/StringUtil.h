//
//  StringUtil.h
//  pay
//
//  Created by 胡彦清 on 2018/9/10.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PHONENUMBER_LIMIT 11
#define NICKNAME_LIMIT 16
#define VERIFYCODE_LIMIT 6
#define PASSWORD_LIMIT 16
#define PASSWORD_NEW_LIMIT 8
#define IDENTITY_LIMIT 18
#define NUMBERS_ONLY @"1234567890"
#define NUMBERSDOT_ONLY @"1234567890."
#define ALPHA_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface StringUtil : NSObject
+ (BOOL)validateMoney:(NSString *)number Range:(NSRange)range String:(NSString *)string;

//删除小数点后面多余的0
+ (NSString *)changeFloat:(NSString *)stringFloat;

+ (BOOL)validateNumbers:(NSString *)number;

+ (BOOL)validatePSW:(NSString *)string;

+ (BOOL)isNullOrEmpty:(NSString *)str;

+ (BOOL) validateBankNumber:(NSString *) bankNumber;

+ (BOOL)validateChinese:(NSString *)string;

+ (BOOL)validateEmail:(NSString *)email;

+ (BOOL)validateMobilePhone:(NSString *)mobile;

+ (BOOL)validateIdentity:(NSString *)identityCard;
+ (BOOL)validateIsAdult:(NSString *)identityCard;
+ (NSString *)trimSpacesOfString:(NSString *)str;

+ (NSString* )starsReplacedOfString:(NSString *)str withinRange:(NSRange)range;

+ (BOOL)validateNickName:(NSString *)string;

+ (BOOL)valiInviteCode:(NSString *)string;

+ (BOOL)valiLoginPSW:(NSString *)string;
+ (BOOL)valiTransPSW:(NSString *)string;
//验证输入的密码为数字、大小写字母和特殊字符
+(BOOL)validatePassword:(NSString *)password;

@end
