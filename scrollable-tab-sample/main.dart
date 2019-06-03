import 'package:flutter/material.dart';
import 'package:topbar/tablist.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Top Tab Bar Sample',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

const List<String> tabNames = const<String>[
  'WordPress', 'nginx', 'Flutter', 'Kotlin', 'Dart'
];


class _MyHomePageState extends State<MyHomePage> {

  int _screen = 0;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: tabNames.length,
      child: new Scaffold(
        appBar: AppBar(
            // centerTitle: true,
            // leading: Icon(Icons.person_outline),
            title: Text('Top Tab Bar',style: TextStyle(fontSize: 16.0),),
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Top'),
                      ),
                      Tab(
                        child: Text('Business'),
                      ),
                      Tab(
                        child: Text('Technology'),
                      ),
                      Tab(
                        child: Text('Finance'),
                      ),
                      Tab(
                        child: Text('Food'),
                      ),
                      // Tab(
                      //   child: Text('Tab 6'),
                      // )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ),
            ],
          ),
        body: new TabBarView(
          children: new List<Widget>.generate(tabNames.length, (int index) {
            switch (_screen) {
              case 0: return new Center(
                child: new TabList(index),
              );
              case 1: return new Center(
                child: new Text('Second screen'),
              );
            }
          }),
        ),
        bottomNavigationBar: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            new BottomNavigationBar(
              currentIndex: _screen,
              onTap: (int index) {
                setState(() {
                  _screen = index;
                });
              },
              items: [
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.book),
                  title: new Text('Book'),
                ),
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.library_music),
                  title: new Text('Music'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
