import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/screens/home.dart';
import 'package:esgi_project/screens/settings.dart';
import 'package:esgi_project/screens/map.dart';
import 'package:esgi_project/screens/add_event.dart';
import 'package:get/get.dart';

class AppSqueleton extends StatefulWidget {
  
 // bool isOrganizer = true;
 // AppSqueleton({this.isOrganizer: true});

  @override
  State<StatefulWidget> createState() {
    return _AppSqueleton();
  }
}

class _AppSqueleton extends State<AppSqueleton> with TickerProviderStateMixin {
  List<Widget> _tabListNotOrga = [Home(), Map(), Settings()];

  List<Widget> _tabListOrga = [Home(), Map(), AddEvent(), Settings()];

  List<String> _tabNameNotOrga = ['Home', 'Map', 'Settings'];
  List<String> _tabNameOrga = ['Home', 'Map', 'Add', 'Settings'];

  TabController _tabController;
  bool isOrganizer = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: isOrganizer ? _tabListOrga.length : _tabListNotOrga.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tabController.index != 0 ? AppBar(
        backgroundColor: ConstantColor.primaryColor,
        title: Text(isOrganizer
            ? _tabNameOrga[_tabController.index]
            : _tabNameNotOrga[_tabController.index]),
        automaticallyImplyLeading: false,
      ) : null,
      body: Container(
        color: ConstantColor.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TabBarView(
          children: isOrganizer ? _tabListOrga : _tabListNotOrga,
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  CurvedNavigationBar _buildBottomNavBar() {
    return CurvedNavigationBar(
      color: ConstantColor.primaryColor,
      height: 60,
      backgroundColor: ConstantColor.white,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      buttonBackgroundColor: ConstantColor.primaryColor,
      items: <Widget>[
        Constant.homeIcon,
        Constant.mapIcon,
        if (isOrganizer) Constant.addEventIcon,
        Constant.settingsIcon,
      ],
      onTap: (index) {
        setState(() {
          _tabController.animateTo(index);
        });
      },
    );
  }
}
