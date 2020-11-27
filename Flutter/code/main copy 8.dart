import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(UserTwo());
}

class UserTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("这是我的"),
        ),
        body: LayOutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class LayOutDemo extends StatelessWidget {
  List<Widget> _getData() {
    List<Widget> list = new List();
    for (var i = 0; i < 20; i++) {
      list.add(Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: Text(
          "第 $i 个",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return GridView.count(
        //横向网格间隙
        crossAxisSpacing: 20.0,
        //竖向网格间隙
        mainAxisSpacing: 20.0,
        //增加和屏幕的间隙
        padding: EdgeInsets.all(10.0),
        //网格列数
        crossAxisCount: 3,
        //内部元素
        children: this._getData());
  }
}
