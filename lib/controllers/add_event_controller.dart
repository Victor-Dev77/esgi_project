import 'dart:io';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventController extends GetController {
  static AddEventController get to => Get.find();

  Event _event;
  //Event get event => this._event;

  bool _validForm = false;
  bool get validForm => this._validForm;

  String _title = "";
  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => this._titleController;

  String _content = "";
  final TextEditingController _contentController = TextEditingController();
  TextEditingController get contentController => this._contentController;

  String _address = "";
  final TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => this._addressController;

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

  @override
  void onInit() {
    super.onInit();
    _event = Event(
      userId: UserController.to.user.id,
      userOrganizer: UserController.to.user,
      price: 0,
      preview: true,
    );
    _pictureEvent = [];
  }

  bool _checkValidAllFields() {
    return true;
  }

  String getPicture(int index) {
    if (index < 0 || index >= _pictureEvent.length) return null;
    return _pictureEvent[index];
  }

  addPicture(File file) {
    _pictureEvent.add(file.path);
  }

  deletePicture(File file) {
    _pictureEvent.remove(file.path);
  }

  changeTitleEvent(String title) {
    _title = title;
  }

  changeContentEvent(String content) {
    _content = content;
  }

  changeAddressEvent(String address) {
    _address = address;
  }

  changePriceEvent(String price) {
    _price = int.parse(price);
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
  }

  selectDateEvent(TextEditingController editingController) async {
    if (GetPlatform.isAndroid) {
      String date = await _selectDateAndroid();
      if (date != null) {
        editingController.text = date;
      }
    } else if (GetPlatform.isIOS) {
      _selectDateIOS(callback: (date) {
        editingController.text = date;
      });
    }
  }

  Future<String> _selectDateAndroid() async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: Get.overlayContext,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day),
      locale: Locale('fr', 'FR'),
    );
    if (picked != null) {
      TimeOfDay time = await _selectTime();
      DateTime date = picked
          .toLocal()
          .add(Duration(hours: time.hour, minutes: time.minute));
      return parseDateTime(date.toLocal(), 'dd/MM/yyyy HH:mm');
    }
    return null;
  }

  Future<TimeOfDay> _selectTime() async {
    TimeOfDay t = await showTimePicker(
        context: Get.overlayContext, initialTime: TimeOfDay.now());
    if (t != null) return t;
    return TimeOfDay.now();
  }

  _selectDateIOS({@required Function(String) callback}) {
    final now = DateTime.now();
    Get.bottomSheet(
        SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            initialDateTime: now,
            minimumDate: now,
            maximumDate: DateTime(now.year + 1, now.month, now.day),
            use24hFormat: true,
            backgroundColor: ConstantColor.white,
            onDateTimeChanged: (date) {
              callback(parseDateTime(date.toLocal(), 'dd/MM/yyyy HH:mm'));
            },
          ),
        ),
        isDismissible: true);
  }

  goToPreview() {
    _event.title = _title;
    _event.content = _content;
    _event.address = _address;
    _event.price = _price;
    _event.dateStart = _beginDateController.text;
    _event.dateEnd = _endDateController.text;
    _event.pictures = _pictureEvent;
    /*_event.category = (category != -1)
        ? Constant.category[category]["title"]
        : "Aucune catégorie";*/
    Get.toNamed(Router.eventDetailRoute, arguments: _event);
  }
}
