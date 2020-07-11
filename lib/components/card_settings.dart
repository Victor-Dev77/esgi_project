import 'package:flutter/material.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:get/get.dart';

class CardSettings extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  CardSettings({Key key, @required this.text, @required this.onTap})
      : assert(text != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ConstantColor.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        color: ConstantColor.white,
        child: InkWell(
          splashColor: ConstantColor.primaryColor.withAlpha(80),
          onTap: onTap,
          child: Container(
            width: Get.width * 0.9,
            height: Get.height * 0.06,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: ConstantColor.backgroundColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
