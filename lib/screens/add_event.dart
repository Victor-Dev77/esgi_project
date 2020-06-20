import 'package:esgi_project/components/card_add_image.dart';
import 'package:esgi_project/controllers/add_event_controller.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 5, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () => AddEventController.to.goToPreview(),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  "Rejoignez nous en ajoutant votre Event ! Il sera visible auprès de tous ! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 115.0,
                //width: 300.0,
                child: _buildImageGridEvent(),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    controller: AddEventController.to.titleController,
                    onChanged: (value) =>
                        AddEventController.to.changeTitleEvent(value),
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.event_note),
                        hintText: "Nom de l'évènement",
                        labelText: "Nom de l'évènement",
                        labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    controller: AddEventController.to.contentController,
                    onChanged: (value) =>
                        AddEventController.to.changeContentEvent(value),
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.event_note),
                        hintText: "Description de l'évènement",
                        labelText: "Description de l'évènement",
                        labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    onTap: () => AddEventController.to.setCategoryShow(),
                    controller: AddEventController.to.categoryController,
                    readOnly: true,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        hintText: "Type d'évènement",
                        labelStyle: TextStyle(fontWeight: FontWeight.w400))),
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
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                    controller: AddEventController.to.addressController,
                    onChanged: (value) =>
                        AddEventController.to.changeAddressEvent(value),
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.pin_drop),
                        hintText: "Adresse l'évènement",
                        labelText: "Adresse de l'évènement",
                        labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                          readOnly: true,
                          onTap: () => AddEventController.to.selectDateEvent(
                              AddEventController.to.beginDateController),
                          controller: AddEventController.to.beginDateController,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              hintText: "Date de début",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w400))),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                          readOnly: true,
                          onTap: () => AddEventController.to.selectDateEvent(
                              AddEventController.to.endDateController),
                          controller: AddEventController.to.endDateController,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              hintText: "Date de fin",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: GetBuilder<AddEventController>(
                  id: "price",
                  // init: AddEventController(),
                  builder: (controller) {
                    return Row(
                      children: <Widget>[
                        Text("Prix: "),
                        SizedBox(width: 10),
                        if (controller.price != 0)
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            width: 100,
                            child: TextField(
                              controller: controller.priceController,
                              onChanged: (value) =>
                                  controller.changePriceEvent(value),
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.euro_symbol),
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () => controller.setPriceFreeOrNotFree(),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "GRATUIT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Checkbox(
                                value: controller.priceIsFree(),
                                onChanged: (value) =>
                                    controller.setPriceFreeOrNotFree(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              _buildBtnAddEvent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGridEvent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CardAddImage(
          image: AddEventController.to.getPicture(0),
          imageLoad: (file) => AddEventController.to.addPicture(file),
          imageRemove: (file) => AddEventController.to.deletePicture(file),
        ),
        CardAddImage(
          image: AddEventController.to.getPicture(1),
          imageLoad: (file) => AddEventController.to.addPicture(file),
          imageRemove: (file) => AddEventController.to.deletePicture(file),
        ),
        CardAddImage(
          image: AddEventController.to.getPicture(2),
          imageLoad: (file) => AddEventController.to.addPicture(file),
          imageRemove: (file) => AddEventController.to.deletePicture(file),
        ),
      ],
    );
  }

  Widget _buildBtnAddEvent() {
    return Padding(
      padding: EdgeInsets.all(32),
      child: GetBuilder<AddEventController>(
        builder: (controller) {
          return InkWell(
            onTap: () => controller.validForm ? print("ADD EVENT") : null,
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
                  "AJOUTER",
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
