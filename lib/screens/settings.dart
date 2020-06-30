import 'package:esgi_project/components/dialog_list_language.dart';
import 'package:esgi_project/controllers/auth_controller.dart';
import 'package:esgi_project/controllers/my_event_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant.dart';
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
            _buildWelcomeTitle(),
            SizedBox(height: 20.0),
            _buildFavoriteBtn(),
            _buildMyEventBtn(),
            Spacer(),
            _buildLanguageBtn(),
            _buildLogoutBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTitle() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(25),
      child: Text(
        Localization.welcomeTitle.trArgs([UserController.to.user.pseudo]),
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFavoriteBtn() {
    return GetBuilder<UserController>(
      builder: (controller) {
        return CardSettings(
          text: Localization.myFavoriteTitle
              .trArgs([controller.favorites.length.toString()]),
          onTap: () => Get.toNamed(Router.myFavoriteRoute),
        );
      },
    );
  }

  Widget _buildMyEventBtn() {
    if (UserController.to.user.isOrganizer)
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: GetBuilder<MyEventController>(
          init: MyEventController(),
          builder: (controller) {
            return CardSettings(
              text: Localization.myEventsTitle.trArgs([
                controller.myEvents == null
                    ? "0"
                    : controller.myEvents.length.toString()
              ]),
              onTap: () => Get.toNamed(Router.myEventsRoute),
            );
          },
        ),
      );
    return Container();
  }

  Widget _buildLanguageBtn() {
    return CardSettings(
      text: Localization.languageTitle.tr,
      onTap: _showDialogLanguage,
    );
  }

  Widget _buildLogoutBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: CardSettings(
        text: Localization.logout.tr,
        onTap: () => AuthController.to.signOut(),
      ),
    );
  }

  _showDialogLanguage() {
    Get.dialog(
      Dialog(
        child: DialogListLanguage(
          listLanguages: Constant.languages,
        ),
      ),
    );
  }
}
