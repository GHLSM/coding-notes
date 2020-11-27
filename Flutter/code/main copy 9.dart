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

/**
 * 数据格式如下：*/
List listData = [
  {"title": "candySupr", "author": "sdasd", "imageUrl": "..."}
];

class LayOutDemo extends StatelessWidget {
  List<Widget> _getData() {
    var tempList = listData.map((value) {
      return Container(
        // Colum 有点像竖着的ListView
        child: Column(
          children: [Image.network(value["imageUrl"]), Text(value["title"])],
        ),
      );
    });
    //map返回的数据不是数组，转换成数组
    return tempList.toList();
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
