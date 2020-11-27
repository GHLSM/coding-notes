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

class UseButton extends StatelessWidget {
  String name;
  UseButton(this.name);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.name),
      textColor: Theme.of(context).accentColor,
      onPressed: () {},
    );
  }
}

class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      //设置主轴方向，默认为水平
      direction: Axis.horizontal,
      //主轴对齐方式,指的是不同长度的内容对其的方式
      // alignment: WrapAlignment.end,
      //主轴方向间距
      spacing: 10,
      //次轴间距
      runSpacing: 20,
      //次轴对齐方式
      // runAlignment: ,
      crossAxisAlignment: WrapCrossAlignment.center,

      children: [
        UseButton("04531"),
        UseButton("054641"),
        UseButton("051"),
        UseButton("01"),
        UseButton("01457878"),
        UseButton("01"),
        UseButton("015434532248"),
      ],
    );
  }
}
