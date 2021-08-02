import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/login_form.dart';

class DesktopMode extends StatefulWidget {
  @override
  _DesktopModeState createState() => _DesktopModeState();
}

class _DesktopModeState extends State<DesktopMode> {
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Container(
        color: bgColor,
        child: Center(
            child: Container(
                height: heightSize * 0.65,
                width: widthSize * 0.65,
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Card(
                    //elevation: 5,
                    child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  color: secondaryColor,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.asset('images/ic_login.png', height: heightSize * 0.9, width: widthSize *0.9, semanticLabel: 'test'),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding: EdgeInsets.only(top: 20),
                                  color: secondaryColor,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "URL Shorterer Los Gonzalez",
                                          style: Theme.of(context).textTheme.headline6,
                                        ),
                                        SizedBox(height: 50),
                                        LoginForm(
                                            0, 0.009, 16, 0.04, 0.01, 0.04,
                                            75, 0.01, 0.007, 0.01, 0.006
                                        )
                                      ]
                                  )
                              )
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}