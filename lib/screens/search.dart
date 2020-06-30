import 'package:esgi_project/components/chip_category.dart';
import 'package:esgi_project/components/dialog_list_category.dart';
import 'package:esgi_project/controllers/add_event_controller.dart';
import 'package:esgi_project/controllers/filter_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  final FilterController controller = FilterController();

  @override
  Widget build(BuildContext context) {
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
            onTap: () => controller.saveSearch(),
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
            AddEventController.to.selectDateEvent(controller.dateController);
          },
          controller: controller.dateController,
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
                  Text(
                    Localization.typeEvent.tr,
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.plusCircle,
                      color: Colors.grey[800],
                    ),
                    onPressed: _showDialogCategory,
                  )
                ],
              ),
              Obx(
                () => Container(
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: List.generate(
                      controller.listCategory.length,
                      (index) => ChipCategory(
                        category: controller.listCategory[index],
                        onDeleteCategory: (category) =>
                            controller.deleteCategory(category),
                      ),
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
    Get.dialog(
      Dialog(
        child: DialogListCategory(
          listCategorySelected: controller.listCategory,
          onCategorySelected: (category) => controller.addCategory(category),
          onCategoryUnselected: (category) =>
              controller.deleteCategory(category),
        ),
      ),
    );
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
              Obx(() {
                if (controller.distance > 0)
                  return Text(
                    "${controller.distance} km",
                    style: TextStyle(fontSize: 16),
                  );
                return Container();
              }),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Obx(
            () => Slider(
              onChanged: (value) => controller.changeDistance(value),
              value: controller.distance.toDouble(),
              max: 100.0,
              min: 0.0,
              inactiveColor: Colors.grey,
              activeColor: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
