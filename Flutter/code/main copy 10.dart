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
  Widget _getData(count, index) {
    return Container(
      // Colum 有点像竖着的ListView
      child: Column(
        children: [
          Image.network(listData[index]["imageUrl"]),
          Text(listData[index]["title"])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return GridView.builder(
        //配置网格的样式
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //在这内部的网格样式和GridView.count内部一样
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0),
        //数据的个数，为了Builder的内部循环的index计数
        itemCount: listData.length,
        //不用加括号运行
        itemBuilder: this._getData);
  }
}
