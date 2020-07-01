import 'package:flutter/material.dart';

class IconWithTitle extends StatelessWidget {
  final Icon icon;
  final double spaceBW;
  final String title;

  IconWithTitle({Key key, @required this.icon, this.spaceBW: 5, this.title: ""})
      : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        SizedBox(width: spaceBW),
        Text(title),
      ],
    );
  }
}
