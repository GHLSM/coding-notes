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
    return ListView(
      children: [
        Card(
          margin: EdgeInsets.all(15),
          color: Colors.green[50],
          //阴影颜色
          shadowColor: Colors.orange,
          //阴影偏移
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "耿號",
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text("高级工程师"),
              ),
              ListTile(
                title: Text("phone:"),
              ),
              ListTile(title: Text("addr:"))
            ],
          ),
        )
      ],
    );
  }
}
