import 'package:flutter/material.dart';
import 'Tabs/User.dart';
import 'Tabs/home.dart';
import 'Tabs/Search.dart';

class BottomTabs extends StatefulWidget {
  BottomTabs({Key key}) : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  var _pageList = [SearchPage(), HomePage(), PersonPage()];
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("这是我的"),
        ),
        body: this._pageList[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 24.0, //Icon大小
          fixedColor: Colors.orange, //选中之后的颜色
          type: BottomNavigationBarType.fixed, //可以显示多个导航框
          currentIndex: this._currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("search"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              title: Text("person"),
            ),
          ],
        ));
  }
}
