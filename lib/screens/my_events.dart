import 'package:esgi_project/components/card_my_event.dart';
import 'package:esgi_project/controllers/my_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes événements'),
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
        child: Text("Aucun événements"),
      );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: controller.myEvents.length,
        itemBuilder: (context, index) {
          return MyEventCard(controller.myEvents[index]);
        },
      ),
    );
  }
}
