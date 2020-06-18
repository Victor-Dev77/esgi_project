import 'package:esgi_project/models/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  Event event;
  bool _error;

  @override
  void initState() {
    super.initState();
    event = Get.arguments as Event;
    _error = (event == null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SLIVER APPBAR ici - photo + titre'),
      ),
      body: Container(
        child: Center(
          child: Text(_error
              ? "ERREUR: manque parametre event"
              : "userId event: ${event.userId}"),
        ),
      ),
    );
  }
}
