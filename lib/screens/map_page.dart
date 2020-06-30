import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:esgi_project/components/map_event.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapEvent(SearchEventController.to.popularEvent);
  }
}