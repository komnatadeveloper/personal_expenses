import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {

  final String adaptiveText;
  final Function handler;

  AdaptiveFlatButton(this.adaptiveText, this.handler);

  @override
  Widget build(BuildContext context) {
    return !Platform.isIOS 
    ? 
    CupertinoButton(
      // color: Colors.red,
      child: Text(
        adaptiveText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler,
    )
    :
    FlatButton(
      textColor: Theme.of(context).primaryColor,
      child: Text(
        adaptiveText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler,
    );
  }
}