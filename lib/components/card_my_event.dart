import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esgi_project/components/hero_image_network.dart';
import 'package:esgi_project/components/icon_with_title.dart';

class MyEventCard extends StatelessWidget {
  final Event event;
  final Widget trailingWidget;
  final VoidCallback trailingAction;
  MyEventCard(
    this.event, {
    Key key,
    @required this.trailingWidget,
    @required this.trailingAction,
  })  : assert(trailingWidget != null),
        assert(trailingAction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        GestureDetector(
          onTap: () => Get.toNamed(Router.eventDetailRoute, arguments: event),
          child: Container(
            margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey,
            ),
            height: 100,
            child: Row(
              children: <Widget>[
                HeroImageNetwork(
                  tag: "picture-${event.id}",
                  imageUrl: event.pictures[0],
                  width: 100,
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 3, top: 5, right: 5, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        IconWithTitle(
                          icon: Constant.dateIcon18,
                          title: event.dateStart,
                        ),
                        SizedBox(height: 3),
                        IconWithTitle(
                          icon: Constant.locationOnIcon,
                          title: "${event.distanceBW}km",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () => trailingAction(),
            child: trailingWidget,
          ),
          right: 15,
          top: 0,
        )
      ],
    );
  }
}
