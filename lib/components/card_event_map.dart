import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:esgi_project/components/hero_image_network.dart';
import 'package:esgi_project/components/icon_with_title.dart';

class CardEventMap extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  CardEventMap(this.event, {Key key, @required this.onTap})
      : assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () => (onTap == null)
            ? Get.toNamed(Router.eventDetailRoute, arguments: event)
            : onTap(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey,
          ),
          height: 75,
          width: 275,
          child: Row(
            children: <Widget>[
              HeroImageNetwork(
                tag: "picture-${event.id}",
                imageUrl: event.pictures[0],
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
                          Expanded(
                            flex: 4,
                            child: Text(
                              event.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          if (event.userId != UserController.to.user.id)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: GetBuilder<UserController>(
                                  //id: "favorite",
                                  builder: (controller) {
                                    return InkWell(
                                      onTap: () =>
                                          controller.addFavorite(event),
                                      child: Icon(
                                          controller.isFavorite(event)
                                              ? FontAwesomeIcons.solidHeart
                                              : FontAwesomeIcons.heart,
                                          size: 20),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
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
    );
  }
}
