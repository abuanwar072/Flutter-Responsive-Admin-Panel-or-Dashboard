import 'package:flutter/material.dart';

class WidgetService
{
  static Widget createIconButton(BuildContext context, Image image, String text, Function click)
  {
    return FlatButton(


      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: image
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        click();
      },
    );
  }

  static Widget createBubbleHelp(BuildContext context, Image image, String text)
  {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: image
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(

              text,
              textAlign: TextAlign.center,
              style: TextStyle(

                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
    );
  }


}