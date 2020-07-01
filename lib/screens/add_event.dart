import 'package:esgi_project/components/card_add_image.dart';
import 'package:esgi_project/components/custom_textfield.dart';
import 'package:esgi_project/controllers/add_event_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEvent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildPreviewBtn(),
                  _buildTitleScreen(),
                  Container(
                    height: 115.0,
                    child: _buildImageGridEvent(),
                  ),
                  _buildTitleField(),
                  _buildContentField(),
                  _buildTypeEventField(),
                  _buildAddressField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: _buildDateBeginField(),
                      ),
                      Expanded(
                        child: _buildDateEndField(),
                      ),
                    ],
                  ),
                  _buildPriceField(),
                  _buildBtnAddEvent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 5, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () => AddEventController.to.goToPreview(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleScreen() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Text(
        Localization.explainAddEventForm.tr,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTitleField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        suffixIcon: Icon(Icons.event_note),
        hintText: Localization.nameEvent.tr,
        onChanged: (value) => AddEventController.to.changeTitleEvent(value),
      ),
    );
  }

  Widget _buildContentField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        suffixIcon: Icon(Icons.event_note),
        hintText: Localization.descriptionEvent.tr,
        onChanged: (value) => AddEventController.to.changeContentEvent(value),
      ),
    );
  }

  Widget _buildTypeEventField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: CustomTextField(
            controller: AddEventController.to.categoryController,
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            hintText: Localization.typeEvent.tr,
            readOnly: true,
            onTap: () => AddEventController.to.setCategoryShow(),
          ),
        ),
        GetBuilder<AddEventController>(
          id: "category",
          builder: (controller) {
            if (controller.categoryShow)
              return Container(
                color: Colors.grey[100],
                child: ListView.builder(
                  itemCount: Constant.category.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RadioListTile(
                        value: index,
                        groupValue: controller.category,
                        title: Text(
                          Constant.category[index]["title"],
                          style: TextStyle(fontSize: 16),
                        ),
                        onChanged: (val) => controller.setCategory(val));
                  },
                ),
              );
            return Container();
          },
        ),
      ],
    );
  }

  Widget _buildAddressField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        suffixIcon: Icon(Icons.pin_drop),
        hintText: Localization.addressEvent.tr,
        onChanged: (value) => AddEventController.to.changeAddressEvent(value),
      ),
    );
  }

  Widget _buildDateBeginField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        controller: AddEventController.to.beginDateController,
        readOnly: true,
        suffixIcon: Icon(Icons.calendar_today),
        hintText: Localization.beginDateEvent.tr,
        onTap: () => AddEventController.to
            .selectDateEvent(AddEventController.to.beginDateController),
      ),
    );
  }

  Widget _buildDateEndField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        controller: AddEventController.to.endDateController,
        readOnly: true,
        suffixIcon: Icon(Icons.calendar_today),
        hintText: Localization.endDateEvent.tr,
        onTap: () => AddEventController.to
            .selectDateEvent(AddEventController.to.endDateController),
      ),
    );
  }

  Widget _buildPriceField() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GetBuilder<AddEventController>(
        id: "price",
        builder: (controller) {
          return Row(
            children: <Widget>[
              Text(Localization.priceTitle.tr),
              SizedBox(width: 10),
              if (controller.price != 0)
                Container(
                  padding: EdgeInsets.only(right: 20, bottom: 10),
                  width: 100,
                  child: CustomTextField(
                    controller: controller.priceController,
                    keyboardType: TextInputType.number,
                    suffixIcon: Icon(Icons.euro_symbol),
                    onChanged: (value) => controller.changePriceEvent(value),
                  ),
                ),
              GestureDetector(
                onTap: () => controller.setPriceFreeOrNotFree(),
                child: Row(
                  children: <Widget>[
                    Text(
                      Localization.freeTitle.tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Checkbox(
                      value: controller.priceIsFree(),
                      onChanged: (value) => controller.setPriceFreeOrNotFree(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageGridEvent() {
    return GetBuilder<AddEventController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CardAddImage(
              image: controller.getPicture(0),
              imageLoad: (file) => controller.addPicture(file),
              imageRemove: (file) => controller.deletePicture(file),
            ),
            CardAddImage(
              image: controller.getPicture(1),
              imageLoad: (file) => controller.addPicture(file),
              imageRemove: (file) => controller.deletePicture(file),
            ),
            CardAddImage(
              image: controller.getPicture(2),
              imageLoad: (file) => controller.addPicture(file),
              imageRemove: (file) => controller.deletePicture(file),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBtnAddEvent() {
    return Padding(
      padding: EdgeInsets.all(32),
      child: GetBuilder<AddEventController>(
        builder: (controller) {
          return InkWell(
            onTap: () => controller.validForm ? controller.addEvent() : null,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    controller.validForm ? Colors.blueGrey : Colors.grey,
                    controller.validForm ? Colors.blue : Colors.grey
                  ],
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  Localization.addEvent.tr,
                  style: TextStyle(
                      color: controller.validForm
                          ? Colors.white
                          : Colors.grey[100],
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
