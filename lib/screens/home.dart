import 'package:esgi_project/components/card_category.dart';
import 'package:esgi_project/components/card_search.dart';
import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/screens/search.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.slidersH),
              onPressed: () {
                // N'utilise pas Get car Get.bottomSheet a une hauteur limité et je veux que le bottomsheet ait la hauteur de l'écran

                //Get.bottomSheet(Search());
                _scaffoldKey.currentState
                    .showBottomSheet((context) => Search());
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildAllEventCategory(),
              _buildPopularEvents(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllEventCategory() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            Localization.allEventTitle.tr,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 15),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Constant.category.length,
              itemBuilder: (context, index) {
                Map data = Constant.category[index];
                return CardCategory(
                    iconData: data["icon"], title: data["title"]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularEvents() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                Localization.popularEventTitle.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                child: GetBuilder<SearchEventController>(
                  builder: (controller) {
                    if (controller.popularEvent == null)
                      return Center(child: CircularProgressIndicator());
                    if (controller.popularEvent.length == 0)
                      return Center(child: Text(Localization.noEventTitle.tr));
                    return ListView.builder(
                      itemCount: controller.popularEvent.length,
                      itemBuilder: (context, index) {
                        return CardSearchEvent(controller.popularEvent[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
