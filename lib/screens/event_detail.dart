import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  Event event;
  bool _error;

  @override
  void initState() {
    super.initState();
    event = Get.arguments as Event;
    _error = (event == null);
  }

  @override
  Widget build(BuildContext context) {
    return _checkError();
  }

  Scaffold _checkError() {
    if (_error) return _buildError();
    return _buildScreen();
  }

  Scaffold _buildError() {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("ERREUR: manque parametre event"),
        ),
      ),
    );
  }

  Scaffold _buildScreen() {
    //TODO: rendre code propre - separer dans des fonction ou widget
    return Scaffold(
      appBar: AppBar(
        title: Text('SLIVER APPBAR ici - photo + titre'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.green,
                height: MediaQuery.of(context).size.height * 0.65,
                child: _buildPictureBloc(),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  event.title == "" ? "Aucun titre" : event.title,
                  style: TextStyle(
                    fontWeight:
                        event.title == "" ? FontWeight.normal : FontWeight.bold,
                    fontStyle:
                        event.title == "" ? FontStyle.italic : FontStyle.normal,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.date_range, color: Colors.orange),
                        SizedBox(width: 5),
                        Text(event.dateStart == ""
                            ? "Aucune date de début"
                            : event.dateStart),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.date_range, color: Colors.orange),
                        SizedBox(width: 5),
                        Text(event.dateEnd == ""
                            ? "Aucune date de fin"
                            : event.dateEnd),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.place, color: Colors.blueAccent),
                    SizedBox(width: 5),
                    Text(event.address == ""
                        ? "Aucune adresse"
                        : event.address),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  event.content == "" ? "Aucune description" : event.content,
                  style: TextStyle(
                    fontStyle: event.content == ""
                        ? FontStyle.italic
                        : FontStyle.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text("Prix: "),
                    SizedBox(width: 10),
                    Text(
                      event.price == 0 ? "GRATUIT" : "${event.price}€",
                      style: TextStyle(
                        fontWeight: event.price == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPictureBloc() {
    if (event.pictures.length == 0) {
      return Center(
        child: Text("Il n'y a aucune photo !"),
      );
    }
    return Swiper(
      key: UniqueKey(),
      physics: ScrollPhysics(),
      loop: false,
      //index: indexPicture,
      itemCount: event.pictures.length,
      /* onIndexChanged: (index) {
                    indexPicture = index;
                  },*/
      itemBuilder: (BuildContext context, int index) {
        return _buildPictureImage(index);
      },
      pagination: SwiperCustomPagination(builder: (context, config) {
        return _buildCustomPagination(config);
      }),
    );
  }

  Widget _buildPictureImage(int index) {
    if (event.preview) {
      File file = File(event.pictures[index]);
      return Image.file(file, fit: BoxFit.cover);
    }
    return CachedNetworkImage(
      imageUrl: event.pictures[index],
      fit: BoxFit.cover,
      useOldImageOnUrlChange: true,
      placeholder: (context, url) => CupertinoActivityIndicator(
        radius: 20,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _buildCustomPagination(SwiperPluginConfig config) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 8, left: 25, right: 25),
        child: Row(
          children: List.generate(
            6,
            (index) => Expanded(
              child: Container(
                height: 3,
                margin: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: config.activeIndex == index
                      ? ConstantColor.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
