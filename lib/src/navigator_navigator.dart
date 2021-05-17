import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigator_route.dart';

abstract class NavigatorNavigatorBase {
  void push({String route, Page page});
  void pop();
  void popAndRemoveUntil(bool Function(Page page) validate);
  void generateRoutes(List<NavigatorRoute> routes);
  void init({
    @required void Function() update,
    @required void Function(NavigatorRoute route) overlay,
  });
  Page get currentPage;
  List<Page> get pages;
  int get length;
  GlobalKey<NavigatorState> get navigatorKey;
}

class NavigatorNavigator {
  static final NavigatorNavigatorBase instance = _NavigatorNavigatorImpl();
}

class _NavigatorNavigatorImpl implements NavigatorNavigatorBase {
  Function() update;
  Function(NavigatorRoute route) overlay;
  var _stack = <Page>[];

  final _routes = Map<String, NavigatorRoute>();
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Page get currentPage => _stack.isNotEmpty ? _stack.last : null;
  @override
  int get length => _stack.length;
  @override
  List<Page> get pages => _stack;

  @override
  void init(
      {@required void Function() update,
      @required void Function(NavigatorRoute route) overlay}) {
    this.update = update;
    this.overlay = overlay;
  }

  @override
  void pop() {
    _stack.removeLast();
    update();
  }

  @override
  void popAndRemoveUntil(bool Function(Page page) validate) {
    var enableRemove = true;
    for (var i = _stack.length - 1; i > 0; i--) {
      final page = _stack[i];
      if (validate(page)) {
        enableRemove = false;
      }
      if (enableRemove) {
        _remove(route: page.name);
      }
    }
    update();
  }

  @override
  void push({String route, Page page}) {
    assert(route != null || page != null);

    if (route != null) {
      final currentRoute = _routes[route];
      if (currentRoute.type == NavigatorRouteType.page) {
        final newPage = Platform.isAndroid
            ? MaterialPage(
                name: route,
                child: Builder(
                  builder: currentRoute.builder,
                ))
            : CupertinoPage(
                name: route,
                child: Builder(
                  builder: currentRoute.builder,
                ));
        _add(newPage);
        update();
      } else {
        overlay(currentRoute);
      }
    } else if (page != null) {
      _add(page);
      update();
    }
  }

  void _add(Page page) {
    _stack.add(page);
  }

  void _remove({String route, Type type}) {
    _stack.removeWhere(
        (element) => element.name == route || element.runtimeType == type);
  }

  @override
  void generateRoutes(List<NavigatorRoute> newRoutes) {
    assert(newRoutes != null);
    for (var i = 0; i < newRoutes.length; i++) {
      final route = newRoutes[i];
      _routes.addAll({route.name: route});
    }
  }
}
