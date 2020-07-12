import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double width, height;
  Loader({Key key, this.width: 70, this.height: 70}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        backgroundColor: ConstantColor.primaryColor,
        valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.backgroundColor),
      ),
    );
  }
}
