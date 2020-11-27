import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("data"),
            subtitle: Text("hi"),
          ),
          RaisedButton(
              child: Text("没有对应的路由"),
              onPressed: () {
                Navigator.pushNamed(context, 'routeName');
              })
        ],
      ),
    );
  }
}
