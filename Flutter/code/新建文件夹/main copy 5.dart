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
    //AxpectRatio常用于图片等组件的平铺
    return AspectRatio(
      //横向/纵向,AspectRatio是针对于父组件而言的（最大的父组件是屏幕）
      aspectRatio: 3.0 / 1,
      //用子组件占满，添加颜色，更好看效果
      child: Container(
        color: Colors.green[50],
      ),
    );
  }
}
