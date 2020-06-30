import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {

  Map<String, dynamic> _changeValues = {};

  RxInt _distance = 0.obs;
  int get distance => this._distance.value;
  
  RxList<String> _listCategory = List<String>().obs;
  List<String> get listCategory => this._listCategory.value;

  final TextEditingController _dateController = TextEditingController();
  TextEditingController get dateController => this._dateController;


  addCategory(String category) => _listCategory.add(category);
  
  deleteCategory(String category) => _listCategory.remove(category);

  changeDistance(double distance) => _distance.value = distance.round();
  
  saveSearch() {
    if (_dateController.text != "")
      _changeValues["date"] = dateController.text;
    _changeValues["category"] = listCategory;
    _changeValues["distance"] = distance;
    SearchEventController.to.searchQueryEvent(_changeValues);
  }

}