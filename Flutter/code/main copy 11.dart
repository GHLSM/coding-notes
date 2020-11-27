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

class LayOutDemo extends StatefulWidget {
  LayOutDemo({Key key}) : super(key: key);

  @override
  _LayOutDemoState createState() => _LayOutDemoState();
}

class _LayOutDemoState extends State<LayOutDemo> {
  var str = "data";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("hi"),
          RaisedButton(
              child: Text("${this.str}"),
              onPressed: () {
                setState(() {
                  // 只有有状态组件内部才有这个方法
                  this.str = "over";
                });
              }),
          Chip(label: Text("hello"))
        ],
      ),
    );
  }
}
