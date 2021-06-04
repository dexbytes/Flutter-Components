import 'package:flutter/material.dart';

import 'imageSelectState.dart';


class MyProvider extends InheritedWidget {
  final ImageSelectState controller;

  MyProvider({
    Key key,
    @required this.controller,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
