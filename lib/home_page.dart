import 'package:flutter/material.dart';
import 'package:navigator_navigator/src/navigator_navigator.dart';

class HomePage extends StatefulWidget {
  final String title;
  final String route;
  HomePage({
    Key key,
    @required this.title,
    @required this.route,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          FlatButton(
              onPressed: () {
                NavigatorNavigator.instance.push(route: "/alert");
              },
              child: Text("Open Alert")),
          FlatButton(
              onPressed: () {
                NavigatorNavigator.instance.push(route: "/bottomsheet");
              },
              child: Text("Open BottomSheet"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorNavigator.instance.push(route: widget.route);
        },
      ),
    );
  }
}
