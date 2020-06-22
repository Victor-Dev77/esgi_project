import 'package:esgi_project/components/card_my_event.dart';
import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Événements"),
      ),
      body: GetBuilder<SearchEventController>(
        init: SearchEventController(),
        builder: (controller) {
          return _buildListEvent(controller);
        },
      ),
    );
  }

  Widget _buildListEvent(SearchEventController controller) {
    if (controller.searchEvent == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    if (controller.searchEvent.length == 0)
      return Center(
        child: Text("Aucun événements"),
      );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: controller.searchEvent.length,
        itemBuilder: (context, index) {
          return MyEventCard(
            event: controller.searchEvent[index],
            trailingWidget: CircleAvatar(
              backgroundColor: Colors.black,
              child: Center(
                child: Icon(
                  UserController.to.isFavorite(controller.searchEvent[index])
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: Colors.white,
                ),
              ),
            ),
            trailingAction: () =>
                UserController.to.addFavorite(controller.searchEvent[index]),
          );
        },
      ),
    );
  }
}