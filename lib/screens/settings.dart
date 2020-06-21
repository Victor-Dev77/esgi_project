import 'package:esgi_project/controllers/auth_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:esgi_project/components/card_settings.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(25),
            child: Text(
              "Vous-revoilà, " + UserController.to.user.pseudo + " 😉",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20.0),
          CardSettings(
            text: "Mes réservations",
            onTap: () {
              print("Salut");
            },
          ),
          SizedBox(height: 20.0),
          CardSettings(
            text: "Mes favoris - ${UserController.to.favorites.length}",
            onTap: () {
              print("Salut 2");
            },
          ),
          if (UserController.to.user.isOrganizer)
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CardSettings(
                text: "Mes événements",
                onTap: () => Get.toNamed(Router.myEventsRoute),
              ),
            ),
          Spacer(),
          CardSettings(
            text: "déconnexion",
            onTap: () {
              AuthController.to.signOut();
            },
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
