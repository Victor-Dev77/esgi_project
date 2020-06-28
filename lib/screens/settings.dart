import 'package:esgi_project/controllers/auth_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:esgi_project/components/card_settings.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(25),
              child: Text(
                Localization.welcomeTitle.trArgs([UserController.to.user.pseudo]),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0),
            CardSettings(
              text: Localization.myBookingsTitle.tr,
              onTap: () {
                print("Salut");
              },
            ),
            SizedBox(height: 20.0),
            GetBuilder<UserController>(
              builder: (controller) {
                return CardSettings(
                  text: Localization.myFavoriteTitle.trArgs([controller.favorites.length.toString()]),
                  onTap: () => Get.toNamed(Router.myFavoriteRoute),
                );
              },
            ),
            if (UserController.to.user.isOrganizer)
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CardSettings(
                  text: Localization.myEventsTitle.tr,
                  onTap: () => Get.toNamed(Router.myEventsRoute),
                ),
              ),
            Spacer(),
            CardSettings(
              text: Localization.logout.tr,
              onTap: () {
                AuthController.to.signOut();
              },
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
