import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';

class RoundBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  RoundBtn({Key key, @required this.onPressed, @required this.child})
      : assert(onPressed != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: child,
      ),
      elevation: 6.0,
      fillColor: ConstantColor.white,
      shape: StadiumBorder(),
    );
  }
}
