import 'package:esgi_project/components/chip_category.dart';
import 'package:esgi_project/components/dialog_list_category.dart';
import 'package:esgi_project/controllers/add_event_controller.dart';
import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Map<String, dynamic> changeValues = {};
  int _distance = 0;
  List<String> _listCategory = [];
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _modalSearch();
  }

  _saveSearch() {
    print("save");
    print("$_distance km, $_listCategory, ${_dateController.text}");
    if (_dateController.text != "")
      changeValues["date"] = _dateController.text;
    changeValues["category"] = _listCategory;
    changeValues["distance"] = _distance;
    SearchEventController.to.searchQueryEvent(changeValues);
  }

  Widget _modalSearch() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ConstantColor.primaryColor,
            ConstantColor.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Column(
        children: <Widget>[
          _buildAppBarModal(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildBlocDate(),
                _buildBlocCategory(),
                _buildBlocDistance(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarModal() {
    return InkWell(
      onTap: () => Get.back(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Icon(FontAwesomeIcons.chevronDown),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              Localization.filterTitle.tr,
              style: TextStyle(
                fontFamily: 'AvenirNextDemiBold',
                fontSize: 18,
              ),
            ),
          ),
          InkWell(
            onTap: () => _saveSearch(),
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 20),
              child: Icon(FontAwesomeIcons.check),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlocDate() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 20),
      child: TextField(
          readOnly: true,
          onTap: () {
            AddEventController.to.selectDateEvent(_dateController);
          },
          controller: _dateController,
          style: TextStyle(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today),
              hintText: Localization.dateEvent.tr,
              labelStyle: TextStyle(fontWeight: FontWeight.w400))),
    );
  }

  Widget _buildBlocCategory() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(Localization.typeEvent.tr, style: TextStyle(fontSize: 16),),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.plusCircle,
                      color: Colors.grey[800],
                    ),
                    onPressed: _showDialogCategory,
                  )
                ],
              ),
              if (_listCategory.length > 0)
                Container(
                  // color: Colors.green,
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: List.generate(
                      _listCategory.length,
                      (index) => ChipCategory(
                        category: _listCategory[index],
                        onDeleteCategory: (category) {
                          setState(() {
                            _listCategory.remove(category);
                          });
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  _showDialogCategory() {
    Get.dialog(Dialog(
        child: DialogListCategory(
      listCategorySelected: _listCategory,
      onCategorySelected: (category) {
        setState(() {
          _listCategory.add(category);
        });
      },
      onCategoryUnselected: (category) {
        setState(() {
          _listCategory.remove(category);
        });
      },
    )));
  }

  Widget _buildBlocDistance() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Localization.distanceEvent.tr,
                style: TextStyle(fontSize: 16),
              ),
              if (_distance > 0)
                Text(
                  "$_distance km",
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Slider(
            onChanged: (value) {
              setState(() {
                _distance = value.round();
              });
            },
            value: _distance.toDouble(),
            max: 100.0,
            min: 0.0,
            inactiveColor: Colors.grey,
            activeColor: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
