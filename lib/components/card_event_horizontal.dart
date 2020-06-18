import 'package:flutter/material.dart';

class EventCardHorizontal extends StatelessWidget {
  final Map<String, dynamic> data;
  EventCardHorizontal(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        height: 75,
        width: 275,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(7),
              width: 85,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text("Image"),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 3, top: 5, right: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['title'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.date_range, color: Colors.orange, size: 18,),
                        SizedBox(width: 5,),
                        Text(data['date']),
                      ],
                    ),
                    SizedBox(height: 3,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.orange, size: 18,),
                        SizedBox(width: 5,),
                        Text(data['location']['latitude'].toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
