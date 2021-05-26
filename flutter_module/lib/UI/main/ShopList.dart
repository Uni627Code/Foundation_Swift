

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopList extends StatefulWidget {


  final Map params;

  final String uniqueId;

  const  ShopList(this.params, this.uniqueId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShopList();
  }
}


class _ShopList extends State<ShopList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.params["title"]),
      ),
    );

  }
}