import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/utils/constant_firestore.dart';
import 'package:esgi_project/screens/home.dart';
import 'package:esgi_project/screens/settings.dart';
import 'package:esgi_project/screens/map.dart';
import 'package:esgi_project/screens/ajout.dart';

class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomBar();
  }
}

class _BottomBar extends State<BottomBar> with TickerProviderStateMixin {
  List<Widget> _tabListNotOrga = [Map(), Home(), Settings()];

  List<Widget> _tabListOrga = [Map(), Home(), Ajout(), Settings()];

  List<String> _tabName = ['Map', 'Home', 'Ajout', 'Settings'];

  TabController _tabController;

  CollectionReference _docRef =
      Firestore.instance.collection(ConstantFirestore.collectionUser);
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _currentUser;

  Future<User> _getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await _docRef.document("${user.uid}").get().then((data) {
      _currentUser = User.fromDocument(data);
      // if (mounted) setState(() {
      // });
      print("****$_currentUser");
      // return _currentUser;
    });
    return _currentUser;
  }

  Widget scaffold(User user) {
    _tabController = TabController(
      initialIndex: 1,
      length: user.isOrganizer ? _tabListOrga.length : _tabListNotOrga.length,
      vsync: this,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColor.primaryColor,
        title: Text(_tabName[_tabController.index]),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: ConstantColor.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TabBarView(
          children: user.isOrganizer ? _tabListOrga : _tabListNotOrga,
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: ConstantColor.primaryColor,
        height: 60,
        backgroundColor: ConstantColor.white,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        buttonBackgroundColor: ConstantColor.primaryColor,
        items: <Widget>[
          Icon(
            Icons.map,
            size: 30,
            color: ConstantColor.white,
          ),
          Icon(
            Icons.home,
            size: 30,
            color: ConstantColor.white,
          ),
          if(user.isOrganizer)
          Icon(
            Icons.add,
            size: 30,
            color: ConstantColor.white,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: ConstantColor.white,
          ),
        ],
        onTap: (index) {
          // setState(() {
            _tabController.animateTo(index);
          // });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        //Permet d'empecher le retour
        onWillPop: () async => false,
        child: FutureBuilder(
          future: _getCurrentUser(),
          builder: (context, snap) {
            if (snap.hasData) {
              return scaffold(snap.data);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
