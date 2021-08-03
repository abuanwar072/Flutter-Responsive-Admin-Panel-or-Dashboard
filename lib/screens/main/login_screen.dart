import 'package:admin/screens/main/login2_screen.dart';
import 'package:flutter/material.dart';
import 'desktop_mode.dart';
import 'mobile_mode.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (context, constraints) {
        if(constraints.maxWidth <= 1024) {
          return MobileMode();
        } else {
          return LoginPage2();
        }
      },
    );
  }
}