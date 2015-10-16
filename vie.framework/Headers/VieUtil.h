//
//  VieDevice.h
//  vie
//
//  Created by 古川信行 on 2015/07/01.
//  Copyright (c) 2015年 古川信行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "HueIpAddress.h"
#import "HueLightState.h"

#ifndef VieUtil_Header
#define VieUtil_Header

//! Project version number for sdk.
FOUNDATION_EXPORT double sdkVersionNumber;

//! Project version string for sdk.
FOUNDATION_EXPORT const unsigned char sdkVersionString[];

/**
 * VIEコマンド文字列の列挙型
 *
 */
typedef NS_ENUM(NSUInteger,kVieCommandType){
    VIE_CMD_LED_RED,
    VIE_CMD_LED_GREEN,
    VIE_CMD_LED_BLUE,
    VIE_CMD_LED_YELLOW,
    VIE_CMD_LED_WHITE,
    VIE_CMD_LED_CLEAR,
    VIE_CMD_LED_EFFECT1,/* 未実装 */
    VIE_CMD_POWER_OFF
};

/**
 * VIE イコライザ タイプ
 *
 */
typedef NS_ENUM(NSInteger,kVieEqualizerType){
    VIE_EQ_OFF,
    VIE_EQ_DEFAULT
};

/**
 * Vieデバイスを操作する為のクラス
 * @since 1.0
 *
 */
@interface VieUtil : NSObject


/**
 * 秒を MM:DD フォーマット文字列に変換
 *
 * @param sec 秒
 * @return MM:DD フォーマット文字列
 */
+(NSString*) formatSecToMmdd:(double) sec;

/**
 * VieUtil オブジェクトを 初期化
 *
 * @param view 親VIEW
 * @return 初期化した VieUtil オブジェクト
 */
-(id) initialize:(id) view;

/**
 * コマンド データ送信
 *
 * @param c コマンドタイプ
 *
 */
- (void) sendCommand:(kVieCommandType) c;

/**
 * コマンド データ送信
 *
 * @param c コマンドタイプ
 * @param retry リトライ回数
 *
 */
- (void) sendCommand:(kVieCommandType) c retry:(int) n;


/**
 * メディアビッカーを表示
 *
 * @param callback メディアピッカー実行結果を返すBlocks
 *
 */
-(void) showMediaPicker:(void(^)(MPMediaItemCollection *mediaItemCollection)) callback;

/**
 * 曲変更時の通知先を設定
 *
 * @param callback 曲が変更された事を通知する先のBlocks
 *
 */
-(void) setOnNowPlayingItemChanged:(void(^)(MPMediaItem *mediaItem)) callback;

/**
 * 再生時間更新用の通知先を設定する
 *
 * @param callback 再生時間更新の通知先のBlocks
 *
 */
-(void) setUpdateCurrentItemTime:(void(^)(double duration,double current)) callback;

/**
 * 再生中かのステータス取得
 *
 * @return 再生中の場合 YES を返す
 */
-(BOOL) isPlay;

/**
 * 一時停止中かのステータスを取得
 *
 * @return 一時停止中の場合 YES を返す
 */
-(BOOL) isPause;

/**
 * 曲を再生する
 *
 */
-(void) play;

/**
 * 曲を一時停止
 *
 */
-(void) pause;

/**
 * 曲を停止
 *
 */
-(void) stop;

/**
 * 前の曲を指定
 *
 */
-(void) rewind;

/**
 * 次の曲を指定
 *
 */
-(void) forward;

/**
 * ボリューム 調整
 * @param v ボリューム 0.0 〜 1.0
 *
 */
-(void) volume:(float) v;

/**
 * SE用のファイルのリソースパスを指定する
 *
 * @param path リソース内のSEファイル(caf形式)のパスを設定する
 *
 */
-(void) setSoundEffectPath:(NSString*) path;

/**
 * イコライザプリセットの設定
 *
 * @param type イコライザプリセットの種類
 *
 */
-(void) setEqualizerType:(kVieEqualizerType) type;


/** hueブリッジの IPアドレスを調べる
 * @param callback IPアドレスの取得結果を返す
 */
-(void) hueGetBridgeInternalIpAddress:(void(^)(NSArray* IpAddress )) callback;

/** hue APIユーザを作成
 *
 * @param ipAddress HueブリッジのIPアドレス
 * @param userName  作成するユーザー名
 * @param callback  ユーザー作成結果を返す
 *
 */
-(void) hueCreateUser:(NSString*)ipAddress userName:(NSString*) userName callback:(void(^)(NSDictionary* result)) callback;

/** hueブリッジに繋がっているデバイス一覧を取得する
 *
 * @param ipAddress hueブリッジのIPアドレス
 * @param userName 操作するAPIユーザー
 * @param callback  hueブリッジに繋がっている デバイス一覧
 *
 */
-(void) hueGetLightList:(NSString*)ipAddress userName:(NSString*) userName callback:(void(^)(NSDictionary* result)) callback;


/** hueデバイスの設定を変更する
 *
 * @param ipAddress hueブリッジのIPアドレス
 * @param userName 操作するAPIユーザー
 * @param hueLightStateList 操作するデバイスの一覧
 *
 * @param callback  操作結果
 *
 */
-(void) hueSetLightsState:(NSString*)ipAddress userName:(NSString*) userName hueLightStateList:(NSArray*) hueLightStateList callback:(void(^)(NSDictionary* result)) callback;


/** hueの色を設定する
 * @param hueLightState 色を設定するhue
 * @param type VIE色設定
 */
-(void) hueSetLightsColor:(HueLightState*)hueLightState type:(kVieCommandType)type;


/** hueの色を設定する
 * @param hueLightState 色を設定するhue
 * @param color 設定したいUIColor
 */
-(void) hueSetLightsColor:(HueLightState*)hueLightState color:(UIColor*)c;

@end

#endif
