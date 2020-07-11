import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FavoriteBtn extends StatelessWidget {
  final bool enabled;
  final Event event;
  FavoriteBtn({Key key, @required this.enabled, @required this.event})
      : assert(enabled != null),
        assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => UserController.to.addFavorite(event),
          child: Container(
            width: 125,
            height: 100,
            decoration: BoxDecoration(
              color: enabled
                  ? Colors.redAccent
                  : ConstantColor.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    Localization.favoriteTitle.tr,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    enabled
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    size: 20,
                    color: Colors.white.withOpacity(0.85)
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
