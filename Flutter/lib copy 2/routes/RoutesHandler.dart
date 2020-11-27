import 'package:flutter/material.dart';
import 'Routers.dart';

var onGenerateRoute = (RouteSettings settings) {
  //settings.name就是点击跳转时，目标组件的跳转命名
  final String name = settings.name;
  // print(settings);
  final Function pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  // } else {
  //   final Route route =
  //       MaterialPageRoute(builder: (context) => SearchPage());
  //   return route;
  // }
};
