import 'package:esgi_project/components/card_my_event.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyFavoriteEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris'),
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
        child: Text("Aucun favoris"),
      );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: controller.favorites.length,
        itemBuilder: (context, index) {
          return MyEventCard(
            event: controller.favorites[index],
            trailingWidget: CircleAvatar(
              backgroundColor: Colors.black,
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
