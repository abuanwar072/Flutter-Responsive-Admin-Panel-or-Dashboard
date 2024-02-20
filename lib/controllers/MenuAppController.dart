iimport 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void toggleMenu() {
    final isDrawerOpen = _scaffoldKey.currentState?.isDrawerOpen ?? false;

    if (!isDrawerOpen) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }
}

