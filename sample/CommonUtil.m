//
//  CommonUtil.m
//  BeaconLettuce
//
//  Created by 古川信行 on 2015/08/11.
//  Copyright (c) 2015年 古川 信行. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

//Storyboardを取得
+(UIStoryboard*) storyBoard{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyBoard;
}


//モーダルでヴューを表示
+(void) openModalViewController:(UIViewController*)currentViewController viewControllerName:(NSString*) viewControllerName{
    UIViewController* viewController = [[self storyBoard] instantiateViewControllerWithIdentifier:viewControllerName];
    [self openModalViewController:currentViewController viewController:viewController];
}

//モーダルでヴューを表示
+(void) openModalViewController:(UIViewController*)currentViewController viewController:(UIViewController*) viewController{
    [currentViewController presentViewController:viewController animated:YES completion:nil];
}

//モーダルで開いたヴューをを閉じる
+(void) closeModalViewController:(UIViewController*)currentViewController{
    [currentViewController dismissViewControllerAnimated:YES completion:nil];
}

//アラートダイアログ
+(void)showAlert:(UIViewController*)currentViewController title:(NSString*)title message:(NSString*)message ok:(void(^)())ok{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // OK
        ok();
    }]];
    
    [currentViewController presentViewController:alertController animated:YES completion:nil];
}

//確認ダイアログ
+(void)showConfirm:(UIViewController*)currentViewController title:(NSString*)title message:(NSString*)message ok:(void(^)())ok cancel:(void(^)())cancel{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancel
        cancel();
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // OK
        ok();
    }]];

    [currentViewController presentViewController:alertController animated:YES completion:nil];

}

@end
