import 'package:flutter/material.dart';
import 'package:topbar/firsttab.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        // タブの数
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              // タブのオプション
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              labelColor: Colors.yellowAccent,
              labelStyle: TextStyle(fontSize: 16.0),
              unselectedLabelStyle: TextStyle(fontSize: 12.0),
              indicatorWeight: 2.0,
              // タブに表示する内容
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
                      Tab(
                        child: Text('Economic'),
                      ),
                      Tab(
                        child: Text('Game'),
                      )
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            // 各タブの内容
            children: [
              // Icon(Icons.directions_car),
              new FirstTab('test'),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car)
            ],
          ),
        ),
      ),
    );
  }
}
