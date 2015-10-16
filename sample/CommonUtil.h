//
//  CommonUtil.h
//  BeaconLettuce
//
//  Created by 古川信行 on 2015/08/11.
//  Copyright (c) 2015年 古川 信行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
//#define NSLog(...)
#endif
//ALog always displays output regardless of the DEBUG alarm
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//hue操作に利用するユーザー名
#define VIE_HUE_USERNAME @"vieapphueuser"

@interface CommonUtil : NSObject

//Storyboardを取得
+(UIStoryboard*) storyBoard;

//モーダルでヴューを表示
+(void) openModalViewController:(UIViewController*)currentViewController viewControllerName:(NSString*) viewControllerName;

//モーダルでヴューを表示
+(void) openModalViewController:(UIViewController*)currentViewController viewController:(UIViewController*) viewController;

//モーダルで開いたヴューをを閉じる
+(void) closeModalViewController:(UIViewController*)currentViewController;

//アラートダイアログ
+(void)showAlert:(UIViewController*)currentViewController title:(NSString*)title message:(NSString*)message ok:(void(^)())ok;

//確認ダイアログ
+(void)showConfirm:(UIViewController*)currentViewController title:(NSString*)title message:(NSString*)message ok:(void(^)())ok cancel:(void(^)())cancel;

@end
