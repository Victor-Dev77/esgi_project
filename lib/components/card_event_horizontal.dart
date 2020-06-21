import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EventCardHorizontal extends StatelessWidget {
  final Event event;
  EventCardHorizontal(this.event);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () => Get.toNamed(Router.eventDetailRoute, arguments: event),
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
                  padding:
                      EdgeInsets.only(left: 3, top: 5, right: 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            event.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: GetBuilder<UserController>(
                              //id: "favorite",
                              builder: (controller) {
                                return InkWell(
                                  onTap: () => controller.addFavorite(event),
                                  child: Icon( controller.isFavorite(event) ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart, size: 20),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.orange,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(event.dateStart),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.orange,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(event.address),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
