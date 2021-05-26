

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class SimpleWidget extends StatefulWidget {

  final Map params;
  final String messages;
  final String uniqueId;

  const SimpleWidget(this.uniqueId, this.params, this.messages);

  @override
  State<StatefulWidget> createState() {
    return _SimpleWidgetState();
  }
}

class _SimpleWidgetState extends State<SimpleWidget>  with PageVisibilityObserver {

  static const String _kTag = 'xlog';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('$_kTag#didChangeDependencies, ${widget.uniqueId}, $this');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // PageVisibilityBinding.instance.addObserver(this, ModalRoute.of(context));
    print('$_kTag#initState, ${widget.uniqueId}, $this');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    PageVisibilityBinding.instance.removeObserver(this);
    print('$_kTag#dispose, ${widget.uniqueId}, $this');
    super.dispose();
  }

  @override
  void onForeground() {
    // TODO: implement onForeground
    super.onForeground();
    print('$_kTag#onForeground, ${widget.uniqueId}, $this');
  }

  @override
  void onBackground() {
    // TODO: implement onBackground
    super.onBackground();
    print('$_kTag#onBackground, ${widget.uniqueId}, $this');
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('tab_example'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.messages,
                  style: TextStyle(fontSize: 28, color: Colors.blue),
                ),
                alignment: AlignmentDirectional.center,
              ),
              Container(
                margin: const EdgeInsets.only(top: 32.0),
                child: Text(
                  widget.uniqueId,
                  style: TextStyle(fontSize: 22.0, color: Colors.red),
                ),
                alignment: AlignmentDirectional.center,
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(30.0),
                    color: Colors.yellow,
                    child: Text(
                      'open flutter page',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                    )),
                onTap: () => BoostNavigator.instance.push("flutterPage",
                    arguments: <String, String>{'from': widget.uniqueId}),
              ),
              Container(
                height: 300,
                width: 200,
                child: Text(
                  '',
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              )
            ],
          )
        )
      ),
    );
  }
}