# VIEとは?
モノをもってコトをなす [OMOTENASY LLC.](http://www.omotenasy.net) が開発中の音楽系デバイスです。    
[VIE SHARE](http://www.omotenasy.net/works/#vie)   
(写真等をここに配置する)

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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //VIEライブラリを初期化
    VieUtil *vieUtil = [[VieUtil alloc] initialize:self];
    //VIEデバイスのLEDを 赤に設定する
    [vieUtil sendCommand:VIE_CMD_LED_RED];
}

```

### vie.frameworkのその他機能について
clone したディレクトリ内の docs ディレクトリと sampleプロジェクトを参考にしてください。
