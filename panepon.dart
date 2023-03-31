void main() {
  view(init);
  order(3);
}

// 表示用の初期状態を入力
final Map init = {
  'a1': '-',
  'b1': '-',
  'c1': '-',
  'd1': '-',
  'e1': '-',
  'f1': '-',
  'a2': '-',
  'b2': '-',
  'c2': '-',
  'd2': '-',
  'e2': '-',
  'f2': '-',
  'a3': '-',
  'b3': '-',
  'c3': '-',
  'd3': '-',
  'e3': '-',
  'f3': '-',
  'a4': '-',
  'b4': '-',
  'c4': '-',
  'd4': '-',
  'e4': '-',
  'f4': '-',
  'a5': '-',
  'b5': '-',
  'c5': '-',
  'd5': '-',
  'e5': '-',
  'f5': '-',
  'a6': '-',
  'b6': '-',
  'c6': '-',
  'd6': 'g',
  'e6': '-',
  'f6': '-',
  'a7': '-',
  'b7': '-',
  'c7': '-',
  'd7': 'y',
  'e7': '-',
  'f7': '-',
  'a8': '-',
  'b8': '-',
  'c8': '-',
  'd8': 'l',
  'e8': '-',
  'f8': '-',
  'a9': '-',
  'b9': 'g',
  'c9': 'g',
  'd9': 'l',
  'e9': '-',
  'f9': '-',
  'a10': '-',
  'b10': 'l',
  'c10': 'g',
  'd10': 'g',
  'e10': '-',
  'f10': '-',
  'a11': '-',
  'b11': 'g',
  'c11': 'l',
  'd11': 'l',
  'e11': '-',
  'f11': '-',
  'a12': '-',
  'b12': 'g',
  'c12': 'y',
  'd12': 'y',
  'e12': '-',
  'f12': '-',
};

// 渡されたパネルデータを表示する
void view(panel) {
  for (int i = 1; i <= 12; i++) {
    print(panel['a$i'] +
        panel['b$i'] +
        panel['c$i'] +
        panel['d$i'] +
        panel['e$i'] +
        panel['f$i']);
  }
  print('');
}

// パネルが消える一連の動作をsequenceにまとめてある。
List abcdef = ['null', 'a', 'b', 'c', 'd', 'e', 'f', 'null'];
int finish = 0;

void sequence(panel) {
  finish = 1;
  while (finish != 0) {
    finish = 0;
    check(panel, abcdef);
    delete(panel, abcdef);
    fall(panel, abcdef);
    check(panel, abcdef);
  }
}

// 消える候補のパネルを2つに増やしてに置き換える
// 重複して消える候補に当たる場合は最初の二文字のみを残すことで二文字を維持する
void check(panel, abc) {
  for (int v = 1; v <= 12; v++) {
    for (int h = 1; h <= 6; h++) {
      // 横軸の消滅チェック
      if (h > 1 &&
          h < 6 &&
          panel['${abc[h]}$v'] != '-' &&
          panel['${abc[h]}$v']!
                  .contains(panel['${abc[h - 1]}$v']!.substring(0, 1)) &
              panel['${abc[h]}$v']!
                  .contains(panel['${abc[h + 1]}$v']!.substring(0, 1))) {
        String destination =
            (panel['${abc[h]}$v']! + panel['${abc[h]}$v']!).substring(0, 2);
        panel['${abc[h + 1]}$v'] = destination;
        panel['${abc[h]}$v'] = destination;
        panel['${abc[h - 1]}$v'] = destination;
        finish++;
      }
      // 縦軸の消滅チェック
      if (v > 1 &&
          v < 12 &&
          panel['${abc[h]}$v'] != '-' &&
          panel['${abc[h]}$v']!
              .contains(panel['${abc[h]}${v - 1}']!.substring(0, 1)) &&
          panel['${abc[h]}$v']!
              .contains(panel['${abc[h]}${v + 1}']!.substring(0, 1))) {
        String destination =
            (panel['${abc[h]}$v']! + panel['${abc[h]}$v']!).substring(0, 2);
        panel['${abc[h]}${v - 1}'] = destination;
        panel['${abc[h]}$v'] = destination;
        panel['${abc[h]}${v + 1}'] = destination;
        finish++;
      }
    }
  }
}

// checkで二文字になっているものを0に置き換える
void delete(panel, abc) {
  for (int v = 1; v <= 12; v++) {
    for (int h = 1; h <= 6; h++) {
      if (panel['${abc[h]}$v']!.length > 1) {
        panel['${abc[h]}$v'] = panel['${abc[h]}$v']!.substring(0, 1);
        panel['${abc[h]}$v'] = '0';
      }
    }
  }
}

// 浮いたパネルを地面に落とす関数
void fall(panel, abc) {
  while (panel.containsValue('0')) {
    for (int v = 12; v >= 2; v--) {
      for (int h = 1; h <= 6; h++) {
        if (panel['${abc[h]}$v'] == '0') {
          if (panel['${abc[h]}${v - 1}'] == '-') {
            panel['${abc[h]}$v'] = '-';
          } else {
            panel['${abc[h]}$v'] = panel['${abc[h]}${v - 1}']!;
            panel['${abc[h]}${v - 1}'] = '0';
          }
        }
      }
    }
  }
}

// 座標を指定してパネルを移動させる
// 座標は左側のマスを指定すること
void manualChange(String coordinate, panel, abc) {
  String alph = coordinate.substring(0, 1); // abcdef
  if (alph.contains(RegExp(r'[abcde]'))) {
    String num = coordinate.substring(1);
    int index = abcdef.indexOf(alph);
    String left = panel['${abc[index]}$num']!;
    String right = panel['${abc[index + 1]}$num']!;
    if (right == '-') {
      panel['${abc[index]}$num'] = '0';
    } else {
      panel['${abc[index]}$num'] = right;
    }
    if (left == '-') {
      panel['${abc[index + 1]}$num'] = '0';
    } else {
      panel['${abc[index + 1]}$num'] = left;
    }

    int nextNum = int.parse(num);
    int loopCount = 0;
    while (panel['${abc[index]}${nextNum + loopCount}'] != '-' &&
        panel['${abc[index]}${nextNum + loopCount + 1}'] == '-') {
      panel['${abc[index]}${nextNum + loopCount + 1}'] = '0';
      loopCount++;
    }
    loopCount = 0;
    while (panel['${abc[index + 1]}${nextNum + loopCount}'] != '-' &&
        panel['${abc[index + 1]}${nextNum + loopCount + 1}'] == '-') {
      panel['${abc[index + 1]}${nextNum + loopCount + 1}'] = '0';
      loopCount++;
    }
    loopCount = 0;
  }
}

// 以下、自動で解答を導き出すプログラム
// 総当たり形式で確認する
// 全て消えたら手順を出力する
// 動かす回数を指定する(1〜4)

List makeCoodinates(List abc) {
  List a = [];
  for (int v = 2; v <= 12; v++) {
    for (int h = 1; h <= 5; h++) {
      String coordinate = abc[h] + v.toString();
      a.add(coordinate);
    }
  }
  return a;
}

void order(int operation) {
  List first = makeCoodinates(abcdef);
  List second = makeCoodinates(abcdef);
  List third = makeCoodinates(abcdef);
  List forth = makeCoodinates(abcdef);
  firstloop:
  for (int i = 0; i < 55; i++) {
    final Map initPanels = {
      'a1': '-',
      'b1': '-',
      'c1': '-',
      'd1': '-',
      'e1': '-',
      'f1': '-',
      'a2': '-',
      'b2': '-',
      'c2': '-',
      'd2': '-',
      'e2': '-',
      'f2': '-',
      'a3': '-',
      'b3': '-',
      'c3': '-',
      'd3': '-',
      'e3': '-',
      'f3': '-',
      'a4': '-',
      'b4': '-',
      'c4': '-',
      'd4': '-',
      'e4': '-',
      'f4': '-',
      'a5': '-',
      'b5': '-',
      'c5': '-',
      'd5': '-',
      'e5': '-',
      'f5': '-',
      'a6': '-',
      'b6': '-',
      'c6': '-',
      'd6': 'g',
      'e6': '-',
      'f6': '-',
      'a7': '-',
      'b7': '-',
      'c7': '-',
      'd7': 'y',
      'e7': '-',
      'f7': '-',
      'a8': '-',
      'b8': '-',
      'c8': '-',
      'd8': 'l',
      'e8': '-',
      'f8': '-',
      'a9': '-',
      'b9': 'g',
      'c9': 'g',
      'd9': 'l',
      'e9': '-',
      'f9': '-',
      'a10': '-',
      'b10': 'l',
      'c10': 'g',
      'd10': 'g',
      'e10': '-',
      'f10': '-',
      'a11': '-',
      'b11': 'g',
      'c11': 'l',
      'd11': 'l',
      'e11': '-',
      'f11': '-',
      'a12': '-',
      'b12': 'g',
      'c12': 'y',
      'd12': 'y',
      'e12': '-',
      'f12': '-',
    };
    manualChange(first[i], initPanels, abcdef);
    sequence(initPanels);
    if (initPanels.values.every((element) => element == '-')) {
      print('結果');
      print(first[i]);
      break firstloop;
    }
    secondloop:
    for (int ii = 0; ii < 55; ii++) {
      if (operation < 2) break secondloop;
      final Map initPanels = {
        'a1': '-',
        'b1': '-',
        'c1': '-',
        'd1': '-',
        'e1': '-',
        'f1': '-',
        'a2': '-',
        'b2': '-',
        'c2': '-',
        'd2': '-',
        'e2': '-',
        'f2': '-',
        'a3': '-',
        'b3': '-',
        'c3': '-',
        'd3': '-',
        'e3': '-',
        'f3': '-',
        'a4': '-',
        'b4': '-',
        'c4': '-',
        'd4': '-',
        'e4': '-',
        'f4': '-',
        'a5': '-',
        'b5': '-',
        'c5': '-',
        'd5': '-',
        'e5': '-',
        'f5': '-',
        'a6': '-',
        'b6': '-',
        'c6': '-',
        'd6': 'g',
        'e6': '-',
        'f6': '-',
        'a7': '-',
        'b7': '-',
        'c7': '-',
        'd7': 'y',
        'e7': '-',
        'f7': '-',
        'a8': '-',
        'b8': '-',
        'c8': '-',
        'd8': 'l',
        'e8': '-',
        'f8': '-',
        'a9': '-',
        'b9': 'g',
        'c9': 'g',
        'd9': 'l',
        'e9': '-',
        'f9': '-',
        'a10': '-',
        'b10': 'l',
        'c10': 'g',
        'd10': 'g',
        'e10': '-',
        'f10': '-',
        'a11': '-',
        'b11': 'g',
        'c11': 'l',
        'd11': 'l',
        'e11': '-',
        'f11': '-',
        'a12': '-',
        'b12': 'g',
        'c12': 'y',
        'd12': 'y',
        'e12': '-',
        'f12': '-',
      };
      manualChange(first[i], initPanels, abcdef);
      sequence(initPanels);
      manualChange(second[ii], initPanels, abcdef);
      sequence(initPanels);
      if (initPanels.values.every((element) => element == '-')) {
        print('結果');
        print(first[i]);
        print(second[ii]);
        break firstloop;
      }
      thirdloop:
      for (int iii = 0; iii < 55; iii++) {
        if (operation < 3) break thirdloop;
        final Map initPanels = {
          'a1': '-',
          'b1': '-',
          'c1': '-',
          'd1': '-',
          'e1': '-',
          'f1': '-',
          'a2': '-',
          'b2': '-',
          'c2': '-',
          'd2': '-',
          'e2': '-',
          'f2': '-',
          'a3': '-',
          'b3': '-',
          'c3': '-',
          'd3': '-',
          'e3': '-',
          'f3': '-',
          'a4': '-',
          'b4': '-',
          'c4': '-',
          'd4': '-',
          'e4': '-',
          'f4': '-',
          'a5': '-',
          'b5': '-',
          'c5': '-',
          'd5': '-',
          'e5': '-',
          'f5': '-',
          'a6': '-',
          'b6': '-',
          'c6': '-',
          'd6': 'g',
          'e6': '-',
          'f6': '-',
          'a7': '-',
          'b7': '-',
          'c7': '-',
          'd7': 'y',
          'e7': '-',
          'f7': '-',
          'a8': '-',
          'b8': '-',
          'c8': '-',
          'd8': 'l',
          'e8': '-',
          'f8': '-',
          'a9': '-',
          'b9': 'g',
          'c9': 'g',
          'd9': 'l',
          'e9': '-',
          'f9': '-',
          'a10': '-',
          'b10': 'l',
          'c10': 'g',
          'd10': 'g',
          'e10': '-',
          'f10': '-',
          'a11': '-',
          'b11': 'g',
          'c11': 'l',
          'd11': 'l',
          'e11': '-',
          'f11': '-',
          'a12': '-',
          'b12': 'g',
          'c12': 'y',
          'd12': 'y',
          'e12': '-',
          'f12': '-',
        };
        manualChange(first[i], initPanels, abcdef);
        sequence(initPanels);
        manualChange(second[ii], initPanels, abcdef);
        sequence(initPanels);
        manualChange(third[iii], initPanels, abcdef);
        sequence(initPanels);
        print('$i$ii$iii');
        if (initPanels.values.every((element) => element == '-')) {
          print('結果');
          print(first[i]);
          print(second[ii]);
          print(third[iii]);
          break firstloop;
        }
        forthloop:
        for (int iiii = 0; iiii < 55; iiii++) {
          if (operation < 4) break forthloop;
          final Map initPanels = {
            'a1': '-',
            'b1': '-',
            'c1': '-',
            'd1': '-',
            'e1': '-',
            'f1': '-',
            'a2': '-',
            'b2': '-',
            'c2': '-',
            'd2': '-',
            'e2': '-',
            'f2': '-',
            'a3': '-',
            'b3': '-',
            'c3': '-',
            'd3': '-',
            'e3': '-',
            'f3': '-',
            'a4': '-',
            'b4': '-',
            'c4': '-',
            'd4': '-',
            'e4': '-',
            'f4': '-',
            'a5': '-',
            'b5': '-',
            'c5': '-',
            'd5': '-',
            'e5': '-',
            'f5': '-',
            'a6': '-',
            'b6': '-',
            'c6': '-',
            'd6': 'g',
            'e6': '-',
            'f6': '-',
            'a7': '-',
            'b7': '-',
            'c7': '-',
            'd7': 'y',
            'e7': '-',
            'f7': '-',
            'a8': '-',
            'b8': '-',
            'c8': '-',
            'd8': 'l',
            'e8': '-',
            'f8': '-',
            'a9': '-',
            'b9': 'g',
            'c9': 'g',
            'd9': 'l',
            'e9': '-',
            'f9': '-',
            'a10': '-',
            'b10': 'l',
            'c10': 'g',
            'd10': 'g',
            'e10': '-',
            'f10': '-',
            'a11': '-',
            'b11': 'g',
            'c11': 'l',
            'd11': 'l',
            'e11': '-',
            'f11': '-',
            'a12': '-',
            'b12': 'g',
            'c12': 'y',
            'd12': 'y',
            'e12': '-',
            'f12': '-',
          };
          manualChange(first[i], initPanels, abcdef);
          sequence(initPanels);
          manualChange(second[ii], initPanels, abcdef);
          sequence(initPanels);
          manualChange(third[iii], initPanels, abcdef);
          sequence(initPanels);
          manualChange(forth[iiii], initPanels, abcdef);
          sequence(initPanels);

          if (initPanels.values.every((element) => element == '-')) {
            print('結果');
            print(first[i]);
            print(second[ii]);
            print(third[iii]);
            print(forth[iiii]);
            break firstloop;
          }
        }
      }
    }
  }
}
