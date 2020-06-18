import 'package:esgi_project/components/card_category.dart';
import 'package:esgi_project/components/card_event_horizontal.dart';
import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User _currentUser;
  List<Map<String, dynamic>> _listPopularEvents;
  List<Map<String, dynamic>> _listCategoryEvents;

  @override
  void initState() {
    super.initState();
    _currentUser = Constant.currentUser;
    _initData();
  }

  _initData() {
    _listPopularEvents = [
      {
        "id": "1",
        "title": "Club Night",
        "date": "15 Jun. 2020 01:00",
        "images": [],
        "location": {
          "latitude": 42.01214,
          "longitude": 8.014421,
        },
        "content": "Party Night at ESGI ! Coming Soon...",
        "price": 0,
      },
      {
        "id": "2",
        "title": "Bar ESGI",
        "date": "17 Jul. 2020 16:30",
        "images": [],
        "location": {
          "latitude": 42.01214,
          "longitude": 8.014421,
        },
        "content": "Bar at ESGI ! So coool",
        "price": 10,
      },
      {
        "id": "3",
        "title": "Afterwork ESGI",
        "date": "12 Jun. 2020 20:15",
        "images": [],
        "location": {
          "latitude": 42.01214,
          "longitude": 8.014421,
        },
        "content": "Come on at the best afterwork of Paname !",
        "price": 5,
      },
      {
        "id": "4",
        "title": "A Fucking Boom",
        "date": "15 Jun. 2020 01:00",
        "images": [],
        "location": {
          "latitude": 42.01214,
          "longitude": 8.014421,
        },
        "content": "Full Alcohol, full girls, no sleep !",
        "price": 100,
      },
      {
        "id": "5",
        "title": "New Year 2021",
        "date": "31 Dec. 2020 01:00",
        "images": [],
        "location": {
          "latitude": 42.01214,
          "longitude": 8.014421,
        },
        "content": "Celebrate the new year at ESGI !",
        "price": 0,
      },
    ];

    _listCategoryEvents = [
      {
        "title": "Bar",
        "icon": Icon(Icons.local_drink),
        "color": Colors.orange,
      },
      {
        "title": "Discothèque",
        "icon": Icon(Icons.android),
        "color": Colors.lightBlue,
      },
      {
        "title": "Concert",
        "icon": Icon(Icons.local_movies),
        "color": Colors.purple,
      },
    ];
  }

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
              SizedBox(height: 50,),
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
            icon: Icon(Icons.more_horiz),
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
                Map data = _listCategoryEvents[index];
                return CardCategory(data);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularEvents() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Popular Events"),
          SizedBox(height: 20),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                Map data = _listPopularEvents[index];
                return EventCardHorizontal(data);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyEvents() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Nearby Events"),
          SizedBox(height: 20),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                Map data = _listPopularEvents[index];
                return EventCardHorizontal(data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
