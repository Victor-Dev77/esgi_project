import 'package:esgi_project/components/card_add_image.dart';
import 'package:esgi_project/components/custom_textfield.dart';
import 'package:esgi_project/controllers/add_event_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEvent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantColor.backgroundColor,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: GetBuilder<AddEventController>(
                  builder: (controller) {
                    return Column(
                      children: <Widget>[
                        _buildPreviewBtn(),
                        _buildTitleScreen(),
                        Container(
                          height: 115.0,
                          child: _buildImageGridEvent(controller),
                        ),
                        _buildTitleField(controller),
                        _buildContentField(controller),
                        _buildTypeEventField(),
                        _buildAddressField(controller),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: _buildDateBeginField(controller),
                            ),
                            Expanded(
                              child: _buildDateEndField(controller),
                            ),
                          ],
                        ),
                        _buildPriceField(),
                        _buildBtnAddEvent(controller),
                      ],
                    );
                  },
                ),
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
            icon: Icon(Icons.remove_red_eye, color: ConstantColor.white,),
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
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ConstantColor.white),
      ),
    );
  }

  Widget _buildTitleField(AddEventController controller) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        controller: controller.titleController,
        suffixIcon: Icon(Icons.event_note, color: ConstantColor.white),
        hintText: Localization.nameEvent.tr,
        onChanged: (value) => controller.changeValue(),
      ),
    );
  }

  Widget _buildContentField(AddEventController controller) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        controller: controller.contentController,
        suffixIcon: Icon(Icons.event_note, color: ConstantColor.white),
        hintText: Localization.descriptionEvent.tr,
        onChanged: (value) => controller.changeValue(),
      ),
    );
  }

  Widget _buildTypeEventField() {
    return GetBuilder<AddEventController>(
      id: "category",
      builder: (controller) {
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: CustomTextField(
                controller: controller.categoryController,
                suffixIcon: Icon(Icons.keyboard_arrow_down, color: ConstantColor.white),
                hintText: Localization.typeEvent.tr,
                readOnly: true,
                onTap: () => controller.setCategoryShow(),
              ),
            ),
            if (controller.categoryShow)
              Container(
                color: ConstantColor.white,
                child: ListView.builder(
                  itemCount: Constant.category.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      activeColor: ConstantColor.backgroundColor,
                      value: index,
                      groupValue: controller.category,
                      title: Text(
                        Constant.category[index]["title"],
                        style: TextStyle(fontSize: 16),
                      ),
                      onChanged: (val) => controller.setCategory(val),
                    );
                  },
                ),
              )
          ],
        );
      },
    );
  }

  Widget _buildAddressField(AddEventController controller) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        controller: controller.addressController,
        suffixIcon: Icon(Icons.pin_drop, color: ConstantColor.white),
        hintText: Localization.addressEvent.tr,
        onChanged: (value) => controller.changeValue(),
      ),
    );
  }

  Widget _buildDateBeginField(AddEventController controller) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        controller: controller.beginDateController,
        readOnly: true,
        suffixIcon: Icon(Icons.calendar_today, color: ConstantColor.white),
        hintText: Localization.beginDateEvent.tr,
        onTap: () => controller.selectDateEvent(controller.beginDateController),
      ),
    );
  }

  Widget _buildDateEndField(AddEventController controller) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: CustomTextField(
        controller: controller.endDateController,
        readOnly: true,
        suffixIcon: Icon(Icons.calendar_today, color: ConstantColor.white),
        hintText: Localization.endDateEvent.tr,
        onTap: () => controller.selectDateEvent(controller.endDateController),
      ),
    );
  }

  Widget _buildPriceField() {
    return GetBuilder<AddEventController>(
      id: "price",
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Text(Localization.priceTitle.tr, style:TextStyle(color: ConstantColor.white)),
              SizedBox(width: 10),
              if (controller.price != 0)
                Container(
                  padding: EdgeInsets.only(right: 20, bottom: 10),
                  width: 100,
                  child: CustomTextField(
                    controller: controller.priceController,
                    keyboardType: TextInputType.number,
                    suffixIcon: Icon(Icons.euro_symbol, color: ConstantColor.white),
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
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ConstantColor.white),
                    ),
                    Checkbox(
                      value: controller.priceIsFree(),
                      onChanged: (value) => controller.setPriceFreeOrNotFree(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageGridEvent(AddEventController controller) {
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
  }

  Widget _buildBtnAddEvent(AddEventController controller) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: InkWell(
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
                  color: controller.validForm ? Colors.white : Colors.grey[100],
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
