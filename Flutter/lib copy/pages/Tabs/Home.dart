import 'package:flutter/material.dart';
import 'Search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RaisedButton(
              child: Text("跳转到Search页面"),
              color: Theme.of(context).accentColor,
              textTheme: ButtonTextTheme.primary,
              onPressed: () {
                //路由跳转
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              })
        ],
      ),
    );
  }
}
