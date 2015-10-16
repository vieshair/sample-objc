//
//  ViewHueController.h
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import <UIKit/UIKit.h>

//VIE ライブラリを読み込む
#import <vie/VieUtil.h>

#import "CommonUtil.h"

@interface ViewHueController : UIViewController

//VIEライブラリ
@property (retain) VieUtil* vieUtil;

//hueデバイス一覧コンテナビュー
@property (weak, nonatomic) IBOutlet UIView *viewLightContainer;

//hueデバイス一覧
@property (weak, nonatomic) IBOutlet UITableView *tableViewLights;

/** Hueブリッジをを探すボタン
*
*/
- (IBAction)clickBtnHueBridgeSearch:(id)sender;

/** 閉じるボタン タップ時
 *
 */
- (IBAction)clickBtnClose:(id)sender;

/** リセットボタン タップ時
 *
 */
- (IBAction)clickBtnReset:(id)sender;

@end
