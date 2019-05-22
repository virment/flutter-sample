import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:intl/intl.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Datepicker Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Datepicker Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 選択した日時を格納する変数
  var _mydatetime = new DateTime.now();
  // 日時を指定したフォーマットで指定するためのフォーマッター
  var formatter = new DateFormat('yyyy/MM/dd(E) HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'あなたが選択した日時は以下です: ',
            ),
            Text(
              // フォーマッターを使用して指定したフォーマットで日時を表示
              // format()に渡すのはDate型の値で、String型で返される
              formatter.format(_mydatetime),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: () {
           DatePicker.showDateTimePicker(
             context,
             showTitleActions: true,
             // onChanged内の処理はDatepickerの選択に応じて毎回呼び出される
             onChanged: (date) {
                // print('change $date');
             }, 
             // onConfirm内の処理はDatepickerで選択完了後に呼び出される
             onConfirm: (date) {
               setState(() {
                 _mydatetime = date;
               });
             }, 
             // Datepickerのデフォルトで表示する日時
             currentTime: DateTime.now(), 
             // localによって色々な言語に対応
              locale: LocaleType.jp
          );
        },
        tooltip: 'Datetime',
        child: Icon(Icons.access_time),
      ), 
    );
  }
}
