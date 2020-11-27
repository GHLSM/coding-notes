import 'package:flutter/material.dart';
import './routes/RoutesHandler.dart';

void main(List<String> args) {
  runApp(UserTwo());
}

class UserTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // home: BottomTabs(),
        initialRoute: "/",
        theme: ThemeData(primarySwatch: Colors.green),
        onGenerateRoute: onGenerateRoute);
  }
}
