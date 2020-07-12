import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esgi_project/controllers/squeleton_controller.dart';
import 'package:flutter/material.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:get/get.dart';

class AppSqueleton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppSqueleton();
  }
}

class _AppSqueleton extends State<AppSqueleton> with TickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: SqueletonController.to.tabMenu.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ConstantColor.white,
        height: Get.height,
        width: Get.width,
        child: TabBarView(
          children: SqueletonController.to.tabMenu,
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  CurvedNavigationBar _buildBottomNavBar() {
    return CurvedNavigationBar(
      color: ConstantColor.white,
      height: 60,
      backgroundColor: ConstantColor.backgroundColor,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      buttonBackgroundColor: ConstantColor.white,
      items: SqueletonController.to.listItemNav,
      onTap: (index) {
        setState(() {
          _tabController.animateTo(index);
        });
      },
    );
  }
}
