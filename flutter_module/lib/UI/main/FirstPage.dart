
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class FirstRouteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _FirstRouteWidget();
  }
}

class _FirstRouteWidget extends State<FirstRouteWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Column(
        children:<Widget>[
          RaisedButton(
            child: Text('与原生push一样的页面'),
            onPressed: (){

            },
          )
        ],
      ),
    );
  }

}