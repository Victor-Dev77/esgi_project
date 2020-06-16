import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(25),   
              child: Text(
                "Rejoignez nous en ajoutant votre Event ! Il sera visible auprès de tous ! ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Image");
            },
            child: Container(
              height: 150.0,
              width: 300.0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: ConstantColor.primaryColor)
                ),
                child: new Center(
                  child: new Text("Image slider max 3 ??",
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child:TextField(
              style: TextStyle(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
              suffixIcon: Icon(Icons.event_note),
              hintText: "Nom de l'évènement",
              labelText: "Nom de l'évènement",
              labelStyle: TextStyle(fontWeight: FontWeight.w400))
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child:TextField(
                style: TextStyle(fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.pin_drop),
                    hintText: "Adresse l'évènement",
                    labelText: "Adresse de l'évènement",
                    labelStyle: TextStyle(fontWeight: FontWeight.w400))
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child:Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          hintText: "Date de début",
                          labelText: "Date de début",
                          labelStyle: TextStyle(fontWeight: FontWeight.w400))
                  ),
                ),
              ),
              Expanded(
                child:Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          hintText: "Date de fin",
                          labelText: "Date de fin",
                          labelStyle: TextStyle(fontWeight: FontWeight.w400))
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
