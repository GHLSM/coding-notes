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
    return Center(
      child: Container(
        height: 500,
        width: 300,
        color: Colors.yellow,
        child: Stack(
          children: [
            //使用Align控制每一个组件的位置
            Positioned(
              //控制离容器边的距离
              left: 20,
              top: 100,
              //right bottom
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
