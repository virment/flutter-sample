import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  
  // Formウィジェット内の各フォームを識別するためのキーを設定
  final _formKey = GlobalKey<FormState>();

  // フォーカス管理用のFocusNode
  final namefocus = FocusNode();
  final agefocus = FocusNode();

  // デモ用の適当な変数
  var _yourAge = 0;
  var _yourName = '';

 // 名前更新用メソッド
  void _updateName(String name) {
    setState(() {
      _yourName = name;
    });
  }
  // 年齢更新用メソッド
   void _updateAge(int age) {
    setState(() {
      _yourAge = age;
    });
  }

 @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          nameFormField(context),
          ageFormField(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              // 送信ボタンクリック時の処理
              onPressed: () {
                // バリデーションチェック
                if (_formKey.currentState.validate()) {
                  // 各フォームのonSavedに記述した処理を実行
                  // このsave()を呼び出さないと、onSavedは実行されないので注意
                  _formKey.currentState.save();
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('更新しました。')));
                }
              },
              child: Text('送信する'),
            ),
          ),
          Text("あなたのお名前 : " + _yourName),
          Text("あなたのご年齢 : " + _yourAge.toString()),
        ],
      ),
    );
  }

TextFormField nameFormField(BuildContext context) {
  return TextFormField(
    // ここでは使用しないが、コントローラももちろん使用可能
    // controller: _nameController,
    textInputAction: TextInputAction.next,  
    autofocus: true, // フォームを含むウィジェットが作成された時点でフォーカスする。
    decoration: InputDecoration(labelText: "お名前を入力してください。"),
    focusNode: namefocus,
    onFieldSubmitted: (v){
      // フォーム入力完了後、agefocusにフォーカスを移す。
      // すなわち年齢入力フォームにフォーカスを移動する。
      FocusScope.of(context).requestFocus(agefocus);
    },
    // 入力内容に対するバリデーション
    validator: (value) {
      // 入力内容が空でないかチェック
      if (value.isEmpty) {
        return 'テキストを入力してください。';
      }
    },
    // _formKey.currentState.save() 呼び出し時に実行する処理
    onSaved: (value) {
      _updateName(value);
    },
  );
}

TextFormField ageFormField(BuildContext context) {
  return TextFormField(
    // キーボードタイプを指定。ここではnumberを指定しており、数字キーボードを表示
    // 一覧はhttps://api.flutter.dev/flutter/services/TextInputType-class.html
    keyboardType: TextInputType.number,
    // テキスト入力完了時の動作、ボタン見た目の指定
    textInputAction: TextInputAction.done,
    focusNode: agefocus,
    onFieldSubmitted: (v){
      // 年齢フォームからフォーカス外す
      agefocus.unfocus();
    },
    validator: (value) {
      // 年齢が１０歳以上であるか確認
      if (value.length == 0 || int.parse(value) <= 10) {
        return ('年齢は１０歳以上である必要があります。');
      }
    },
    // フォームの装飾を定義
    decoration: InputDecoration(
      labelText: "ご年齢を入力してください。",
      hintText: 'ご年齢（１０歳以上）',
      icon: Icon(Icons.person_outline),
      fillColor: Colors.white,
    ),
    onSaved: (value) {
      _updateAge(int.parse(value));
    },
  );
}

}
