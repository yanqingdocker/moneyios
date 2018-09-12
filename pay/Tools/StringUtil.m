//
//  StringUtil.m
//  pay
//
//  Created by 胡彦清 on 2018/9/10.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil


+ (BOOL)isNullOrEmpty:(NSString *)str {
    return ([str isEqualToString:@""] || str == nil);
}

//删除小数点后面多余的0
+(NSString *)changeFloat:(NSString *)stringFloat
{
    NSInteger length = [stringFloat length];
    if ([stringFloat containsString:@"."]) {
        
        for(NSInteger i = length - 1; i >= 0; i--)
        {
            NSString *subString = [stringFloat substringFromIndex:i];
            if(![subString isEqualToString:@"0"])
            {
                if ([subString isEqualToString:@"."]) {
                    
                    return [stringFloat substringToIndex:[stringFloat length] - 1];
                    
                }else{
                    
                    return stringFloat;
                }
            }
            else
            {
                stringFloat = [stringFloat substringToIndex:i];
            }
        }
    }
    return 0;
}

//校验四位小数金额输入
+ (BOOL)validateMoney:(NSString *)number Range:(NSRange)range String:(NSString *)string
{
    NSInteger strLength = number.length - range.length + string.length;
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [number rangeOfString:@"."].location;
//    unichar single = [string characterAtIndex:0];//当前输入的字符
//    if([number length] == 1){
//        if([number isEqualToString:@"0"]){
//            if (single == '.') {
//                //                    如果第一位是0,第二位必须是.
//                [number stringByReplacingCharactersInRange:range withString:@""];
//                return YES;
//            }
//            else{
//                return NO;
//            }
//            
//        }
//    }
    if (NSNotFound == nDotLoc && 0 != range.location) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSDOT_ONLY] invertedSet];
        if([string isEqualToString:@"."]){
            return YES;
        }
        if(!(strLength <= 13)){
            return NO;
        }
    }
    else
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        if(!(strLength <= 16)){
            return NO;
        }
    }
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest)
    {
        return NO;
    }
    if (NSNotFound != nDotLoc && range.location > nDotLoc + 4)
    {
        return NO;
    }
    return YES;
    
//    BOOL isHaveDian = YES;
//    if ([number rangeOfString:@"."].location == NSNotFound) {
//        isHaveDian = NO;
//    }
//    if ([string length] > 0) {
//        
//        unichar single = [string characterAtIndex:0];//当前输入的字符
//        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
//            
//            //首字母不能为0和小数点
//            if([number length] == 0){
//                if(single == '.') {
//                    //                    第一个数字不能为小数点
//                    [number stringByReplacingCharactersInRange:range withString:@""];
//                    return NO;
//                }
//            }
//            
//            if([number length] == 1){
//                if([number isEqualToString:@"0"]){
//                    if (single == '.') {
//                        //                    如果第一位是0,第二位必须是.
//                        [number stringByReplacingCharactersInRange:range withString:@""];
//                        return YES;
//                    }
//                    else{
//                        return NO;
//                    }
//                    
//                }
//            }
//
//            //输入的字符是否是小数点
//            if (single == '.') {
//                if(!isHaveDian)//text中还没有小数点
//                {
//                    isHaveDian = YES;
//                    return YES;
//                }else{
//                    //                    已经输入过小数点了
//                    [number stringByReplacingCharactersInRange:range withString:@""];
//                    return NO;
//                }
//            }else{
//                if (isHaveDian) {//存在小数点
//                    
//                    //判断小数点的位数
//                    NSRange ran = [number rangeOfString:@"."];
//                    if (range.location - ran.location <= 2) {
//                        return YES;
//                    }else{
//                        //                        最多输入两位小数
//                        return NO;
//                    }
//                }else{
//                    return YES;
//                }
//            }
//        }else{//输入的数据格式不正确
//            [number stringByReplacingCharactersInRange:range withString:@""];
//            return NO;
//        }
//    }
//    else
//    {
//        return YES;
//    }


    
}

//校验全数字字符
+ (BOOL)validateNumbers:(NSString *)number
{
    
    NSString *num=@"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",num];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:[self trimSpacesOfString:email]];
}

//银行卡号校验
+ (BOOL) validateBankNumber:(NSString *) bankNumber{
    NSString *bankNum=@"^([0-9]{16}|[0-9]{17}|[0-9]{18}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:bankNumber];
    return isMatch;
}

//手机号码验证
+ (BOOL)validateMobilePhone:(NSString *)telNumber {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:telNumber];
}

//验证输入的密码为数字、大小写字母和特殊字符
+(BOOL)validatePassword:(NSString *)password
{
    //NSString *passwordRegex = @"[^%&',;=?$\x22]|[a-zA-Z0-9]*";  //数字、大小写字母和标点符号
    NSString *passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![!#$%^&*]+$)[0-9A-Za-z!#$%^&*]{6,20}$"; 
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [identityCardPredicate evaluateWithObject:[self trimSpacesOfString:password]];
}
//身份证号
+ (BOOL)validateIdentity:(NSString *)identityCard {
    
    if (identityCard.length <= 0)
    {
        return false;
    }

    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:[self trimSpacesOfString:identityCard]];
}


+ (BOOL)validateIsAdult:(NSString *)identityCard
{
    NSString *birthdayStr = [identityCard substringWithRange:NSMakeRange(6, 8)];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyyMMdd"];
    [fm setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date = [fm dateFromString:birthdayStr];
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
    |NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
//    AppLog(@"%ld",cmps.year);
    return cmps.year >= 18;
}

//验证是否全中文
+ (BOOL)validateChinese:(NSString *)string
{
    NSString *phoneRegex = @"^[\\u4E00-\\u9FA5]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:[self trimSpacesOfString:string]];
}

//验证昵称
+(BOOL)validateNickName:(NSString *)string
{
    NSString *phoneRegex = @"^[\u4e00-\u9fa5a-zA-Z0-9_-]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:[self trimSpacesOfString:string]];
}


+ (BOOL)validatePSW:(NSString *)string {

    if (string.length <= 0) return false;

    return ![[string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:string]
            && ![[string stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]] isEqualToString:string];
}

//打上星号
+ (NSString* )starsReplacedOfString:(NSString *)str withinRange:(NSRange)range;
{
    if (str == nil || [str length]< range.location + range.length)
    {
        return str;
    }
    

    NSMutableString* mStr = [[NSMutableString alloc]initWithString:str];
   
    [mStr replaceCharactersInRange:range withString:[[NSString string] stringByPaddingToLength:range.length withString: @"*" startingAtIndex:0]];
    
    return mStr;
}


//去掉空格
+ (NSString *)trimSpacesOfString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (BOOL)valiInviteCode:(NSString *)string {
    NSString *regex = @"^[a-zA-Z]\\d{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:[self trimSpacesOfString:string]];
}

//验证登录密码
+ (BOOL)valiLoginPSW:(NSString *)string {
    NSString *regex = @"^[A-Za-z0-9]{6,8}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:[self trimSpacesOfString:string]];
}

//验证交易密码
+ (BOOL)valiTransPSW:(NSString *)string
{
    NSString *regex = @"^[A-Za-z0-9]{8,16}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:[self trimSpacesOfString:string]];
}

@end
