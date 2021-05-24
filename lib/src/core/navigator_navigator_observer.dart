import 'package:flutter/material.dart';
import 'package:navigator_navigator/navigator_navigator.dart';

class NavigatorNavigatorObserver implements NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // TODO: implement didRemove
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    // TODO: implement didReplace
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    // TODO: implement didStartUserGesture
  }

  @override
  void didStopUserGesture() {
    // TODO: implement didStopUserGesture
  }

  @override
  // TODO: implement navigator
  NavigatorState? get navigator =>
      NavigatorNavigator.instance.navigatorKey.currentState;
}
