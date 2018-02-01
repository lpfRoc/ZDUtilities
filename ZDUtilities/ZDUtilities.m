//
//  Utilities.m
//  PlainProgress
//
//  Created by Gome on 15/1/16.
//  Copyright (c) 2015年 xude. All rights reserved.
//

#import "ZDUtilities.h"
#import <objc/runtime.h>
@implementation ZDUtilities
#pragma mark NSUserDefault使用封装
+(void)setUserDefaultWithValue:(id)value forKey:(NSString *)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+(id)valueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

#pragma mark - hex色值
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    //if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//#pragma mark - 格式化日期
//+ (NSString *)formatDate:(NSDate *)date withFormat:(NSString *)format{//NSDate转String
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = format;
//    return [formatter stringFromDate:date];
//}
//
//+ (NSString *)TimeInterval:(NSString *)TimeInterval withFormat:(NSString *)format{//时间戳转时间
//    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[TimeInterval longLongValue]/1000.0f];
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = format;
//    return [formatter stringFromDate:date];
//}
//
//#pragma mark - 计算时间 例如：刚刚、几秒钟前、几分钟前
//+ (NSString *)calculateTime:(NSString *)dateString{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
//    NSDate *destDate= [dateFormatter dateFromString:dateString];
//    
//    NSTimeInterval secondsInterval = [destDate timeIntervalSinceNow];
//    NSInteger secondsInt = -secondsInterval;//目标时间距离当前有多少秒
//    NSString *destDateString;
//    if (secondsInt < 0) {
//        destDateString = [NSString stringWithFormat:@"刚刚"];
//        return destDateString;
//    }
//    if (secondsInt >= 24*60*60) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
//        destDateString = [dateFormatter stringFromDate:destDate];
//    }else{
//        NSInteger residualTimeHour = secondsInt/60/60;
//        if (residualTimeHour == 0) {
//            NSInteger residualTimeMinute = secondsInt/60;
//            if (residualTimeMinute == 0) {
//                NSInteger residualTimesecond = secondsInt;
//                if (residualTimesecond == 0) {
//                    destDateString = [NSString stringWithFormat:@"刚刚"];
//                }else{
//                    destDateString = [NSString stringWithFormat:@"%zd秒前", residualTimesecond];
//                }
//                
//            }else{
//                destDateString = [NSString stringWithFormat:@"%zd分钟前", residualTimeMinute];
//            }
//        }else{
//            destDateString = [NSString stringWithFormat:@"%zd小时前", residualTimeHour];
//        }
//    }
//    return destDateString;
//}
//
//+ (NSString *)calculateTimeWithhour:(NSString *)dateString
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
//    NSDate *destDate= [dateFormatter dateFromString:dateString];
//    
//    NSTimeInterval secondsInterval = [destDate timeIntervalSinceNow];
//    NSInteger secondsInt = -secondsInterval;//目标时间距离当前有多少秒
//    NSString *destDateString;
//    if (secondsInt < 0) {
//        destDateString = [NSString stringWithFormat:@"刚刚"];
//        return destDateString;
//    }
//    if (secondsInt >= 24*60*60) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
//        destDateString = [dateFormatter stringFromDate:destDate];
//    }else{
//        NSInteger residualTimeHour = secondsInt/60/60;
//        if (residualTimeHour == 0) {
//            NSInteger residualTimeMinute = secondsInt/60;
//            if (residualTimeMinute == 0) {
//                NSInteger residualTimesecond = secondsInt;
//                if (residualTimesecond == 0) {
//                    destDateString = [NSString stringWithFormat:@"刚刚"];
//                }else{
//                    destDateString = [NSString stringWithFormat:@"%d秒前",(int)residualTimesecond];
//                }
//                
//            }else{
//                destDateString = [NSString stringWithFormat:@"%d分钟前",(int)residualTimeMinute];
//            }
//        }else{
//            destDateString = [NSString stringWithFormat:@"%d小时前",(int)residualTimeHour];
//        }
//    }
//    return destDateString;
//}
//
//+(NSString *)getChinaDate:(NSString *)dateString{
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];//定义NSDateFormatter用来显示格式
//    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定格式
//    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
//    
//    NSDate *todate = [dateformatter dateFromString:dateString];
//    
//    NSDate *today = [NSDate date];//得到当前时间
//    //用来得到具体的时差
//    unsigned int unitFlags;
//    if (IOS8) {
//        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | kCFCalendarUnitSecond;
//    }else{
//        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | kCFCalendarUnitSecond;
//    }
//    NSDateComponents *comps = [cal components:unitFlags fromDate:today toDate:todate options:0];
//    
//    if ([comps year]>0) {
//        return [NSString stringWithFormat:@"%d年%d月%d天",(int)[comps year], (int)[comps month], (int)[comps day]];
//    }else if ([comps month]>0) {
//        return [NSString stringWithFormat:@"%d月%d天%d小时",(int)[comps month],(int)[comps day],(int)[comps hour]];
//    }else if ([comps day]>0) {
//        return [NSString stringWithFormat:@"%d天%d小时%d分",(int)[comps day],(int)[comps hour],(int)[comps minute]];
//    }else if ([comps hour]>0) {
//        return [NSString stringWithFormat:@"%d小时%d分",(int)[comps hour],(int)[comps minute]];
//    }else if ([comps minute]>0) {
//        return [NSString stringWithFormat:@"%d分钟",(int)[comps minute]];
//    }else if ([comps second]>0){
//        return @"1分";
//    }else {
//        return @"已过期";
//    }
//}
//
//#pragma mark - 常用控件封装
//#pragma mark UIAlertView
//+(void)alertShowWithTitle:(NSString *)title
//                  message:(NSString *)message
//                 delegate:(id)delegate
//        cancelButtonTitle:(NSString *)cancelButtonTitle
//         otherButtonTitle:(NSString *)otherButtonTitle{
//    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:title
//                                                        message:message
//                                                       delegate:delegate
//                                              cancelButtonTitle:cancelButtonTitle
//                                              otherButtonTitles:otherButtonTitle, nil];
//    [alertView show];
//}
//
//#pragma mark UILabel
//+ (UILabel *)labelWithFrame:(CGRect)frame
//              textAlignment:(NSTextAlignment)textAlignment
//                       font:(UIFont *)font
//                       text:(NSString *)text
//                  textColor:(UIColor *)textColor{
//    UILabel * label = [[UILabel alloc]initWithFrame:frame];
//    label.backgroundColor = [UIColor clearColor];
//    label.text = text;
//    label.textAlignment = textAlignment;
//    label.font = font;
//    label.textColor = textColor;
//    return label;
//}
//
//#pragma mark UIImageView
//+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image{
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
//    imageView.userInteractionEnabled = YES;
//    imageView.image = image;
//    return imageView;
//}
//
//#pragma mark UIButton
//+ (UIButton *)buttonWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage pressImage:(UIImage *)pressImage title:(NSString *)title titleNormalColor:(UIColor *)titleNormalColor titlePressColor:(UIColor *)titlePressColor font:(UIFont *)font cornerRadius:(CGFloat)cornerRadius target:(id)target selector:(SEL)selector{
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = frame;
//    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
//    [button setBackgroundImage:pressImage forState:UIControlStateHighlighted];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitle:title forState:UIControlStateHighlighted];
//    [button setTitleColor:titleNormalColor forState:UIControlStateNormal];
//    [button setTitleColor:titlePressColor forState:UIControlStateHighlighted];
//    button.titleLabel.font = font;//字体大小
//    button.layer.cornerRadius = cornerRadius;//导角
//    button.layer.masksToBounds = YES;
//    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
//
//#pragma mark UIAlertView，iOS8以后使用UIAlertController
//+ (void)alertViewWithPresentingController:(UIViewController *)presentingController
//                                    title:(NSString *)title message:(NSString *)message
//                             buttonTitles:(NSArray *)buttonTitles
//                                    block:(void (^)(NSInteger))block{
////    OCAlertView * alertView = [OCAlertView shareInstance];
////    [alertView presentingController:presentingController
////                              title:title
////                            message:message
////                       buttonTitles:buttonTitles
////                              block:block];
////    [alertView alertShow];
//
//    OCControlAlertView * alert = [[OCControlAlertView alloc]initWithTitle:title
//                                                                  message:message
//                                                             buttonTitles:buttonTitles];
//    [alert setControlAlertViewBlock:block];
//    [alert becomeFirstResponder];
//    if (presentingController.tabBarController) {
//        [presentingController.tabBarController.view addSubview:alert];
//    }else if (presentingController.navigationController){
//        [presentingController.navigationController.view addSubview:alert];
//    }else{
//        [presentingController.view addSubview:alert];
//    }
//}
//#pragma  mark - 设置导航栏
//+(void)title:(NSString *)title titleColor:(UIColor *)titleColor navigationItem:(UINavigationItem *)navigationItem{
//    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = [UIFont systemFontOfSize:18.0f];
//    titleLabel.text = title;
//    titleLabel.textColor = titleColor;
//    navigationItem.titleView = titleLabel;
//}
//
//+(void)leftNavigaitonBarButtons:(UINavigationItem *)navigationItem target:(id)target action:(SEL)action{//设置导航栏菜单按钮
//    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:IMAGE_BUNDLE_(@"ico_back") style:UIBarButtonItemStyleBordered target:target action:action];
//    navigationItem.leftBarButtonItem = item;
////    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    backButton.frame = CGRectMake(0, 0, 20 * 0.6, 34 * 0.6);
////    [backButton setBackgroundImage:bundleImage(@"ico_back") forState:UIControlStateNormal];
////    [backButton setBackgroundImage:bundleImage(@"ico_back") forState:UIControlStateHighlighted];
////    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
////    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
////    backBarButton.style = UIBarButtonItemStylePlain;
////    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
////                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
////                                       target:nil action:nil];
////    if (IOS7) {
////        negativeSpacer.width = -5;
////    }else{
////        negativeSpacer.width = 5;
////    }
////    navigationItem.leftBarButtonItems = @[negativeSpacer, backBarButton];
//}
//+(void)leftNavigaitonBarButtons:(UINavigationItem *)navigationItem title:(NSString *)title target:(id)target action:(SEL)action{//设置导航栏的左侧文字按钮
//    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
//    leftBarButton.style = UIBarButtonItemStylePlain;
//    navigationItem.leftBarButtonItem = leftBarButton;
//}
//
//+(void)rightNavigaitonBarButtons:(UINavigationItem *)navigationItem title:(NSString *)title target:(id)target action:(SEL)action{//设置导航栏菜单按钮
//    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithTitle:title
//                                                                       style:UIBarButtonItemStyleDone
//                                                                      target:target
//                                                                      action:action];
//    rightBarButton.style = UIBarButtonItemStylePlain;
//    navigationItem.rightBarButtonItems = @[rightBarButton];
//}
//
//+(void)rightNavigaitonBarButtons:(UINavigationItem *)navigationItem imageName:(NSString *)imageName target:(id)target action:(SEL)action{//设置导航栏菜单按钮
//    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0, 0, 44, 44);
//    [rightButton setImage:IMAGE_BUNDLE_(imageName) forState:UIControlStateNormal];
//    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil action:nil];
//    //width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
//    //为0；width为正数时，正好相反，相当于往左移动width数值个像素
//    negativeSpacer.width = -10;
//    navigationItem.rightBarButtonItems = @[negativeSpacer, rightBarButton];
//    rightBarButton.style = UIBarButtonItemStylePlain;
//}
//
//#pragma mark - 列表加载失败页面
//+ (UIView *)showNoRecordsViewWithFrame:(CGRect)frame  title:(NSString *)title topGap:(CGFloat)topGap{
//    ZDLoadFailView *failedView = [[ZDLoadFailView alloc] initWithFrame:frame title:title topGap:topGap];
//    return failedView;
//}
//#pragma mark - HUD
//+ (void)showHud:(UIView*)rootView text:(NSString*)text {
//    ZDProgressHUD *HUD = [ZDProgressHUD showHUDAddedTo:rootView animated:YES];
////    HUD.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
//    HUD.backgroundColor = COLOR_CLEAR;
//    HUD.detailsLabelText = text;
//    HUD.color = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
//}
//+(void)hideHud:(UIView*)rootView{
//    ZDProgressHUD * hud = [ZDProgressHUD HUDForView:rootView];
//    if (hud) {
//        hud.removeFromSuperViewOnHide = YES;//加上这一句，否则出现严重内存泄露   许杜生 2015.07.07  20：04
//        [hud hide:YES];
//    }
//}
//
//+ (void)showHudSuccess:(NSString *)success rootView:(UIView *)rootView imageName:(NSString *)imageName{
//    ZDProgressHUD *zd_HUD = [[ZDProgressHUD alloc] initWithView:rootView];
//    zd_HUD.backgroundColor =  imageName?[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f]:[UIColor clearColor];
//    zd_HUD.color = [UIColor colorWithWhite:0 alpha:0.7];
//    [rootView addSubview:zd_HUD];
//    
//    UIImageView * customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName?imageName:@"zzzzz"]];//消除警告CUICatalog: Invalid asset name supplied:   在ios7中设置imageView的image时，实例化image时不能传nil,(self.imageView.image = [UIImage imageNamed:nil] 上图所报的错，就是因为这句话)。
//    zd_HUD.customView = customView;
//    zd_HUD.mode = ZDProgressHUDModeCustomView;
//    if (imageName) {
//        zd_HUD.detailsLabelText = success;
//    }else{
//        zd_HUD.labelText = success;
//    }
//    zd_HUD.removeFromSuperViewOnHide = YES;
//    [zd_HUD show:YES];
//    [zd_HUD hide:YES afterDelay:1.0];
//}
//
//+ (void)showHudFailed:(NSString *)failed rootView:(UIView *)rootView imageName:(NSString *)imageName{
//    ZDProgressHUD *zd_HUD = [[ZDProgressHUD alloc] initWithView:rootView];
//    zd_HUD.backgroundColor =  imageName?[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f]:[UIColor clearColor];
//    zd_HUD.color = [UIColor colorWithWhite:0 alpha:0.7];
//    [rootView addSubview:zd_HUD];
//    UIImageView * customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName?imageName:@"zzzzz"]];//消除警告CUICatalog: Invalid asset name supplied:
//    zd_HUD.customView = customView;
//    zd_HUD.mode = ZDProgressHUDModeCustomView;
//    if (imageName) {
//        zd_HUD.detailsLabelText = failed;
//    }else{
//        zd_HUD.labelText = failed;
//    }
//    zd_HUD.removeFromSuperViewOnHide = YES;
//    [zd_HUD show:YES];
//    [zd_HUD hide:YES afterDelay:1.0];
//    //    [gome_HUD release];//aa00
//}
//+ (void)showHud:(NSString *)text rootView:(UIView *)rootView hideAfter:(NSInteger)delayTime{
//    ZDProgressHUD *zd_HUD = [[ZDProgressHUD alloc] initWithView:rootView];
//    zd_HUD.backgroundColor =  [UIColor clearColor];
//    zd_HUD.color = [UIColor colorWithWhite:0 alpha:0.7];
//    [rootView addSubview:zd_HUD];
////    UIImageView * customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName?imageName:@"zzzzz"]];//消除警告CUICatalog: Invalid asset name supplied:
////    zd_HUD.customView = customView;
//    zd_HUD.mode = ZDProgressHUDModeCustomView;
//        zd_HUD.labelText = text;
//    zd_HUD.removeFromSuperViewOnHide = YES;
//    [zd_HUD show:YES];
//    [zd_HUD hide:YES afterDelay:delayTime];
//}
//#pragma mark - 设备标识
////+(NSString *)deviceUUID{
////    NSString * UUID = [SSKeychain passwordForService:Thumb_appIdentifier account:Thumb_appIdentifier];
////    if (!UUID || [UUID isEqualToString:@""]) {
////        //iOS中获取UUID的代码如下
////        CFUUIDRef puuid = CFUUIDCreate( nil );
////        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
////        NSString * result = (NSString *)CFStringCreateCopy( NULL, uuidString);
////        CFRelease(puuid);
////        CFRelease(uuidString);
////        BOOL isSet = [SSKeychain setPassword:result forService:GomeStore_appIdentifier account:GomeStore_appIdentifier];
////        if (!isSet) {
////            return @"获取设备标识失败";
////        }
////    }
////    NSString * deviceUUID = [[SSKeychain passwordForService:GomeStore_appIdentifier account:GomeStore_appIdentifier]retain];
////    return [deviceUUID autorelease];
////}
//
//#pragma mark - 设备标识
//+(NSString *)deviceUUID{
//    NSLog(@"kAppIdentifier = %@", DEVICE_APP_BUNDLE_IDENTIFIER);
////    NSString * UUID = [SSKeychain passwordForService:DEVICE_APP_BUNDLE_IDENTIFIER account:DEVICE_APP_BUNDLE_IDENTIFIER];
////    if (!UUID || [UUID isEqualToString:@""]) {
////        //iOS中获取UUID的代码如下
////        CFUUIDRef puuid = CFUUIDCreate( nil );
////        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
////        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
////        CFRelease(puuid);
////        CFRelease(uuidString);
////        [SSKeychain setPassword:result forService:DEVICE_APP_BUNDLE_IDENTIFIER account:DEVICE_APP_BUNDLE_IDENTIFIER];
////        if (result.length) {
////            return result;
////        }
////    }
////    NSString * uuid = [SSKeychain passwordForService:DEVICE_APP_BUNDLE_IDENTIFIER account:DEVICE_APP_BUNDLE_IDENTIFIER]?[SSKeychain passwordForService:DEVICE_APP_BUNDLE_IDENTIFIER account:DEVICE_APP_BUNDLE_IDENTIFIER]:@"";
////    NSString * deviceUUID = [[NSString alloc]initWithString:uuid];
//    return @"";
//}
//
//#pragma mark - 是否第一次使用这个应用
//+(BOOL)isAPPFirstUsed{
//    NSString * identifier = @"isFirstUsed";
////    NSString * isFirstUsed = [SSKeychain passwordForService:identifier account:identifier];
////    if (!isFirstUsed || [isFirstUsed isEqualToString:@""]) {
////        return [SSKeychain setPassword:@"1" forService:identifier account:identifier];
////    }
//    return NO;
//}
//#pragma mark - 设备高度
//+(int)DeviceHeightFrame{
//    if (IOS7) {
//        return 64;
//    }else{
//        return 44;
//    }
//}
//
//+(int)statusBarHeight{
//    if (IOS7) {
//        return 0;
//    }
//    return 20;
//}
//
//+ (NSMutableAttributedString *)attributedStringWithLongString:(NSString *)longString
//                                                    subString:(NSString *)subString
//                                                        color:(UIColor *)color{
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:longString];
//    NSRange redTextRange = [longString rangeOfString:subString];
//    [str addAttribute:NSForegroundColorAttributeName value:color range:redTextRange];
//    return str;
//}
//+ (NSMutableAttributedString *)attributedStringWithLongString:(NSString *)longString
//                                                    subString:(NSString *)subString
//                                                        color:(UIColor *)color
//                                                         font:(UIFont *)font{
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:longString];
//    NSRange redTextRange = [longString rangeOfString:subString];
//    [str addAttribute:NSForegroundColorAttributeName value:color range:redTextRange];
//    [str addAttribute:NSFontAttributeName value:font range:redTextRange];
//    return str;
//}
//
//+ (NSString *)pathForUserGesturepassword//存放手势密码的文件路径
//{
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"gesture.plist"];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
//    }
//    return path;
//}
//
//+ (NSString *)pathForLatestSystemMessageTime{//存放最新的系统消息事时间, 存储个人中心显示与隐藏按钮的状态
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"latestSystemMessageTimel.plist"];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
//    }
//    return path;
//}
//
//#pragma mark - runtime机制为对象属性赋值，将网络请求的数据全部转为NSString类型
//+ (void)setPropertyWithClassClass:(Class)aClass object:(id)object keyedValues:(NSDictionary *)keyedValues{
//    unsigned int count;
//    Ivar *properties = class_copyIvarList(aClass, &count);
//    for(int i = 0; i < count; i++)
//    {
//        Ivar ivar = properties[i];
//        const char *_propertyName = ivar_getName(ivar); // 获取变量名
//        NSString * propertyName = [[NSString stringWithFormat:@"%s", _propertyName] substringFromIndex:1];
//        id obj = keyedValues[propertyName];
////        NSLog(@"propertyName = %@ :::::::: obj = %@", propertyName, obj);
//        id value = @"";
//        if ([obj isKindOfClass:[NSNumber class]]) {
//            NSString * numString = [NSString stringWithFormat:@"%@", obj];
////            value = ([numString doubleValue] >= 0)?numString:@"";
//            value = numString;
//        }else if ([obj isKindOfClass:[NSString class]]){
//            value = obj;
//        }else if ([obj isKindOfClass:[NSDictionary class]]){
//            value = obj;
//        }
//        object_setIvar(object, ivar, value);//修改变量的值
//    }
//    free(properties);
//}
////格式话小数 四舍五入类型
////NSLog(@"----%@---",[ZDUtilities decimalwithFormat:@"0.0000" floatV:0.334]);
//+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV{
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    [numberFormatter setPositiveFormat:format];
//    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
//}
//
////金额千分位显示
//+ (NSString *)formatStringToSaveWithString:(NSString *)string digit:(NSInteger)digit decimalStyle:(BOOL)flag
//{
//    if (!string.length) return @" ";
//    if (flag) {
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        formatter.numberStyle = NSNumberFormatterDecimalStyle;
//        string = [formatter stringFromNumber:[NSNumber numberWithDouble:string.doubleValue]];
//    }
//    
//    NSArray *arr = [string componentsSeparatedByString:@"."];
//    if (arr.count == 1) {
//        if (!digit) return string;
//        
//        string = [string stringByAppendingString:@"."];
//        for (int i = 0; i < digit; i ++) {
//            string = [string stringByAppendingString:@"0"];
//        }
//        return string;
//    } else {
//        NSString *beforeString = arr[0];
//        NSString *afterString = arr[1];
//        
//        if (digit == 0) {
//            return [string componentsSeparatedByString:@"."][0];
//        } else if (afterString.length >= digit) {
//            return [NSString stringWithFormat:@"%@.%@",beforeString,[afterString substringToIndex:digit]];
//        }
////        else if (afterString.length > digit)
////        {
////            NSString *valueStr =  [NSString stringWithFormat:@"%@",[afterString substringToIndex:digit+1]];
////            NSString *lastStr = [valueStr substringFromIndex:valueStr.length-1];
////
////            if ([lastStr integerValue] >= 5) {
////                NSString *aa =  [NSString stringWithFormat:@"%@",[afterString substringToIndex:digit]];
////                NSString *bb =  [NSString stringWithFormat:@"%@",[aa substringFromIndex:aa.length-1]];
////                NSInteger new = [bb integerValue] + 1;
////                bb = [NSString stringWithFormat:@"%ld",(long)new];
////
////                return [NSString stringWithFormat:@"%@.%@%@",beforeString,[aa substringToIndex:digit-1],bb];
////            }else
////            {
////            return [NSString stringWithFormat:@"%@.%@",beforeString,[afterString substringToIndex:digit]];
////            }
////
////        }
//        else {
//            NSUInteger c = digit - afterString.length;
//            for (int k = 0; k < c; k ++) {
//                string = [string stringByAppendingString:@"0"];
//            }
//            return string;
//        }
//    }
//}
//    //判断是否为整形：
//+ (BOOL)isPureInt:(NSString*)string{
//    NSScanner* scan = [NSScanner scannerWithString:string];
//    int val;
//    return [scan scanInt:&val] && [scan isAtEnd];
//}
////判断是否为浮点形：
//+ (BOOL)isPureFloat:(NSString*)string{
//    NSScanner* scan = [NSScanner scannerWithString:string];
//    float val;
//    return[scan scanFloat:&val] && [scan isAtEnd];
//}
//
///** 直接传入精度丢失有问题的Double类型*/
//+ (NSString *)decimalNumberWithDouble:(double )conversionValue{
//    NSString *doubleString   = [NSString stringWithFormat:@"%lf", conversionValue];
//    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
//    return [decNumber stringValue];
//}
//
////高精度的加减乘除
//+ (NSString *)calculateWithFirstValue:(NSString *)firstValue secondValue:(NSString *)secondValue type:(CalculateType)type{
////    firstValue = firstValue.length?firstValue:@"0";
////    secondValue = secondValue.length?secondValue:@"0";
//    NSDecimalNumber *firstNumber = [NSDecimalNumber decimalNumberWithString:firstValue.length?firstValue:@"0"];
//    NSDecimalNumber *secondNumber = [NSDecimalNumber decimalNumberWithString:secondValue.length?secondValue:@"0"];
//    NSDecimalNumber *sumNumber = [NSDecimalNumber zero];
//    SEL selector;
//    switch (type) {
//        case CalculateTypeAdding:
//            selector = @selector(decimalNumberByAdding:);
//            break;
//        case CalculateTypeSubtracting:
//            selector = @selector(decimalNumberBySubtracting:);
//            break;
//        case CalculateTypeMultiplying:
//            selector = @selector(decimalNumberByMultiplyingBy:);
//            break;
//        case CalculateTypeDividing:
//            selector = @selector(decimalNumberByDividingBy:);
//            break;
//    }
//    @try {
//        IMP imp = [firstNumber methodForSelector:selector];
//        NSDecimalNumber * (*func)(id, SEL, id) = (void *)imp;
//        sumNumber = func(firstNumber, selector, secondNumber);
//    } @catch (NSException *exception) {//NSDecimalNumberDivideByZeroException
//        NSLog(@"calculateWithFirstValue: secondValue: type:方法捕获到异常 = %@", exception.name);
//    }
//    return sumNumber.stringValue;
//}
//
//+ (NSString *)stringFromidString:(id)idString{
//    if (!idString) {
//        return @"";
//    }
//    if ([idString isKindOfClass:[NSString class]]) {
//        return idString;
//    }else if ([idString isKindOfClass:[NSNumber class]]){
//        return [NSString stringWithFormat:@"%@", idString];
//    }
////    else if ([idString isKindOfClass:[NSNull class]]) {
////        return @"";
////    }
//    else{
//        return @"";
//    }
//}
////根据银行编码获取对应的图片
//+ (NSString *)imageWithBankCode:(NSString *)bankCode{
//    if (!bankCode || !bankCode.length) {
//        return @"jjjjj";
//    }
//    if ([bankCode isEqualToString:@"751632"] || [bankCode isEqualToString:@"03050000"]) {
//        return @"3_ico_minsheng";
//    }else if ([bankCode isEqualToString:@"638348"] || [bankCode isEqualToString:@"03060000"]) {
//        return @"3_ico_guangfa";
//    }else if ([bankCode isEqualToString:@"061555"] || [bankCode isEqualToString:@"03090000"]) {
//        return @"3_ico_xingye";
//    }else if ([bankCode isEqualToString:@"600646"] || [bankCode isEqualToString:@"03020000"]) {
//        return @"3_ico_zhongxin";
//    }else if ([bankCode isEqualToString:@"966504"] || [bankCode isEqualToString:@"03080000"]) {
//        return @"3_ico_zhaohang";
//    }else if ([bankCode isEqualToString:@"075120"] || [bankCode isEqualToString:@"03100000"]) {
//        return @"3_ico_pufa";
//    }else if ([bankCode isEqualToString:@"681925"] || [bankCode isEqualToString:@"03070000"]) {
//        return @"3_ico_pingan";
//    }else if ([bankCode isEqualToString:@"148571"] || [bankCode isEqualToString:@"03040000"]) {
//        return @"3_ico_huaxia";
//    }else if ([bankCode isEqualToString:@"848418"] || [bankCode isEqualToString:@"03030000"]) {
//        return @"3_ico_guangda";
//    }else if ([bankCode isEqualToString:@"579047"] || [bankCode isEqualToString:@"01050000"]) {
//        return @"3_ico_jianhang";
//    }else if ([bankCode isEqualToString:@"524059"] || [bankCode isEqualToString:@"01040000"]) {
//        return @"3_ico_zhonghang";
//    }else if ([bankCode isEqualToString:@"807118"] || [bankCode isEqualToString:@"01030000"]) {
//        return @"3_ico_nonghang";
//    }else if ([bankCode isEqualToString:@"865802"] || [bankCode isEqualToString:@"01020000"]) {
//        return @"3_ico_gonghang";
//    }else if ([bankCode isEqualToString:@"204491"] || [bankCode isEqualToString:@"03010000"]) {
//        return @"3_ico_jiaotong";
//    }else if([bankCode isEqualToString:@"108845"] || [bankCode isEqualToString:@"01000000"]){
//        return @"3_ico_youchu";
//    }else if([bankCode isEqualToString:@"638777"]){
//        return @"3_ico_beijing";
//    }else if([bankCode isEqualToString:@"638788"]){
//        return @"3_ico_hangzhou";
//    }else if([bankCode isEqualToString:@"638799"]){
//        return @"3_ico_guangzhou";
//    }else{
//        return @"3_ico_bank";
//    }
//}
//
////TODO:字体设置
//+ (UIFont *)thinFontWithSize:(CGFloat)fontSize{
//    BOOL isIOS8_2 = ([[UIDevice currentDevice] systemVersion].floatValue >= 8.2f);
//    if (isIOS8_2) {
//        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];
//    }
//    return [UIFont systemFontOfSize:fontSize];
//}
//
//+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
//
//{
//    @autoreleasepool {
//        
//        CGRect rect = CGRectMake(0, 0, size.width, size.height);
//        
//        UIGraphicsBeginImageContext(rect.size);
//        
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        CGContextSetFillColorWithColor(context,
//                                       
//                                       color.CGColor);
//        
//        CGContextFillRect(context, rect);
//        
//        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//        
//        UIGraphicsEndImageContext();
//        
//        
//        
//        return img;
//        
//    }
//
//}
//
//+(CGSize) getStrLenByFontStyle:(NSString*) str fontStyle:(UIFont*) fontStyle textWidth:(float) textWidth{
//    if (!fontStyle) {
//        fontStyle = [UIFont systemFontOfSize:14];
//    }
//    if ([str isEqual:[NSNull null]] || [str isEqualToString:@"(null)"]) {
//        return CGSizeZero;
//    }
//    NSDictionary *attributes = @{NSFontAttributeName: fontStyle};
//    CGRect rect = [str boundingRectWithSize:CGSizeMake(textWidth, 0)
//                                    options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
//                                 attributes:attributes
//                                    context:nil];
//    return rect.size;
//}
//
//+(int)getRandomNumber:(int)from to:(int)to
//{
//    return (int)(from + (arc4random() % (to - from + 1)));
//}
@end
