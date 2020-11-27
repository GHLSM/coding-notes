import '../pages/Tabs.dart';
import '../pages/Tabs/Home.dart';
import '../pages/Tabs/Search.dart';

final routes = {
  "/": (context, {arguments}) => BottomTabs(),
  "/search": (context, {arguments}) => SearchPage(),
  "/error": (context) => HomePage()
};
