import 'package:esgi_project/components/card_my_event.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyFavoriteEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ConstantColor.white, //change your color here
        ),
        backgroundColor: ConstantColor.backgroundColor,
        title: Text(Localization.favoriteTitle.tr, style: TextStyle(color: ConstantColor.white),),
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          return _buildListFavoriteEvent(controller);
        },
      ),
    );
  }

  Widget _buildListFavoriteEvent(UserController controller) {
    if (controller.favorites == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    if (controller.favorites.length == 0)
      return Center(
        child: Text(Localization.noFavoriteTitle.tr, style: TextStyle(color: ConstantColor.white),),
      );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: controller.favorites.length,
        itemBuilder: (context, index) {
          return MyEventCard(
            controller.favorites[index],
            trailingWidget: CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Center(
                child: Icon(
                  controller.isFavorite(controller.favorites[index])
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: Colors.white,
                ),
              ),
            ),
            trailingAction: () =>
                controller.addFavorite(controller.favorites[index]),
          );
        },
      ),
    );
  }
}
