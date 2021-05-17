import 'package:flutter/material.dart';

enum NavigatorRouteType { page, dialog, bottomSheet }

abstract class NavigatorRoute {
  final String name;
  final Widget Function(BuildContext context) builder;
  NavigatorRouteType get type;
  NavigatorRoute({
    @required this.name,
    @required this.builder,
  });
}

class NavigatorPageRoute extends NavigatorRoute {
  NavigatorPageRoute({
    String name,
    Widget Function(BuildContext context) builder,
  }) : super(name: name, builder: builder);

  @override
  NavigatorRouteType get type => NavigatorRouteType.page;
}

class NavigatorDialogRoute extends NavigatorRoute {
  NavigatorDialogRoute({
    String name,
    Widget Function(BuildContext context) builder,
  }) : super(name: name, builder: builder);
  @override
  NavigatorRouteType get type => NavigatorRouteType.dialog;
}

class NavigatorBottomSheetRoute extends NavigatorRoute {
  NavigatorBottomSheetRoute({
    String name,
    Widget Function(BuildContext context) builder,
  }) : super(name: name, builder: builder);
  @override
  NavigatorRouteType get type => NavigatorRouteType.bottomSheet;
}
