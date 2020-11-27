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
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606294429104&di=97a8e004f1757a277d9333fdcb820018&imgtype=0&src=http%3A%2F%2Fdik.img.kttpdq.com%2Fpic%2F73%2F50657%2Fb768771c63e69a84.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606294429104&di=97a8e004f1757a277d9333fdcb820018&imgtype=0&src=http%3A%2F%2Fdik.img.kttpdq.com%2Fpic%2F73%2F50657%2Fb768771c63e69a84.jpg"),
                  ),
                  title: Text("耿號"))
            ],
          ),
        )
      ],
    );
  }
}
