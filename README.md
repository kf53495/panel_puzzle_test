# パネルでポン
## パズルモードの解答自動生成プログラム

### 使い方
　init、initPanelsの中身をそれぞれ同じ初期配置に書き換えます。
 操作回数をorder()のかっこ内に書き入れます。
 ターミナルなどで実行すると座標形式で手順が示されます。
 座標の読み方はオセロと同じで、縦軸を左からabcdef、横軸を上から1,2,3,4...というふうになっています。
 座標は動かす2マスの左側が選択されます。
 例: 左から3番目、上から10番目なら c10
     左から5番目、上から2番目なら e2
     
### 問題点と解決法
・orderメソッドにおいて、for文を連続させる方法以外での実装方法が思いつかなかった。
・dartで書いたため値参照が難しく、同じ処理を繰り返している場所がある。orderメソッド内のmanualChenge、sequenceなどが該当。
上記二点はC+なら値を渡せるようなのでそちらで書き直すことにする。

・本来のゲーム動作ではパネルは3つ揃って地面についていたらその瞬間に消えるが、全てのパネルが地面に落ちきってから消える判定をしている。そのため、本来のゲームと異なる動作をとることがある。
こちらはパズルゲームの動作にほぼ影響がないため、実装は見送る予定である。


### 初期配置を入力するテンプレート
initPanelsの中身を書き換えることで別の問題を解くことができます。
※パネルの表記は1文字で行なってください。
※パネルに'-'と'0'を用いることはできません。


```dart 
final Map initPanels = {
        'a1': '-', 'b1': '-', 'c1': '-', 'd1': '-', 'e1': '-', 'f1': '-',
        'a2': '-', 'b2': '-', 'c2': '-', 'd2': '-', 'e2': '-', 'f2': '-',
        'a3': '-', 'b3': '-', 'c3': 'l', 'd3': '-', 'e3': '-', 'f3': '-',
        'a4': '-', 'b4': '-', 'c4': 'b', 'd4': '-', 'e4': 'p', 'f4': '-',
        'a5': '-', 'b5': '-', 'c5': 'g', 'd5': '-', 'e5': 'b', 'f5': '-',
        'a6': '-', 'b6': '-', 'c6': 'r', 'd6': '-', 'e6': 'g', 'f6': '-',
        'a7': '-', 'b7': '-', 'c7': 'r', 'd7': 'p', 'e7': 'r', 'f7': '-',
        'a8': '-', 'b8': '-', 'c8': 'b', 'd8': 'l', 'e8': 'b', 'f8': '-',
        'a9': '-', 'b9': '-', 'c9': 'g', 'd9': 'b', 'e9': 'p', 'f9': '-',
        'a10': '-', 'b10': '-', 'c10': 'r', 'd10': 'b', 'e10': 'r', 'f10': '-',
        'a11': '-', 'b11': '-', 'c11': 'g', 'd11': 'r', 'e11': 'g', 'f11': '-',
        'a12': '-', 'b12': '-', 'c12': 'l', 'd12': 'g', 'e12': 'r', 'f12': '-',
      };
```
