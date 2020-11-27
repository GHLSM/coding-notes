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

List listData = [
  {"iamge_url": "", "avatar_url": "", "title": "", "descripton": ""},
  {"iamge_url": "", "avatar_url": "", "title": "", "descripton": ""}
];

class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listData.map((value) {
        return Card(
          margin: EdgeInsets.all(15),
          color: Colors.green[50],
          //阴影颜色
          shadowColor: Colors.orange,
          //阴影偏移
          elevation: 5,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  value["iamge_url"],
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(value["avatar_url"]),
                ),
                title: Text(value["title"]),
                subtitle: Text(value["descripton"]),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
