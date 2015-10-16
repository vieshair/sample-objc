//
//  ViewHueController.m
//  vieapp
//
//  Created by 古川信行 on 2015/10/03.
//  Copyright © 2015年 古川信行. All rights reserved.
//

#import "ViewHueController.h"
#import "RLMUtil.h"

@interface ViewHueController ()<UITableViewDelegate, UITableViewDataSource>{
    //ライト一覧
    NSMutableDictionary *lights;
}

@end

@implementation ViewHueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //テーブルにデリゲートを設定
    _tableViewLights.delegate = self;
    _tableViewLights.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSArray* allHueBridge = [RLMUtil allHueBridge];
    if(allHueBridge.count > 0 ){
        //一覧を描画
        [self showLightList];
        return;
    }
}


/** 閉じるボタンを押した時
 */
- (IBAction)clickBtnClose:(id)sender {
    [CommonUtil closeModalViewController:self];
}

/** リセットボタンを押した時
 */
- (IBAction)clickBtnReset:(id)sender {
    [CommonUtil showConfirm:self title:@"確認" message:@"保存済みのhueブリッジの内容を削除します。よろしいですか？" ok:^{
        //ローカルDBに記録済みの hue ブリッジの内容を削除する
        [RLMUtil resetHueBridge];
        [RLMUtil resetHueBridge];
        
        [self showLightList];
        
        //一覧を非表示に
        _viewLightContainer.hidden = YES;
        
    } cancel:^{
        //キャンセル
    }];
}


//hue ブリッジ一覧を取得する
- (IBAction)clickBtnHueBridgeSearch:(id)sender {
    
    NSArray* allHueBridge = [RLMUtil allHueBridge];
    if((allHueBridge != nil) && (allHueBridge.count > 0)){
        //一覧を描画
        [self showLightList];
        return;
    }
    
    [_vieUtil hueGetBridgeInternalIpAddress:^(NSArray *IpAddress) {
        
        if(IpAddress.count > 0){
            //見つかったデバイスに接続してユーザー設定をする
            //TODO: 複数ブリッジに対応させる場合は ここの処理を変更する
            HueIpAddress* obj = [IpAddress objectAtIndex:0];
            DLog(@"obj internalipaddress:%@",obj.internalipaddress);
            
            
            HueIpAddressObject* hueObj = [[[HueIpAddressObject alloc] init] initialize:obj.hueId internalipaddress:obj.internalipaddress];

            
            //hueユーザーを登録する
            NSString* bridgeIp = obj.internalipaddress;
            [CommonUtil showAlert:self title:@"確認" message:@"ブリッジボタンを押してからOKを押してください。" ok:^{
                //DLog(@"OK");
                [_vieUtil hueCreateUser:bridgeIp userName:VIE_HUE_USERNAME callback:^(NSDictionary *result) {
                    //DLog(@"result:%@",result);
                    //TODO: 結果をアラート表示
                    NSDictionary* resultError = [result objectForKey:@"error"];
                    if(resultError == nil){
                        //登録に成功
                        
                        //ブリッジのIPアドレス等をローカルDBに保存する
                        [RLMUtil saveHueBridge:hueObj];
                        
                        [CommonUtil showAlert:self title:@"成功" message:@"ブリッジ登録に成功しました。" ok:^{
                            DLog(@"OK");
                            
                            //ブリッジに繋がったデバイス一覧を取得する処理を実行
                            [self showLightList];
                        }];
                    }
                    else{
                        //エラー
                        int type = [[resultError objectForKey:@"type"] intValue];
                        NSString* description = [resultError objectForKey:@"description"];
                        NSString* title = [NSString stringWithFormat:@"error type:%d",type];
                        [CommonUtil showAlert:self title:title message:description ok:^{
                            DLog(@"OK");
                        }];
                    }
                }];
            }];
        }
        else{
            //アラーを表示
            [CommonUtil showAlert:self title:@"エラー" message:@"ブリッジが見つかりませんでした。" ok:^{
                DLog(@"OK");
            }];
        }
    }];
}

//ブリッジに繋がったデバイス一覧を表示する
-(void) showLightList {
    //ローカルに保存したライト一覧を取得する
    NSArray* allHueLight = [RLMUtil allHueLight];
    //DLog(@"allHueLight:%@",allHueLight);
    if((allHueLight != nil) && ([allHueLight count] > 0)){
        //既に取得済み
        lights = [NSMutableDictionary dictionary];
        for (HueLightObject* obj in allHueLight) {
            [lights setValue:obj forKey:obj.hueLightId];
        }
        //一覧を表示
        [_tableViewLights reloadData];
        _viewLightContainer.hidden = NO;
        return;
    }
    
    //ローカルDBに保存したブリッジのIPアドレスを取得
    NSArray* allHueBridge = [RLMUtil allHueBridge];
    DLog("allHueBridge:%@",allHueBridge);
    if(allHueBridge.count > 0 ){
        HueIpAddressObject* bridgeObj = [allHueBridge objectAtIndex:0];
        [_vieUtil hueGetLightList:bridgeObj.internalipaddress userName:VIE_HUE_USERNAME callback:^(NSDictionary *result) {
            DLog("result:%@",result);
            if(result == nil){
                [CommonUtil showAlert:self title:@"エラー" message:@"ブリッジに接続されたデバイスが見つかりませんでした。" ok:^{
                    DLog(@"OK");
                }];
                return;
            }
            //ブリッジに繋がっているデバイス一覧を取得に成功
            NSDictionary* tmp = [result objectForKey:@"lights"];
            lights = [NSMutableDictionary dictionary];
            for (id key in [tmp keyEnumerator]) {
                NSDictionary* obj = [tmp objectForKey:key];
                NSString* name = [obj objectForKey:@"name"];
                
                HueLightObject* hueLight = [[[HueLightObject alloc] init] initialize:key name:name];
                [lights setValue:hueLight forKey:key];
                
                //ローカルDBに保存する
                [RLMUtil saveHueLight:hueLight];
            }
            
            //一覧を表示
            [_tableViewLights reloadData];
            _viewLightContainer.hidden = NO;
        }];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

/**
 テーブルに表示するデータ件数を返します。（必須）
 
 @return NSInteger : データ件数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(lights == nil){
        return 0;
    }
    return [lights allKeys].count;
}

/**
 テーブルに表示するセクション（区切り）の件数を返します。（オプション）
 
 @return NSInteger : セクションの数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 テーブルに表示するセルを返します。（必須）
 
 @return UITableViewCell : テーブルセル
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //DLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* key = [[lights allKeys] objectAtIndex:indexPath.row];
    HueLightObject* obj = [lights objectForKey:key];
    //DLog(@"obj:%@",obj);
    
    if(obj.vieLink == YES){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = obj.name;
    
    return cell;
}

//行をタップした時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* key = [[lights allKeys] objectAtIndex:indexPath.row];
    HueLightObject* obj = [lights objectForKey:key];
    DLog(@"obj:%@",obj);
    if (obj.vieLink) {
        [RLMUtil setHueLightVieLink:obj islink:NO];
    }
    else{
        [RLMUtil setHueLightVieLink:obj islink:YES];
    }
    
    [_tableViewLights reloadData];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
