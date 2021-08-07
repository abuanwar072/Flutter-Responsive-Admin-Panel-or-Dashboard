import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/login_form.dart';

class MobileMode extends StatefulWidget {
  @override
  _MobileModeState createState() => _MobileModeState();
}

class _MobileModeState extends State<MobileMode> {
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
            child: Container(
                color: bgColor,
                child: Column(
                    children: [
                      Image.asset('assets/images/ic_logo.png', height: heightSize * 0.3, width: widthSize * 0.6),
                      SingleChildScrollView(
                          child: LoginForm(
                              0.007,
                              0.04,
                              widthSize * 0.04,
                              0.06,
                              0.04,
                              0.07,
                              widthSize * 0.09,
                              0.05,
                              0.032,
                              0.04,
                              0.032
                          )
                      )
                    ]
                )
            )
        )
    );
  }
}