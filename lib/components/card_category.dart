import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final Map<String, dynamic> data;
  CardCategory(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: data["color"],
        ),
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            data["icon"],
            SizedBox(height: 10),
            Text(data["title"]),
          ],
        ),
      ),
    );
  }
}
