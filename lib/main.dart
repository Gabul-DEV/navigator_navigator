import 'package:flutter/material.dart';
import 'package:navigator_navigator/home_page.dart';
import 'package:navigator_navigator/src/navigator_builder.dart';
import 'package:navigator_navigator/src/navigator_navigator.dart';
import 'package:navigator_navigator/src/navigator_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: NavigatorNavigator.instance.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavigatorBuilder(
        initialRoute: "/home",
        routes: [
          NavigatorPageRoute(
              name: "/home",
              builder: (context) => HomePage(
                    title: "HomePage",
                    route: "/profile",
                  )),
          NavigatorDialogRoute(
              name: "/alert",
              builder: (context) => AlertDialog(
                    title: Text("Alert Dialog"),
                  )),
          NavigatorBottomSheetRoute(
              name: "/bottomsheet",
              builder: (context) => BottomSheet(
                  onClosing: () {},
                  builder: (context) => Container(
                        height: 400,
                        width: double.infinity,
                        color: Colors.red,
                        child: Text("BottomSheet"),
                      ))),
          NavigatorPageRoute(
              name: "/profile",
              builder: (context) => HomePage(
                    title: "Profile",
                    route: "/user",
                  )),
          NavigatorPageRoute(
              name: "/user",
              builder: (context) => HomePage(
                    title: "User",
                    route: "/home",
                  ))
        ],
      ),
    );
  }
}
