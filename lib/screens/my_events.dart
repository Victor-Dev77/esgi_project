import 'package:esgi_project/components/card_my_event.dart';
import 'package:esgi_project/controllers/my_event_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.myEventsTitle.trArgs([MyEventController.to.myEvents.length.toString()])),
      ),
      body: GetBuilder<MyEventController>(
        init: MyEventController(),
        builder: (controller) {
          return _buildListEvent(controller);
        },
      ),
    );
  }

  Widget _buildListEvent(MyEventController controller) {
    if (controller.myEvents == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    if (controller.myEvents.length == 0)
      return Center(
        child: Text(Localization.noEventTitle.tr),
      );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: controller.myEvents.length,
        itemBuilder: (context, index) {
          return MyEventCard(
            event: controller.myEvents[index],
            trailingWidget: CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.minus,
                  color: Colors.white,
                ),
              ),
            ),
            trailingAction: () => controller.deleteEvent(controller.myEvents[index]),
          );
        },
      ),
    );
  }
}
