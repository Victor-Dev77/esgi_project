import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationService {
  static FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  static Future<Map<String, dynamic>> getLocation(
      {bool showDialogVerified: true}) async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Active Service Google
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    if (showDialogVerified) showDialogCheckLocation();
    Map<String, dynamic> map = {
      'location': {
        'latitude': _locationData.latitude,
        'longitude': _locationData.longitude,
      },
    };
    return map;
  }

  static showDialogCheckLocation() {
    Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * .25, vertical: Get.height * .4),
        child: Container(
          width: 150.0,
          height: 100.0,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.locationArrow,
                color: Colors.orange,
                size: 30,
              ),
              SizedBox(height: 20),
              Text(
                "Location Check",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
    Future.delayed(Duration(seconds: 2), () {
      if (Get.isDialogOpen) Get.back();
    });
  }

  static updateLocation(String idUser, {bool showDialogVerified: true}) async {
    Map _location = await getLocation(showDialogVerified: showDialogVerified);
    if (_location != null) {
      await _bddRepo.updateUserLocation(idUser, _location);
    } else {
      //TODO: snackbar pour afficher erreur refuser get location
    }
  }

  static Future<Coordinates> convertAddressToLocation(String address) async {
    // n° rue, codePostal ville
    //String addr = "36 rue de la manevrette, 77580 Guerard";
    try {
      var addresses = await Geocoder.local.findAddressesFromQuery(address);
      var first = addresses.first;
      print(
          "lat: ${first.coordinates.latitude} - lon: ${first.coordinates.longitude}");
      return first.coordinates;
    } catch (error) {
      return null;
    }
  }
}
