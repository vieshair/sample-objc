//
//  ViewController.m
//  sample
//
//  Created by 古川信行 on 2015/10/16.
//  Copyright © 2015年 vie. All rights reserved.
//

#import "ViewController.h"
#import "RLMUtil.h"
#import "ViewHueController.h"

//VIE ライブラリを読み込む
#import <vie/VieUtil.h>

@interface ViewController (){
    //VIE ライブラリ
    VieUtil *vieUtil;
    
    //イコライザ設定
    BOOL isEqOn;
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //VIEライブラリを初期化
    vieUtil = [[VieUtil alloc] initialize:self];
    
    //SE音をDEFAULTから変更してみる
    //NSString* path = [[NSBundle mainBundle] pathForResource:@"button03b" ofType:@"caf"];
    //[vieUtil setSoundEffectPath:path];
    
    //再生中の曲情報の通知を受け取る
    __weak typeof(self) weakSelf = self;
    [vieUtil setOnNowPlayingItemChanged:^(MPMediaItem *mediaItem) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        [weakSelf onNowPlayingItem:mediaItem];
    }];
    
    //再生時間更新等の通知を受け取る
    [vieUtil setUpdateCurrentItemTime:^(double duration,double current) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf) return;
        [weakSelf onUpdateCurrentItemTime:duration current:current];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//再生中の曲の情報を取得する
-(void) onNowPlayingItem:(MPMediaItem *)mediaItem{
    //DLog(@"onNowPlayingItem");
    
    //曲名
    NSString* title = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
    _lblTitle.text = title;
    
    //アーティスト名
    NSString* artistName = [mediaItem valueForProperty:MPMediaItemPropertyArtist];
    _lblArtist.text = artistName;
    
    // アートワーク（ジャケット写真）
    MPMediaItemArtwork *artwork = [mediaItem valueForProperty:MPMediaItemPropertyArtwork];
    _imgArtwork.image = [artwork imageWithSize:CGSizeMake(80.0, 80.0)];
    
    // 初期 再生時間設定
    float duration = [[mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration] floatValue];
    _lblDuration.text = [NSString stringWithFormat:@"0:00/%@",[VieUtil formatSecToMmdd:duration]];
    
    /*
     // 曲名
     _title = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
     // アルバム名
     _albumTitle = [mediaItem valueForProperty:MPMediaItemPropertyAlbumTitle];
     // アーティスト名
     _artistName = [mediaItem valueForProperty:MPMediaItemPropertyArtist];
     
     // アートワーク（ジャケット写真）
     MPMediaItemArtwork *artwork = [mediaItem valueForProperty:MPMediaItemPropertyArtwork];
     _artworkImage = [artwork imageWithSize:CGSizeMake(80.0, 80.0)];
     
     // 再生時間
     _duration = [[mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration] floatValue];
     */
}

//再生時間更新等の通知を受け取る
-(void) onUpdateCurrentItemTime:(double)duration current:(double) current{
    //DLog(@"onUpdateCurrentItemTime duration:%f current:%f",duration,current);
    
    _lblDuration.text = [NSString stringWithFormat:@"%@/%@",[VieUtil formatSecToMmdd:current],[VieUtil formatSecToMmdd:duration]];
}

//停止
- (IBAction)clickBtnStop:(id)sender{
    [vieUtil stop];
    
    //再生ボタンの背景をPlayに切り替え
    [_btnPlayAndStop setImage:[UIImage imageNamed:@"btnPlay.png"] forState:UIControlStateNormal];
}

- (IBAction)clickBtnPlayAndPause:(id)sender {
    if([vieUtil isPlay] == NO){
        
        //一時停止中だったら再生再開
        if([vieUtil isPause]){
            //再生
            [vieUtil play];
            //再生ボタンの背景をStopに切り替え
            [_btnPlayAndStop setImage:[UIImage imageNamed:@"btnPause.png"] forState:UIControlStateNormal];
        }
        else{
            //メディアピッカーを表示
            [vieUtil showMediaPicker:^(MPMediaItemCollection *mediaItemCollection) {
                DLog(@"メディアピッカー終了");
                if(mediaItemCollection == nil){
                    return;
                }
                
                //音楽再生
                [vieUtil play];
                //再生ボタンの背景をStopに切り替え
                [_btnPlayAndStop setImage:[UIImage imageNamed:@"btnPause.png"] forState:UIControlStateNormal];
            }];
        }
        
    }
    else{
        //再生中だったので一時停止
        [vieUtil pause];
        
        //背景をPlayに切り替え
        [_btnPlayAndStop setImage:[UIImage imageNamed:@"btnPlay.png"] forState:UIControlStateNormal];
    }
}

//前の曲
- (IBAction)clickBtnRewind:(id)sender {
    [vieUtil rewind];
}

//次の曲
- (IBAction)clickBtnForward:(id)sender {
    [vieUtil forward];
}

//各色のボタン
//赤 ボタン
- (IBAction)clickBtnRed:(id)sender {
    [vieUtil sendCommand:VIE_CMD_LED_RED];
    
    //連動中のhueライトに色を設定する
    [self setHueLightColor:VIE_CMD_LED_RED];
}

//緑 ボタン
- (IBAction)clickBtnGreen:(id)sender {
    [vieUtil sendCommand:VIE_CMD_LED_GREEN];
    
    //連動中のhueライトに色を設定する
    [self setHueLightColor:VIE_CMD_LED_GREEN];
}

//青 ボタン
- (IBAction)clickBtnBlue:(id)sender {
    [vieUtil sendCommand:VIE_CMD_LED_BLUE];
    
    //連動中のhueライトに色を設定する
    [self setHueLightColor:VIE_CMD_LED_BLUE];
}

//黄 ボタン
- (IBAction)clickBtnYellow:(id)sender {
    [vieUtil sendCommand:VIE_CMD_LED_YELLOW];
    
    //連動中のhueライトに色を設定する
    [self setHueLightColor:VIE_CMD_LED_YELLOW];
}

//白 ボタン
- (IBAction)clickBtnWhite:(id)sender{
    [vieUtil sendCommand:VIE_CMD_LED_WHITE];
    
    //連動中のhueライトに色を設定する
    [self setHueLightColor:VIE_CMD_LED_WHITE];
}

//クリア
- (IBAction)clickBtnClear:(id)sender {
    [vieUtil sendCommand:VIE_CMD_LED_CLEAR];
    
    //連動中のhueライトに色を設定する
    [self setHueLightColor:VIE_CMD_LED_CLEAR];
}

//モジュールの電源制御
- (IBAction)clickBtnPower:(id)sender{
    //[vieUtil sendCommand:VIE_CMD_POWER_OFF];
}

//設定ボタンクリック時
- (IBAction)clickBtnSetting:(id)sender {
    DLog(@"clickBtnSetting");
    
    //モーダルでhue設定画面を表示
    ViewHueController* viewController = [[CommonUtil storyBoard] instantiateViewControllerWithIdentifier:@"ViewHueController"];
    viewController.vieUtil = vieUtil;
    [CommonUtil openModalViewController:self viewController:viewController];
}

//イコライザをON,OFFする
- (IBAction)clickBtnEq:(id)sender {
    //EQを設定
    if(isEqOn == YES){
        [CommonUtil showAlert:self title:@"イコライザ設定" message:@"OFF" ok:^{
            //イコライザをOFFにする
            [vieUtil setEqualizerType:VIE_EQ_OFF];
            isEqOn = NO;
        }];
    }
    else{
        //イコライザを設定する
        [CommonUtil showAlert:self title:@"イコライザ設定" message:@"DEFAULT" ok:^{
            //イコライザをOFFにする
            [vieUtil setEqualizerType:VIE_EQ_DEFAULT];
            isEqOn = YES;
        }];
    }
}

/** 連動設定している hueのライト色を変更する
 *
 */
-(void) setHueLightColor:(kVieCommandType) color{
    NSArray* allHueLight = [RLMUtil allHueBridge];
    if((allHueLight != nil) && ([allHueLight count] > 0)){
        //ブリッジのIPアドレスを取得
        HueIpAddress* hueIpAddress = [[RLMUtil allHueBridge] objectAtIndex:0];
        NSArray* allHueLight = [RLMUtil allHueLight];
        if((allHueLight != nil) && ([allHueLight count] > 0)){
            //HueLightState
            NSMutableArray* hueLightStateList = [NSMutableArray array];
            for(HueLightObject* obj in allHueLight){
                HueLightState* hueLightState = [[HueLightState alloc] init];
                //ライトのID
                hueLightState.lightId = obj.hueLightId;
                if(obj.vieLink == YES){
                    //電源のON,OFF
                    hueLightState.on = YES;
                    [vieUtil hueSetLightsColor:hueLightState type:color];
                    [hueLightStateList addObject:hueLightState];
                }
            }
            //hueに繋がったライトの色を変更する処理
            [vieUtil hueSetLightsState:hueIpAddress.internalipaddress userName:VIE_HUE_USERNAME hueLightStateList:hueLightStateList callback:^  (NSDictionary *result) {
                DLog(@"result:%@",result);
            }];
        }
    }
}

@end
