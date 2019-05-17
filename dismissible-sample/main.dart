
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DismissibleSample());
}

class DismissibleSample extends StatefulWidget {
  DismissibleSample({Key key}) : super(key: key);

  @override
  DismissibleSampleState createState() {
    return DismissibleSampleState();
  }
}

class DismissibleSampleState extends State<DismissibleSample>{

  final List<Map<String, dynamic>> items = [
    { "title" : "Title A",  "content" : "Content 1" },
    { "title" : "Title B",  "content" : "Content 2" },
    { "title" : "Title C",  "content" : "Content 3" }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dismissible Sample'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            
            return Dismissible(
              // KeyはFlutterが要素を一意に特定できるようにするための値を設定する。
              key: Key(item["title"]),

              // onDismissedの中にスワイプされた時の動作を定義する。
              // directionにはスワイプの方向が入るため、方向によって処理を分けることができる。
              onDismissed: (direction) {
                setState(() {
                  // スワイプされた要素をデータから削除する
                  items.removeAt(index);
                });
                // スワイプ方向がendToStart（画面左から右）の場合の処理
                if (direction == DismissDirection.endToStart) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("削除しました"))
                  );
                // スワイプ方向がstartToEnd（画面右から左）の場合の処理  
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("登録しました"))
                  );
                }
              },
              // スワイプ方向がendToStart（画面左から右）の場合のバックグラウンドの設定
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.greenAccent[700],
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child:  Icon(Icons.thumb_up, color: Colors.white)
                ),
              ),

              // スワイプ方向がstartToEnd（画面右から左）の場合のバックグラウンドの設定
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Colors.orangeAccent[200],
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                  child:  Icon(Icons.thumb_up, color: Colors.white),
                ),
              ),

              // ListViewの各要素の定義
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Text(item["title"] + " : " + item["content"]),
                ),
              ),
            );
          }),
        ),
      );
    }
  }
