import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  PersonPage({Key key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("data"),
          RaisedButton(onPressed: () {
            //命名路由跳转
            Navigator.pushNamed(context, "/search");
            // print(context);
          })
        ],
      ),
    );
  }
}
