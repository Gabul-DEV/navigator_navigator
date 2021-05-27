import 'package:flutter/material.dart';

enum NavigatorRouteType { page, dialog, bottomSheet }

abstract class NavigatorRoute {
  final String name;
  final Widget Function(BuildContext context) builder;
  NavigatorRouteType get type;
  NavigatorRoute({
    required this.name,
    required this.builder,
  });
}

class NavigatorPageRoute extends NavigatorRoute {
  final List<NavigatorPageRoute> children; 
  NavigatorPageRoute({
    required String name,
    this.children = const <NavigatorPageRoute>[],
    required Widget Function(BuildContext context) builder,
  }) : super(name: name, builder: builder);

  @override
  NavigatorRouteType get type => NavigatorRouteType.page;
}

class NavigatorDialogRoute extends NavigatorRoute {
  NavigatorDialogRoute({
    required String name,
    required Widget Function(BuildContext context) builder,
  }) : super(name: name, builder: builder);
  @override
  NavigatorRouteType get type => NavigatorRouteType.dialog;
}

class NavigatorBottomSheetRoute extends NavigatorRoute {
  NavigatorBottomSheetRoute({
    required String name,
    required Widget Function(BuildContext context) builder,
  }) : super(name: name, builder: builder);
  @override
  NavigatorRouteType get type => NavigatorRouteType.bottomSheet;
}
