//
//  ViewController.h
//  sample
//
//  Created by 古川信行 on 2015/10/16.
//  Copyright © 2015年 vie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtil.h"

@interface ViewController : UIViewController

//再生,停止 ボタン
@property (weak, nonatomic) IBOutlet UIButton *btnPlayAndStop;

//アートワーク表示
@property (weak, nonatomic) IBOutlet UIImageView *imgArtwork;
//タイトル
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

//アーティスト名
@property (weak, nonatomic) IBOutlet UILabel *lblArtist;

//再生時間
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;

//再生,一時停止
- (IBAction)clickBtnPlayAndPause:(id)sender;

//停止
- (IBAction)clickBtnStop:(id)sender;

//前の曲
- (IBAction)clickBtnRewind:(id)sender;

//次の曲
- (IBAction)clickBtnForward:(id)sender;

//設定
- (IBAction)clickBtnSetting:(id)sender;

//イコライザ設定画面を表示
- (IBAction)clickBtnEq:(id)sender;

//各色のボタン
- (IBAction)clickBtnRed:(id)sender;
- (IBAction)clickBtnGreen:(id)sender;
- (IBAction)clickBtnBlue:(id)sender;
- (IBAction)clickBtnYellow:(id)sender;
- (IBAction)clickBtnWhite:(id)sender;
- (IBAction)clickBtnClear:(id)sender;

- (IBAction)clickBtnPower:(id)sender;

@end

