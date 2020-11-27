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
            Align(
              alignment: Alignment(1, 0.2),
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.green,
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Icon(
                Icons.home,
                size: 50,
                color: Colors.green,
              ),
            ),
            Align(
              alignment: Alignment(-0.5, -0.5),
              child: Icon(
                Icons.send,
                size: 50,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
