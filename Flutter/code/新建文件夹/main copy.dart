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
    return Row(
      children: [
        Expanded(
            flex: 1, child: IconContainer(Icons.search, color: Colors.yellow)),
        IconContainer(Icons.home, color: Colors.orange)
      ],
    );
  }
}

class IconContainer extends StatelessWidget {
  double size = 32.0;
  Color color = Colors.green;
  IconData icon;
  // 函数无内容，无需写{}
  IconContainer(this.icon, {this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        width: 100.0,
        color: this.color,
        child: Center(
          child: Icon(
            this.icon,
            size: this.size,
            color: Colors.black,
          ),
        ));
  }
}
