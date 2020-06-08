import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  User _currentUser;
  
  @override
  void initState() {
    super.initState();
    _currentUser = Constant.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(_currentUser != null ? _currentUser.pseudo : "Chargement"),
            )
          ],
        ),
      ),
    );
  }
}
