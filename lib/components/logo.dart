import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Lottie.asset(Constant.lottieLogo, width: 250, height: 300),
        Text(
          "WE\nMOUV",
          style: Get.textTheme.headline1,
        )
      ],
    );
  }
}
