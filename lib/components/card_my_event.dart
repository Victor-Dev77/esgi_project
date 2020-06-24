import 'package:cached_network_image/cached_network_image.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEventCard extends StatelessWidget {
  final Event event;
  final Widget trailingWidget;
  final VoidCallback trailingAction;
  MyEventCard({
    @required this.event,
    @required this.trailingWidget,
    @required this.trailingAction,
  });

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
                Container(
                  margin: EdgeInsets.all(7),
                  width: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: event.pictures[0],
                      fit: BoxFit.cover,
                      useOldImageOnUrlChange: true,
                      placeholder: (context, url) => CupertinoActivityIndicator(
                        radius: 20,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
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
                        Text(
                          event.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
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
                            Text("${event.distanceBW}km"),
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
