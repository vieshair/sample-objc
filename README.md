# VIEとは?
モノをもってコトをなす [OMOTENASY LLC.](http://www.omotenasy.net) が開発中の音楽系デバイスです。    
[VIE SHAIR](vie.style)   
![VIE SHAIR](https://dl.dropboxusercontent.com/u/6674841/vie/docs/github/vie_device0.jpg)

## 新規プロジェクトへの VIE フレームワーク導入手順
xcodeで 新規作成したプロジェクト への vie.framework の導入手順を説明します。

### 用意するもの
[Github](https://github.com/vieshare/sample-objc)のリポジトリをcloneしてください。

```
$ git clone git@github.com:vieshare/sample-objc.git
```

### xcode で新規プロジェクトを作成
Single View Application 等のプロジェクトを作成してください。

![Single View Application](https://dl.dropboxusercontent.com/u/6674841/vie/docs/github/0.png)

### vie.frameworkをプロジェクトに追加
clone したディレクトリにある vie.framework を 新規作成したプロジェクトのディレクトリにコピーしてください。  
その後 "Embedded Binaries" 欄の + を押して "Add Other..."で vie.framework を指定してください。　　
自動で"Linkd Framework and Libraries" 欄にも vie.framework が追加されます。

![Embedded Binaries](https://dl.dropboxusercontent.com/u/6674841/vie/docs/github/1.png)

### その他必要なFrameworkをプロジェクトに追加
"Linkd Framework and Libraries" 欄の + を押して以下のFrameworkを追加してください。  
AVFoundation.framework  
MediaPlayer.framework  
UIKit.framework  

![Linkd Framework and Libraries](https://dl.dropboxusercontent.com/u/6674841/vie/docs/github/2.png)


### ViewController に vieの色を変更するSampleコードを追加
アプリを起動するとBluetoothで接続中のVIEデバイスのLEDを赤に設定するコード

``` 
//VIE ライブラリを読み込む
#import <vie/VieUtil.h>

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //VIEライブラリを初期化
    VieUtil *vieUtil = [[VieUtil alloc] initialize:self];
    //VIEデバイスのLEDを 赤に設定する
    [vieUtil sendCommand:VIE_CMD_LED_RED];
}

```

### vie.framework の その他機能について
以下の様な機能が vie.framework に実装されています。  
clone したディレクトリ内の docs ディレクトリと sampleプロジェクト を参考にしてください。  
- 音楽再生,一時停止,停止  
- [PHILIPS Hue](http://www2.meethue.com/ja-jp/) 検索(初期設定),ランプ色変更  
- オリジナルのイコライザ作成  

----
### 質問 等
ユーザーコミュニティとして [issues(投稿)](https://github.com/vieshare/sample-objc/issues)を利用しています。  
使っていく中での不明点、Tips、利用例などを投稿してください。   
不明点や不具合等については回答保証はありませんが、出来る限り [tfuru](https://github.com/tfuru) が回答致します。   


