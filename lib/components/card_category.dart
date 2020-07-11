import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final IconData iconData;
  final String title;

  CardCategory({Key key, @required this.iconData, @required this.title})
      : assert(title != null),
        assert(iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () => SearchEventController.to.searchByCategory(title),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber[50],
                ),
                child: Icon(
                  iconData,
                  size: 30,
                  color: ConstantColor.backgroundColor,
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontSize: 14, color: ConstantColor.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
