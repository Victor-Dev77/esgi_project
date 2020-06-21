import 'package:esgi_project/components/card_category.dart';
import 'package:esgi_project/components/card_event_horizontal.dart';
import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //TODO: Transformer fonction en widget stateless / statefull SI UTILISER AUTRE PART DANS APP
              _buildSearchPref(),
              _buildSearchBar(),
              _buildAllEventCategory(),
              _buildPopularEvents(),
              _buildNearbyEvents(),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchPref() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.slidersH),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
        padding: EdgeInsets.only(bottom: 10, left: 25, right: 25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xfff4f6f5),
          ),
          height: 50,
          child: ListTile(
            leading: Icon(Icons.search),
            title: Text("Search"),
          ),
        ));
  }

  Widget _buildAllEventCategory() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("All Events"),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {},
              ),
            ],
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
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
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 25, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Popular Events",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Container(
            height: 100,
            child: GetBuilder<SearchEventController>(
              builder: (controller) {
                if (controller.popularEvent == null)
                  return Center(child: CircularProgressIndicator());
                if (controller.popularEvent.length == 0)
                  return Center(child: Text("Aucun événements !"));
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.popularEvent.length,
                  itemBuilder: (context, index) {
                    return EventCardHorizontal(controller.popularEvent[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyEvents() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 25, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Nearby Events",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Container(
            height: 100,
            child: GetBuilder<SearchEventController>(
              builder: (controller) {
                if (controller.popularEvent == null)
                  return Center(child: CircularProgressIndicator());
                if (controller.popularEvent.length == 0)
                  return Center(child: Text("Aucun événements !"));
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.popularEvent.length,
                  itemBuilder: (context, index) {
                    return EventCardHorizontal(controller.popularEvent[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
