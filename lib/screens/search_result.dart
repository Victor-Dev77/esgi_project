import 'package:esgi_project/components/card_search.dart';
import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esgi_project/components/map_event.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.eventTitle.tr),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: GetBuilder<SearchEventController>(
              builder: (controller) {
                return IconButton(
                  icon: Icon(controller.showMapResult ? Icons.list : Icons.map),
                  onPressed: () => controller.changeModeResult(),
                );
              },
            ),
          ),
        ],
      ),
      body: GetBuilder<SearchEventController>(
        builder: (controller) {
          return _buildResult(controller);
        },
      ),
    );
  }

  Widget _buildResult(SearchEventController controller) {
    if (controller.searchEvent == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    if (controller.searchEvent.length == 0)
      return Center(
        child: Text(Localization.noEventTitle.tr),
      );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          _buildFilter(controller),
          SizedBox(height: 10),
          controller.showMapResult
              ? _buildMapEvent(controller)
              : _buildListEvent(controller),
        ],
      ),
    );
  }

  Widget _buildMapEvent(SearchEventController controller) {
    return Expanded(
      child: MapEvent(controller.searchEvent),
    );
  }

  Widget _buildListEvent(SearchEventController controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.searchEvent.length,
        itemBuilder: (context, index) {
          return CardSearchEvent(controller.searchEvent[index]);
        },
      ),
    );
  }

  Widget _buildFilter(SearchEventController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 25),
          child: DropdownButton<String>(
            value: controller.filter,
            icon: Icon(Icons.filter_list),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String filter) => controller.changeFilter(filter),
            items: controller.listFilter
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
