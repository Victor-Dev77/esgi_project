import 'package:esgi_project/components/card_add_image.dart';
import 'package:esgi_project/utils/functions.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  List<String> _imageEvent = [];
  String name = "";
  String content = "";
  String place = "";
  int price = 0;
  TextEditingController _beginDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
                    onChanged: (value) => name = value,
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
                    onChanged: (value) => content = value,
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
                    onChanged: (value) => place = value,
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
                          onTap: () async {
                            String date = await _selectDate(context);
                            if (date != null) {
                              setState(() {
                                _beginDateController.text = date;
                              });
                            }
                          },
                          controller: _beginDateController,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              hintText: "Date de début",
                              labelText: "Date de début",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w400))),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                          readOnly: true,
                          onTap: () async {
                            String date = await _selectDate(context);
                            if (date != null) {
                              setState(() {
                                _endDateController.text = date;
                              });
                            }
                          },
                          controller: _endDateController,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              hintText: "Date de fin",
                              labelText: "Date de fin",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w400))),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Text("Prix: "),
                    SizedBox(width: 10),
                    (price != 0) ? 
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      width: 100,
                      child: TextField(
                        controller: _priceController,
                        onChanged: (value) {
                          setState(() {
                            price = int.parse(value);
                          });
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.euro_symbol),)
                      ),
                    ) : Container(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          price = (price == 0) ? 1 : 0;
                          _priceController.text = "$price";
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            "GRATUIT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Checkbox(
                            value: price == 0,
                            onChanged: (value) {
                              setState(() {
                                price = value ? 0 : 1;
                                _priceController.text = "$price";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
          imageLoad: (file) {
            _imageEvent.add(file.path);
          },
          imageRemove: (file) {
            _imageEvent.remove(file.path);
          },
        ),
        CardAddImage(
          imageLoad: (file) {
            _imageEvent.add(file.path);
          },
          imageRemove: (file) {
            _imageEvent.remove(file.path);
          },
        ),
        CardAddImage(
          imageLoad: (file) {
            _imageEvent.add(file.path);
          },
          imageRemove: (file) {
            _imageEvent.remove(file.path);
          },
        ),
      ],
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    //TODO: checker plateform et faire datepicker pour IOS
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day),
      locale: Locale('fr', 'FR'),
    );
    if (picked != null) {
      TimeOfDay time = await _selectTime(context);
      DateTime date = picked
          .toLocal()
          .add(Duration(hours: time.hour, minutes: time.minute));
      return parseDateTime(date.toLocal(), 'dd/MM/yyyy HH:mm');
    }
    return null;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    TimeOfDay t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t != null) return t;
    return TimeOfDay.now();
  }

  Widget _buildBtnAddEvent() {
    return Padding(
      padding: EdgeInsets.all(32),
      child: InkWell(
        onTap: () {
          print("ADD EVENT");
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.blueGrey, Colors.blue],
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              "AJOUTER",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
