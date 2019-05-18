import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Input Sample',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  // テキストフィールドを管理するコントローラを作成
  // 入力された内容をこのコントローラを使用して取り出します。
  final myController = TextEditingController();

  // 適当なリスト用データ
  List<Map<String, dynamic>> items = [
    { "id" : 1,  "content" : "Content 1" },
    { "id" : 2,  "content" : "Content 2" },
    { "id" : 3,  "content" : "Content 3" }
  ];

  //　上記リスト用IDカウンター
  int _counter = 3;

  //　追加ボタンが押されたときに実行する関数
  void _addItem(String inputtext) {
    setState(() {
      _counter++;
      items.add({ "id": _counter, "content": inputtext});
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Input Sample'),
      ),
      body: Container (
         child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: myController,
              ),
            ),
            Expanded(
              child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
              final item = items[index];
            
              return new Card(
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Text(item["id"].toString() + " : " + item["content"]),
                ),
              );
            }),
            ),
          ]),
        ),
        // テキストフィールド送信用ボタン
        floatingActionButton: FloatingActionButton(
        // onPressedでボタンが押された時の動作を渡す
        onPressed: () {
          // myController.text で入力されたテキストフィールドの内容を取得
          _addItem(myController.text);

          // テキストフィールドの内容をクリアする
          myController.clear();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
