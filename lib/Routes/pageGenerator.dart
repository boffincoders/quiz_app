import 'package:flutter/material.dart';

class GeneratePageRoute extends PageRouteBuilder {
  final Widget? widget;
  final String? routeName;

  GeneratePageRoute({this.widget, this.routeName})
      : super(
  settings: RouteSettings(name: routeName),
  pageBuilder: (BuildContext context, Animation<double> animation,
  Animation<double> secondaryAnimation) {
  return widget!;
  });
}