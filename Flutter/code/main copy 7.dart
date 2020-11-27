import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(UserOne());
}

class UserOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: HoemContent(),
      ),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class HoemContent extends StatelessWidget {
  List list = new List();
  HoemContent() {
    for (var i = 0; i < 20; i++) {
      this.list.add("我是第 $i 条");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: this.list.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(this.list[index]));
        });
  }
}
