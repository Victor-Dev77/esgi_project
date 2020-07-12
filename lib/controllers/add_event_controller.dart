import 'dart:io';
import 'package:esgi_project/components/select_date.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:esgi_project/repositorys/firebase_storage_repository.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/services/location_service.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventController extends GetxController {
  static AddEventController get to => Get.find();

  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;
  FirebaseStorageRepository _storageRepo = FirebaseStorageRepository.to;

  Event _event;
  Event get event => this._event;

  bool _validForm = false;
  bool get validForm => this._validForm;

  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => this._titleController;

  final TextEditingController _contentController = TextEditingController();
  TextEditingController get contentController => this._contentController;

  final TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => this._addressController;

  Map _location = {};
  List<String> _pictureEvent;

  int _price = 0;
  int get price => this._price;
  final TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => this._priceController;

  final TextEditingController _beginDateController = TextEditingController();
  TextEditingController get beginDateController => this._beginDateController;
  final TextEditingController _endDateController = TextEditingController();
  TextEditingController get endDateController => this._endDateController;

  bool _categoryShow = false;
  bool get categoryShow => this._categoryShow;
  int _category = -1;
  int get category => this._category;
  final TextEditingController _categoryController = TextEditingController();
  TextEditingController get categoryController => this._categoryController;

  bool _isLoading = false;
  bool get isLoading => this._isLoading;

  @override
  void onInit() {
    super.onInit();
    _event = Event(
      id: "${UserController.to.user.id}-${DateTime.now().millisecondsSinceEpoch.toString()}",
      userId: UserController.to.user.id,
      userOrganizer: UserController.to.user,
      price: 0,
      preview: true,
    );
    _pictureEvent = [];
  }

  _validateForm() {
    _validForm = _checkValidAllFields();
    update();
  }

  bool _checkValidAllFields() {
    return _pictureEvent.length > 0 &&
        _addressController.text.trim() != "" &&
        _titleController.text.trim() != "" &&
        _contentController.text.trim() != "" &&
        _categoryController.text.trim() != "" &&
        _beginDateController.text != "" &&
        _endDateController.text != "";
  }

  String getPicture(int index) {
    if (index < 0 || index >= _pictureEvent.length) return null;
    return _pictureEvent[index];
  }

  addPicture(File file) {
    _pictureEvent.add(file.path);
    _validateForm();
  }

  deletePicture(File file) {
    _pictureEvent.remove(file.path);
    _validateForm();
  }

  changeValue() {
    _validateForm();
  }

  changePriceEvent(String price) {
    _price = int.parse(price);
    _validateForm();
  }

  setPriceFreeOrNotFree() {
    _price = (_price == 0) ? 1 : 0;
    _priceController.text = "$_price";
    update(["price"]);
  }

  bool priceIsFree() => _price == 0;

  setCategoryShow() {
    _categoryShow = !_categoryShow;
    update(["category"]);
  }

  setCategory(int value) {
    _category = value;
    _categoryController.text = Constant.category[value]["title"];
    update(["category"]);
    _validateForm();
  }


  selectBeginDate() async {
    await SelectDate.show(_beginDateController, endDate: _endDateController.text);
    _validateForm();
  }

  selectEndDate() async {
    await SelectDate.show(_endDateController, beginDate: _beginDateController.text);
    _validateForm();
  }

  _setFieldToEvent() {
    _event.title = _titleController.text.trim();
    _event.content = _contentController.text.trim();
    _event.address = _addressController.text.trim();
    _event.price = _price;
    _event.dateStart = _beginDateController.text;
    _event.dateEnd = _endDateController.text;
    _event.pictures = _pictureEvent;
    _event.category = (category != -1)
        ? Constant.category[category]["title"]
        : Localization.noCategory.tr;
    _event.location = _location;
  }

  goToPreview() {
    _setFieldToEvent();
    Get.toNamed(Router.eventDetailRoute, arguments: _event);
  }

  Future<bool> _checkAddress() async {
    // checker adresse en convertissant en coord gps => si pas possible alors addresse incorrect
    print("addresse: $_addressController");
    if (_addressController != "") {
      var location = await LocationService.convertAddressToLocation(
          _addressController.text.trim());
      if (location == null) {
        //show snackbar
        CustomSnackbar.snackbar(Localization.errorAddress.tr);
        return false;
      }
      print("valid address");
      Get.dialog(
        AlertDialog(
          title: Text(Localization.confirmAddressEvent.tr),
          content: Text(Localization.confirmAddressNameEvent
              .trArgs([location['address']])),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Get.back();
                return false;
              },
              child: Text(Localization.no.tr),
            ),
            FlatButton(
              onPressed: () {
                Get.back();
                _addressController.text = location['address'];
                _location = {
                  "latitude": location['location'].latitude,
                  "longitude": location['location'].longitude,
                };
                return true;
              },
              child: Text(Localization.yes.tr),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else
      return false;
  }

  addEvent() async {
    await _checkAddress();
    if (_location.isEmpty) return;
    _validForm = false;
    _isLoading = true;
    update();
    _setFieldToEvent();
    _event.pictures = [];
    await _uploadPictures();
    await _bddRepo.addEvent(_event.toMap());
    print("send to bdd");
    //TODO: check si pas erreur firebase
    _reinitFields();
  }

  _uploadPictures() async {
    List<String> urlPictures = [];
    for (int i = 0; i < _pictureEvent.length; i++) {
      String urlPicture = await _storageRepo.uploadPicture(
          UserController.to.user.id, _event.id, _pictureEvent[i]);
      if (urlPicture != null) {
        urlPictures.add(urlPicture);
      }
    }
    _event.pictures = urlPictures;
  }

  _reinitFields() {
    _validForm = false;
    List<String> listTmp = List()..addAll(_pictureEvent);
    listTmp.forEach((pic) {
      deletePicture(File(pic));
    });
    listTmp = [];
    _pictureEvent = [];
    _isLoading = false;
    update();
    _event = Event(
      id: _event.id,
      userId: UserController.to.user.id,
      userOrganizer: UserController.to.user,
      price: 0,
      preview: true,
    );
    _titleController.text = "";
    _contentController.text = "";
    _addressController.text = "";
    _location = {};
    _price = 0;
    _priceController.text = "";
    _beginDateController.text = "";
    _endDateController.text = "";
    _categoryShow = false;
    _category = -1;
    _categoryController.text = "";
    update(["price"]);
    update(["category"]);
    update();
  }
}
