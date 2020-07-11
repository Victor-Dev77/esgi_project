import 'package:flutter/material.dart';

class IconWithTitle extends StatelessWidget {
  final Icon icon;
  final double spaceBW;
  final String title;
  final Color color;

  IconWithTitle({Key key, @required this.icon, this.spaceBW: 5, this.title: "", this.color: Colors.white})
      : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        icon,
        SizedBox(width: spaceBW),
        Text(title, style: TextStyle(color: color), ),
      ],
    );
  }
}
