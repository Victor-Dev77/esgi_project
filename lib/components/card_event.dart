import 'package:esgi_project/components/hero_image_network.dart';
import 'package:esgi_project/components/icon_with_title.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CardEvent extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final double width, height, widthImage;
  final bool favEnable;

  CardEvent(
    this.event, {
    Key key,
    this.onTap,
    this.margin: EdgeInsets.zero,
    this.width: double.infinity,
    this.height: 100,
    this.widthImage: 100,
        this.favEnable: true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (onTap == null)
          ? Get.toNamed(Router.eventDetailRoute, arguments: event)
          : onTap(),
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ConstantColor.white,
        ),
        height: height,
        width: width,
        child: Row(
          children: <Widget>[
            HeroImageNetwork(
              tag: "picture-${event.id}",
              imageUrl: event.pictures[0],
              width: widthImage,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 3, top: 5, right: 5, bottom: 5),
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
                                fontWeight: FontWeight.bold, fontSize: 16, color: ConstantColor.backgroundColor),
                          ),
                        ),
                        if (event.userId != UserController.to.user.id && favEnable)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: GetBuilder<UserController>(
                                builder: (controller) {
                                  return InkWell(
                                    onTap: () => controller.addFavorite(event),
                                    child: Icon(
                                        controller.isFavorite(event)
                                            ? FontAwesomeIcons.solidHeart
                                            : FontAwesomeIcons.heart,
                                        size: 20, color: Colors.redAccent,),
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
                      color: ConstantColor.backgroundColor,
                    ),
                    SizedBox(height: 3),
                    IconWithTitle(
                      icon: Constant.locationOnIcon,
                      title: "${event.distanceBW}km",
                      color: ConstantColor.backgroundColor,
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
