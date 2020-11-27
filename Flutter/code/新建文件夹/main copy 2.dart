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
  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return Center(
      child: Stack(
        //有点类似于将每一个组件增加了一个Z轴信息

        //内部所有元素居中
        // alignment: Alignment.center,

        //设置所有元素的特定位置,第一个参数为X轴，第二个参数为Y轴，中心为(0,0)
        alignment: Alignment(0, 0.5),

        children: [
          Container(
            height: 400,
            width: 300,
            color: Colors.green[50],
          ),
          Text("data"),
          Text("data2")
        ],
      ),
    );
  }
}
