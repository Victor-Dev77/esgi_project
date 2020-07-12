import 'package:esgi_project/components/card_event.dart';
import 'package:esgi_project/components/loader.dart';
import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esgi_project/components/map_event.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColor.backgroundColor,
        iconTheme: IconThemeData(
          color: ConstantColor.white, //change your color here
        ),
        title: Text(Localization.eventTitle.tr, style: Get.textTheme.headline2,),
        actions: <Widget>[
          _buildChangeResultModeBtn(),
        ],
      ),
      body: GetBuilder<SearchEventController>(
        builder: (controller) {
          return _buildResult(controller);
        },
      ),
    );
  }

  Widget _buildChangeResultModeBtn() {
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: GetBuilder<SearchEventController>(
        builder: (controller) {
          return IconButton(
            icon: Icon(controller.showMapResult ? Icons.list : Icons.map, color:ConstantColor.white),
            onPressed: () => controller.changeModeResult(),
          );
        },
      ),
    );
  }

  Widget _buildResult(SearchEventController controller) {
    if (controller.searchEvent == null)
      return Center(
        child: Loader(),
      );
    if (controller.searchEvent.length == 0)
      return Center(
        child: Text(Localization.noEventTitle.tr, style: Get.textTheme.headline2,),
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
          return CardEvent(
            controller.searchEvent[index],
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 20,
            ),
          );
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
            dropdownColor: ConstantColor.primaryColor,
            value: controller.filter,
            icon: Icon(Icons.filter_list),
            iconSize: 24,
            elevation: 16,
            style: Get.textTheme.bodyText2,
            underline: Container(
              height: 2,
              color: ConstantColor.white,
            ),
            onChanged: (String filter) => controller.changeFilter(filter),
            items: controller.listFilter
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: Get.textTheme.bodyText2,),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
