import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navigator_navigator/src/navigator_navigator.dart';
import 'package:navigator_navigator/src/navigator_route.dart';

void main() {
  NavigatorNavigatorBase navigator;

  setUp(() {
    navigator = NavigatorNavigator.instance;
    navigator.init(update: () {}, overlay: (_) {});
    navigator.generateRoutes([
      NavigatorPageRoute(
        name: "/1",
        builder: (context) => Container(),
      ),
      NavigatorPageRoute(
        name: "/2",
        builder: (context) => Container(),
      ),
      NavigatorPageRoute(
        name: "/3",
        builder: (context) => Container(),
      )
    ]);
  });

  group("Test NavigatorNavigator", () {
    test("Push route by name", () {
      navigator.push(route: "/1");
      expect(navigator.currentPage.name, "/1");
    });
    test("Push route by Page", () {
      navigator.push(page: MaterialPage(child: Container(), name: "byroute"));
      expect(navigator.currentPage.name, "byroute");
    });

    test("Push route by name and pop", () {
      navigator.push(route: "/1");
      navigator.pop();
      expect(navigator.currentPage, isNull);
    });

    test("PopAndRemoveUnitl route by name, first route", () {
      navigator.push(route: "/1");
      navigator.push(route: "/2");
      navigator.push(route: "/3");
      navigator.popAndRemoveUntil((page) => page.name == "/1");
      expect(navigator.currentPage.name, "/1");
    });

    test("PopAndRemoveUnitl route by name, repeated route", () {
      navigator.push(route: "/1");
      navigator.push(route: "/1");
      navigator.push(route: "/2");
      navigator.push(route: "/3");
      navigator.popAndRemoveUntil((page) => page.name == "/1");
      expect(navigator.currentPage.name, "/1");
      expect(navigator.length, 2);
    });

    test("PopAndRemoveUnitl route by name, remove second", () {
      navigator.push(route: "/1");
      navigator.push(route: "/1");
      navigator.push(route: "/2");
      navigator.push(route: "/3");
      navigator.popAndRemoveUntil((page) => page.name == "/2");
      expect(navigator.currentPage.name, "/2");
      expect(navigator.length, 3);
    });

    test("PopAndRemoveUnitl route by name, last route dont remove", () {
      navigator.push(route: "/1");
      navigator.push(route: "/1");
      navigator.push(route: "/2");
      navigator.push(route: "/3");
      navigator.popAndRemoveUntil((page) => page.name == "/3");
      expect(navigator.currentPage.name, "/3");
      expect(navigator.length, 4);
    });
  });
}
