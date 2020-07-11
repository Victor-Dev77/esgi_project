import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:esgi_project/repositorys/firebase_storage_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEventController extends GetxController {
  static MyEventController get to => Get.find();

  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;
  FirebaseStorageRepository _storageRepo = FirebaseStorageRepository.to;

  List<Event> _myEvents = [];
  List<Event> get myEvents => this._myEvents;

  @override
  void onInit() async {
    super.onInit();
    _myEvents = await _bddRepo.getMyEvents(UserController.to.user.id);
    update();
  }

  deleteEvent(Event event) {
    Get.dialog(_showDialogDeleteEvent(event));
  }

  Widget _showDialogDeleteEvent(Event event) {
    if (GetPlatform.isIOS)
      return _alertDialogIOS(event);
    return _alertDialogAndroid(event);
  }

  Widget _alertDialogAndroid(Event event) {
    return AlertDialog(
      title: Text(Localization.deleteEventTitle.tr),
      content: Text(Localization.confirmDeleteEvent.tr),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Get.back(),
          child: Text(Localization.no.tr),
        ),
        FlatButton(
          onPressed: () => _confirmDeleteEvent(event),
          child: Text(Localization.yes.tr),
        ),
      ],
    );
  }

  Widget _alertDialogIOS(Event event) {
    return CupertinoAlertDialog(
      title: Text(Localization.deleteEventTitle.tr),
      content: Text(Localization.confirmDeleteEvent.tr),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(Localization.yes.tr),
          onPressed: () => _confirmDeleteEvent(event),
        ),
        CupertinoDialogAction(
          onPressed: () => Get.back(),
          child: Text(Localization.no.tr),
        )
      ],
    );
  }

  _confirmDeleteEvent(Event event) async {
    Get.back();
    _myEvents.removeWhere((elem) => elem.id == event.id);
    await _bddRepo.deleteEvent(event.id);
    await _storageRepo.deleteEvent(
      idUser: UserController.to.user.id,
      idDoc: event.id,
      pictures: event.pictures,
    );
    update();
  }

}
