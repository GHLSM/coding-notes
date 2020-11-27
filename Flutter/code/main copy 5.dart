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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(color: Colors.red),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(color: Colors.black),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(color: Colors.green),
          )
        ],
      ),
    );
  }
}
