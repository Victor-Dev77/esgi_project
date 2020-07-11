import 'package:esgi_project/components/select_date.dart';
import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {

  Map<String, dynamic> _changeValues = {};

  RxInt _distance = 0.obs;
  int get distance => this._distance.value;
  
  RxList<String> _listCategory = List<String>().obs;
  List<String> get listCategory => this._listCategory.value;

  final Rx<Object> _dateController = TextEditingController().obs;
  TextEditingController get dateController => this._dateController.value;


  addCategory(String category) => _listCategory.add(category);
  
  deleteCategory(String category) => _listCategory.remove(category);

  changeDistance(double distance) => _distance.value = distance.round();

  showDate() async {
    await SelectDate.show(_dateController.value);
  }
  
  saveSearch() {
    if (dateController.value.text != "")
      _changeValues["date"] = dateController.text;
    _changeValues["category"] = listCategory;
    _changeValues["distance"] = distance;
    SearchEventController.to.searchQueryEvent(_changeValues);
  }

}