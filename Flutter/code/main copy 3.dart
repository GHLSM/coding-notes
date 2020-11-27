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
    return ListView(
      children: <Widget>[
        Image.network('image_url'),
        Image.network('image_url'),
        Image.network('image_url'),
        Container(height: 10,),
        Text("data",),

      ],
    );
  }
}
