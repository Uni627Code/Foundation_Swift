import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'UI/main/SimpleWidget.dart';
import 'UI/main/FirstPage.dart';
import 'UI/main/ShopList.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  static Map<String, FlutterBoostRouteFactory> routerMap = {

    '/': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              Container()
      );
    },
    'ShopList': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              ShopList({'title': '商城'}, uniqueId)
      );
    },
    'FirstRouteWidget': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              FirstRouteWidget());
    },
    'SimpleWidget': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) =>
            SimpleWidget(uniqueId, {'a':'a'}, '')
          );
    }
  };



  Route<dynamic>? routeFactory(RouteSettings settings, String uniqueId) {
    var name = settings.name;
    FlutterBoostRouteFactory func = routerMap[name]!;
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(
        routeFactory
    );
  }
}

