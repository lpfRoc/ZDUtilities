//
//  Utilities.h
//  PlainProgress
//
//  Created by Gome on 15/1/16.
//  Copyright (c) 2015年 xude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZDProgressHUD;
@interface ZDUtilities : NSObject

+(void)setUserDefaultWithValue:(id)value forKey:(NSString *)key;
+(id)valueForKey:(NSString *)key;

/**
 *  将hex色值转换成UIColor
 *
 *  @param stringToConvert hex色值，如#ff00ee, 0Xffffff, bbccff
 *
 *  @return UIColor类型的颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)stringToConvert;//hex色值

#pragma mark - 格式化日期
+ (NSString*)formatDate:(NSDate *)date withFormat:(NSString *)format;//NSDate转String
+ (NSString*)TimeInterval:(NSString *)TimeInterval withFormat:(NSString *)format;//时间戳转时间
#pragma mark - 计算时间 例如：刚刚、几秒钟前、几分钟前
+ (NSString *)calculateTime:(NSString *)dateString;
+ (NSString *)calculateTimeWithhour:(NSString *)dateString ;
+ (NSString *)getChinaDate:(NSString *)dateString;

#pragma mark - 常用控件封装
#pragma mark UIAlertView
+(void)alertShowWithTitle:(NSString *)title
                  message:(NSString *)message
                 delegate:(id)delegate
        cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitle:(NSString *)otherButtonTitle;
#pragma mark UILabel
+ (UILabel *)labelWithFrame:(CGRect)frame
              textAlignment:(NSTextAlignment)textAlignment
                       font:(UIFont *)font text:(NSString *)text
                  textColor:(UIColor *)textColor;
#pragma mark UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image;
#pragma mark UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                   pressImage:(UIImage *)pressImage
                        title:(NSString *)title
             titleNormalColor:(UIColor *)titleNormalColor
              titlePressColor:(UIColor *)titlePressColor
                         font:(UIFont *)font
                 cornerRadius:(CGFloat)cornerRadius
                       target:(id)target
                     selector:(SEL)selector;
#pragma mark UIAlertView，iOS8以后使用UIAlertController
+ (void)alertViewWithPresentingController:(UIViewController *)presentingController
                                    title:(NSString *)title
                                  message:(NSString *)message
                             buttonTitles:(NSArray *)buttonTitles
                                    block:(void (^)(NSInteger))block;

#pragma  mark - 设置导航栏
+(void)title:(NSString *)title titleColor:(UIColor *)titleColor navigationItem:(UINavigationItem *)navigationItem;
+(void)leftNavigaitonBarButtons:(UINavigationItem *)navigationItem
                         target:(id)target
                         action:(SEL)action;//设置导航栏的返回按钮
+(void)leftNavigaitonBarButtons:(UINavigationItem *)navigationItem
                          title:(NSString *)title
                         target:(id)target
                         action:(SEL)action;//设置导航栏的左侧按钮

+(void)rightNavigaitonBarButtons:(UINavigationItem *)navigationItem
                           title:(NSString *)title
                          target:(id)target
                          action:(SEL)action;//设置导航栏的右侧按钮
+(void)rightNavigaitonBarButtons:(UINavigationItem *)navigationItem
                       imageName:(NSString *)imageName
                          target:(id)target action:(SEL)action;//设置导航栏菜单按钮
#pragma mark - 列表加载失败页面
+ (UIView *)showNoRecordsViewWithFrame:(CGRect)frame title:(NSString *)title topGap:(CGFloat)topGap;
#pragma mark - HUD
+ (void)showHud:(UIView*)rootView text:(NSString*)text;//显示HUD
+(void)hideHud:(UIView*)rootView;
+ (void)showHudSuccess:(NSString *)success rootView:(UIView *)rootView  imageName:(NSString *)imageName;//成功时，一秒后消隐
+ (void)showHudFailed:(NSString *)failed rootView:(UIView *)rootView  imageName:(NSString *)imageName;//失败时，一秒后消隐
+ (void)showHud:(NSString *)text rootView:(UIView *)rootView hideAfter:(NSInteger)delayTime;

+(NSString *)deviceUUID;//设备标识，目前使用UDID存KeyChain
+(BOOL)isAPPFirstUsed;//是否第一次使用APP
+(int)DeviceHeightFrame;//导航栏高度
+(int)statusBarHeight;//状态栏高度

+ (NSMutableAttributedString *)attributedStringWithLongString:(NSString *)longString
                                                    subString:(NSString *)subString
                                                        color:(UIColor *)color;
+ (NSMutableAttributedString *)attributedStringWithLongString:(NSString *)longString
                                                subString:(NSString *)subString
                                                    color:(UIColor *)color
                                                     font:(UIFont *)font;

+ (NSString *)pathForUserGesturepassword;//存放手势密码的文件路径
+ (NSString *)pathForLatestSystemMessageTime;//存放最新的系统消息事时间

#pragma mark - runtime机制为对象属性赋值，将网络请求的数据全部转为NSString类型
+ (void)setPropertyWithClassClass:(Class)aClass object:(id)object keyedValues:(NSDictionary *)keyedValues;
//格式话小数 四舍五入类型
//NSLog(@"----%@---",[ZDUtilities decimalwithFormat:@"0.0000" floatV:0.334]);
+ (NSString *)decimalwithFormat:(NSString *)format  floatV:(float)floatV;
+ (NSString *)formatStringToSaveWithString:(NSString *)string digit:(NSInteger)digit decimalStyle:(BOOL)flag;//金额千分位显示

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string;

typedef NS_ENUM(NSInteger, CalculateType){
    CalculateTypeAdding,//加
    CalculateTypeSubtracting,//减
    CalculateTypeMultiplying,//乘
    CalculateTypeDividing,//除
};
//高精度的加减乘除
+ (NSString *)calculateWithFirstValue:(NSString *)firstValue secondValue:(NSString *)secondValue type:(CalculateType)type;

+ (NSString *)stringFromidString:(id)idString;//出来网络请求的数据，防止NSNull值

//根据银行编码获取对应的图片
+ (NSString *)imageWithBankCode:(NSString *)bankCode;

//TODO:字体设置
+ (UIFont *)thinFontWithSize:(CGFloat)fontSize;
//生产uiimage
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//获取label高度
+(CGSize) getStrLenByFontStyle:(NSString*) str fontStyle:(UIFont*) fontStyle textWidth:(float) textWidth;
//生成随机整数区间
+(int)getRandomNumber:(int)from to:(int)to;

+ (NSString *)decimalNumberWithDouble:(double )conversionValue;
@end
