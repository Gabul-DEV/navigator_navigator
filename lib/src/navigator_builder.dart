import 'package:flutter/material.dart';
import 'package:navigator_navigator/src/navigator_navigator.dart';

import 'package:navigator_navigator/src/navigator_route.dart';

class NavigatorBuilder extends StatefulWidget {
  final List<NavigatorRoute> routes;
  final String initialRoute;
  NavigatorBuilder({
    Key key,
    @required this.routes,
    @required this.initialRoute,
  }) : super(key: key);

  @override
  _NavigatorBuilderState createState() => _NavigatorBuilderState();
}

class _NavigatorBuilderState extends State<NavigatorBuilder> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    NavigatorNavigator.instance.init(update: () {
      setState(() {});
    }, overlay: (route) {
      switch (route.type) {
        case NavigatorRouteType.bottomSheet:
          {
            scaffoldKey.currentState.showBottomSheet(route.builder);
          }

          break;
        case NavigatorRouteType.dialog:
          {
            showDialog(context: context, builder: route.builder);
          }

          break;
        default:
          throw "INVALID NAVIGATOR TYPE";
      }
    });
    NavigatorNavigator.instance.generateRoutes(widget.routes);
    NavigatorNavigator.instance.push(route: widget.initialRoute);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigatorNavigator.instance.pop();
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        body: Navigator(
          onPopPage: (route, result) {
            if (!result.didPop(route)) {
              return false;
            } else {
              return true;
            }
          },
          pages: List.from(NavigatorNavigator.instance.pages),
        ),
      ),
    );
  }
}
