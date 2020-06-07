import 'package:flutter/material.dart';
import 'package:esgi_project/utils/constant_color.dart';

class CardSettings extends StatelessWidget {

  final String text;
  final Function action;

  const CardSettings({Key key, this.text, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            color: ConstantColor.primaryColor,
            child: InkWell(
              splashColor: ConstantColor.primaryColor.withAlpha(80),
              onTap: action,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Center(
                    child: Text(
                      text,
                      style: TextStyle(color: ConstantColor.white),
                      textAlign: TextAlign.center,
                    )
                ),
              ),
            )
        )
    );
  }
}
